import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/date_formatter.dart';
import '../../auth/providers/auth_provider.dart';
import '../../sync/domain/sync_state.dart';
import '../../sync/providers/sync_provider.dart';
import '../../../shared/widgets/confirm_dialog.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(authStateProvider);
    final syncState = ref.watch(syncControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('설정')),
      body: ListView(
        children: [
          // 계정 정보 섹션
          userAsync.when(
            loading: () => const ListTile(title: Text('로딩 중...')),
            error: (_, __) => const SizedBox(),
            data: (user) => user != null
                ? ListTile(
                    leading: user.photoUrl != null
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(user.photoUrl!))
                        : const CircleAvatar(child: Icon(Icons.person)),
                    title: Text(user.displayName ?? user.email),
                    subtitle: Text(user.email),
                  )
                : const SizedBox(),
          ),
          const Divider(),

          // 동기화 섹션
          _SectionHeader('Google Drive 동기화'),
          ListTile(
            leading: const Icon(Icons.sync),
            title: const Text('지금 동기화'),
            subtitle: _SyncSubtitle(syncState: syncState),
            trailing: IconButton(
              icon: const Icon(Icons.cloud_upload_outlined),
              onPressed: () =>
                  ref.read(syncControllerProvider.notifier).performCheckIn(),
            ),
          ),
          if (syncState is SyncLocked)
            ListTile(
              leading: const Icon(Icons.lock_open),
              title: const Text('Lock 강제 해제'),
              subtitle: const Text('다른 기기의 세션이 남아있을 때 사용'),
              onTap: () => ref
                  .read(syncControllerProvider.notifier)
                  .forceReleaseLock(),
            ),
          const Divider(),

          // 계좌 관리 섹션
          _SectionHeader('계좌 관리'),
          ListTile(
            leading: const Icon(Icons.account_balance),
            title: const Text('계좌 관리'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/settings/accounts'),
          ),
          const Divider(),

          // 앱 정보
          _SectionHeader('앱 정보'),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('버전'),
            trailing: Text('1.0.0'),
          ),
          const Divider(),

          // 로그아웃
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('로그아웃',
                style: TextStyle(color: Colors.red)),
            onTap: () => _signOut(context, ref),
          ),
        ],
      ),
    );
  }

  Future<void> _signOut(BuildContext context, WidgetRef ref) async {
    final confirmed = await showConfirmDialog(
      context,
      title: '로그아웃',
      content: '로그아웃하면 다음 실행 시 다시 로그인이 필요합니다.\n로컬 데이터는 유지됩니다.',
      confirmLabel: '로그아웃',
    );
    if (confirmed) {
      await ref.read(authRepositoryProvider).signOut();
    }
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}

class _SyncSubtitle extends StatelessWidget {
  const _SyncSubtitle({required this.syncState});
  final SyncState syncState;

  @override
  Widget build(BuildContext context) {
    final text = switch (syncState) {
      SyncIdle(:final lastSyncedAt) => lastSyncedAt != null
          ? '마지막 동기화: ${toDisplayDate(lastSyncedAt)}'
          : '동기화 기록 없음',
      SyncCheckingOut() => '데이터 다운로드 중...',
      SyncUploading() => '업로드 중...',
      SyncSuccess(:final syncedAt) =>
        '동기화 완료: ${toDisplayDate(syncedAt)}',
      SyncOffline() => '오프라인 상태',
      SyncError(:final message) => '오류: $message',
      SyncLocked(:final lockCreatedAt) =>
        '잠김 (${toDisplayDate(lockCreatedAt)} 부터)',
    };
    return Text(text);
  }
}
