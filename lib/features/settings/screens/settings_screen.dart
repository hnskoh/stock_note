import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../auth/providers/auth_provider.dart';
import '../../../shared/widgets/confirm_dialog.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(authStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('설정')),
      body: ListView(
        children: [
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
          _SectionHeader('계좌 관리'),
          ListTile(
            leading: const Icon(Icons.account_balance),
            title: const Text('계좌 관리'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/settings/accounts'),
          ),
          const Divider(),
          _SectionHeader('앱 정보'),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('버전'),
            trailing: Text('1.0.0'),
          ),
          const Divider(),
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
      content: '로그아웃하시겠습니까?',
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
