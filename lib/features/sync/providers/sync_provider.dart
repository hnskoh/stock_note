import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/providers/auth_provider.dart';
import '../data/drive_repository.dart';
import '../domain/sync_state.dart';

final driveRepositoryProvider = Provider<DriveRepository>((ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  return DriveRepository(authRepo);
});

class SyncController extends StateNotifier<SyncState> {
  SyncController() : super(const SyncState.idle());

  // TODO(oauth): OAuth 활성화 시 Ref 파라미터 복구, no-op 메서드들을 Drive API 호출 코드로 교체
  Future<void> performCheckOut() async {
    state = const SyncState.idle();
  }

  Future<void> performCheckIn() async {
    state = const SyncState.idle();
  }

  Future<void> forceReleaseLock() async {
    state = const SyncState.idle();
  }
}

final syncControllerProvider =
    StateNotifierProvider<SyncController, SyncState>(
  (_) => SyncController(),
);
