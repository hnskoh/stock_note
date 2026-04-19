import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io' as io;

import '../../../core/constants/app_constants.dart';
import '../../../core/error/app_exception.dart';
import '../../auth/data/auth_repository.dart';
import '../domain/sync_state.dart';

class DriveRepository {
  DriveRepository(this._authRepository);

  final AuthRepository _authRepository;

  // ------------------------------------------------------------------ //
  //  Public API
  // ------------------------------------------------------------------ //

  /// Check-out: Drive에서 DB를 가져와 로컬에 적용
  Future<SyncState> checkOut({Future<void> Function()? onBeforeDbWrite}) async {
    final api = await _getDriveApi();

    // 1. Lock 파일 확인
    final lockFile = await _findFile(api, AppConstants.driveLockFileName);
    if (lockFile != null) {
      final created = DateTime.tryParse(
            lockFile.createdTime?.toIso8601String() ?? '',
          ) ??
          DateTime.now();
      final age = DateTime.now().difference(created);
      if (age.inHours < AppConstants.lockExpiryHours) {
        return SyncState.locked(lockCreatedAt: created);
      }
      // 만료된 lock 삭제
      await _safeDelete(api, lockFile.id!);
    }

    // 2. Lock 파일 생성
    await _createLockFile(api);

    // 3. Drive에서 DB 파일 검색
    final dbFile = await _findFile(api, AppConstants.driveDbFileName);
    if (dbFile == null) {
      // 신규 사용자: 로컬 DB 그대로 사용
      return const SyncState.idle();
    }

    // 4. 수정 시간 비교
    final driveModifiedTime = dbFile.modifiedTime;
    final localSyncedAt = await _getLastSyncedAt();

    if (driveModifiedTime != null &&
        (localSyncedAt == null ||
            driveModifiedTime.isAfter(localSyncedAt))) {
      // Drive가 최신 → 다운로드
      await onBeforeDbWrite?.call();
      await _downloadDb(api, dbFile.id!);
    }

    return SyncState.idle(lastSyncedAt: localSyncedAt);
  }

  /// Check-in: 로컬 DB를 Drive에 업로드
  Future<void> checkIn() async {
    final api = await _getDriveApi();
    await _uploadDb(api);
    await _deleteLockFile(api);
    await _setLastSyncedAt(DateTime.now());
  }

  /// Lock 파일만 삭제 (강제 해제 시 사용)
  Future<void> releaseLock() async {
    final api = await _getDriveApi();
    await _deleteLockFile(api);
  }

  // ------------------------------------------------------------------ //
  //  Private helpers
  // ------------------------------------------------------------------ //

  Future<drive.DriveApi> _getDriveApi() async {
    final client = await _authRepository.getAuthClient();
    if (client == null) throw const AuthException();
    return drive.DriveApi(client);
  }

  Future<drive.File?> _findFile(drive.DriveApi api, String name) async {
    try {
      final result = await api.files.list(
        spaces: AppConstants.driveAppDataFolder,
        q: "name = '$name' and trashed = false",
        $fields: 'files(id, name, modifiedTime, createdTime)',
      );
      final files = result.files;
      if (files == null || files.isEmpty) return null;
      return files.first;
    } catch (e) {
      throw DriveException('Drive 파일 검색 실패: $e');
    }
  }

  Future<void> _downloadDb(drive.DriveApi api, String fileId) async {
    try {
      final response = await api.files.get(
        fileId,
        downloadOptions: drive.DownloadOptions.fullMedia,
      ) as drive.Media;

      final bytes = await _collectStream(response.stream);

      if (kIsWeb) {
        await _writeWebDb(bytes);
      } else {
        final path = await _getLocalDbPath();
        await io.File(path).writeAsBytes(bytes);
      }
    } catch (e) {
      throw DriveException('DB 다운로드 실패: $e');
    }
  }

  Future<void> _uploadDb(drive.DriveApi api) async {
    try {
      final bytes = kIsWeb ? await _readWebDb() : await _readLocalDb();
      final stream = Stream.value(bytes);
      final media = drive.Media(stream, bytes.length);

      final existing = await _findFile(api, AppConstants.driveDbFileName);
      if (existing != null) {
        await api.files.update(drive.File(), existing.id!,
            uploadMedia: media);
      } else {
        final driveFile = drive.File()
          ..name = AppConstants.driveDbFileName
          ..parents = [AppConstants.driveAppDataFolder];
        await api.files.create(driveFile, uploadMedia: media);
      }
    } catch (e) {
      throw DriveException('DB 업로드 실패: $e');
    }
  }

  Future<void> _createLockFile(drive.DriveApi api) async {
    try {
      final lockMeta = drive.File()
        ..name = AppConstants.driveLockFileName
        ..parents = [AppConstants.driveAppDataFolder];
      final emptyStream = Stream<List<int>>.value([]);
      await api.files.create(lockMeta,
          uploadMedia: drive.Media(emptyStream, 0));
    } catch (_) {
      // lock 생성 실패는 치명적이지 않음
    }
  }

  Future<void> _deleteLockFile(drive.DriveApi api) async {
    final lockFile = await _findFile(api, AppConstants.driveLockFileName);
    if (lockFile != null) {
      await _safeDelete(api, lockFile.id!);
    }
  }

  Future<void> _safeDelete(drive.DriveApi api, String fileId) async {
    try {
      await api.files.delete(fileId);
    } catch (_) {}
  }

  Future<DateTime?> _getLastSyncedAt() async {
    // db_metadata 테이블에서 읽기 (DB가 열려있어야 함)
    // DriveRepository는 Database에 직접 접근하지 않고
    // 파일 시스템의 DB 파일 수정 시간으로 대체
    if (kIsWeb) return null;
    final path = await _getLocalDbPath();
    final file = io.File(path);
    if (!file.existsSync()) return null;
    return file.lastModifiedSync();
  }

  Future<void> _setLastSyncedAt(DateTime dt) async {
    // 업로드 성공 후 로컬 파일 수정 시간이 자동 갱신됨
    // Web의 경우 별도 처리 불필요
  }

  Future<String> _getLocalDbPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return join(dir.path, AppConstants.dbFileName);
  }

  Future<Uint8List> _collectStream(Stream<List<int>> stream) async {
    final chunks = await stream.toList();
    final total = chunks.fold<int>(0, (sum, c) => sum + c.length);
    final result = Uint8List(total);
    var offset = 0;
    for (final chunk in chunks) {
      result.setRange(offset, offset + chunk.length, chunk);
      offset += chunk.length;
    }
    return result;
  }

  Future<Uint8List> _readLocalDb() async {
    final path = await _getLocalDbPath();
    return io.File(path).readAsBytes();
  }

  Future<void> _writeWebDb(Uint8List bytes) async {
    await databaseFactory.writeDatabaseBytes(AppConstants.dbFileName, bytes);
  }

  Future<Uint8List> _readWebDb() async {
    return databaseFactory.readDatabaseBytes(AppConstants.dbFileName);
  }
}
