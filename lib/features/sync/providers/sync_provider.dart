import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_provider.dart';
import '../../auth/providers/auth_provider.dart';
import '../data/drive_repository.dart';
import '../domain/sync_state.dart';

final driveRepositoryProvider = Provider<DriveRepository>((ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  return DriveRepository(authRepo);
});

class SyncController extends StateNotifier<SyncState> {
  SyncController(this._ref) : super(const SyncState.idle());

  final Ref _ref;

  Future<void> performCheckOut() async {
    state = const SyncState.checkingOut();
    try {
      final driveRepo = _ref.read(driveRepositoryProvider);
      final result = await driveRepo.checkOut(
        onBeforeDbWrite: kIsWeb ? _closeDb : null,
      );
      if (kIsWeb) {
        _ref.invalidate(databaseProvider);
        await _ref.read(databaseProvider.future);
      }
      state = result;
    } catch (e) {
      state = SyncState.error(message: e.toString());
    }
  }

  Future<void> _closeDb() async {
    final db = await _ref.read(databaseProvider.future);
    await db.close();
  }

  Future<void> performCheckIn() async {
    state = const SyncState.uploading();
    try {
      final driveRepo = _ref.read(driveRepositoryProvider);
      await driveRepo.checkIn();
      state = SyncState.success(syncedAt: DateTime.now());
    } catch (e) {
      state = SyncState.error(message: e.toString());
    }
  }

  Future<void> forceReleaseLock() async {
    try {
      final driveRepo = _ref.read(driveRepositoryProvider);
      await driveRepo.releaseLock();
      state = const SyncState.idle();
    } catch (e) {
      state = SyncState.error(message: e.toString());
    }
  }
}

final syncControllerProvider =
    StateNotifierProvider<SyncController, SyncState>(
  (ref) => SyncController(ref),
);
