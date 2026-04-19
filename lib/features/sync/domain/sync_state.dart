import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_state.freezed.dart';

@freezed
sealed class SyncState with _$SyncState {
  const factory SyncState.idle({DateTime? lastSyncedAt}) = SyncIdle;
  const factory SyncState.checkingOut() = SyncCheckingOut;
  const factory SyncState.uploading() = SyncUploading;
  const factory SyncState.success({required DateTime syncedAt}) = SyncSuccess;
  const factory SyncState.offline() = SyncOffline;
  const factory SyncState.error({required String message}) = SyncError;
  const factory SyncState.locked({required DateTime lockCreatedAt}) = SyncLocked;
}
