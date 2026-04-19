import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/confirm_dialog.dart';
import '../../../shared/widgets/empty_state_widget.dart';
import '../data/account_repository.dart';
import '../domain/account_model.dart';
import '../providers/account_provider.dart';

class AccountListScreen extends ConsumerWidget {
  const AccountListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountsAsync = ref.watch(allAccountListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('계좌 관리')),
      body: accountsAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('오류: $e')),
        data: (accounts) => accounts.isEmpty
            ? EmptyStateWidget(
                message: '등록된 계좌가 없습니다.',
                icon: Icons.account_balance_outlined,
                action: FilledButton.icon(
                  onPressed: () => context.push('/settings/accounts/new'),
                  icon: const Icon(Icons.add),
                  label: const Text('계좌 추가'),
                ),
              )
            : ListView.separated(
                itemCount: accounts.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (ctx, i) => _AccountItem(
                  account: accounts[i],
                  onEdit: () =>
                      ctx.push('/settings/accounts/${accounts[i].id}/edit'),
                  onDelete: () => _deleteAccount(ctx, ref, accounts[i]),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/settings/accounts/new'),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _deleteAccount(
      BuildContext context, WidgetRef ref, Account account) async {
    final tradeCount = await ref
        .read(accountRepositoryProvider)
        .getTradeCount(account.id!);

    if (!context.mounted) return;

    final message = tradeCount > 0
        ? '이 계좌에 $tradeCount건의 거래 기록이 있습니다.\n계좌를 비활성화하시겠습니까? (거래 기록은 보존됩니다.)'
        : '계좌 "${account.name}"을 삭제하시겠습니까?';

    final confirmed = await showConfirmDialog(
      context,
      title: tradeCount > 0 ? '계좌 비활성화' : '계좌 삭제',
      content: message,
      confirmLabel: tradeCount > 0 ? '비활성화' : '삭제',
      isDangerous: true,
    );

    if (confirmed && context.mounted) {
      await ref
          .read(accountRepositoryProvider)
          .deleteOrDeactivate(account.id!);
      ref.invalidate(accountListProvider);
      ref.invalidate(allAccountListProvider);
    }
  }
}

class _AccountItem extends StatelessWidget {
  const _AccountItem({
    required this.account,
    required this.onEdit,
    required this.onDelete,
  });

  final Account account;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: account.isActive
            ? Theme.of(context).colorScheme.primaryContainer
            : Theme.of(context).colorScheme.surfaceContainerHighest,
        child: Text(
          account.name.isNotEmpty ? account.name[0] : '?',
          style: TextStyle(
            color: account.isActive
                ? Theme.of(context).colorScheme.onPrimaryContainer
                : Theme.of(context).colorScheme.outline,
          ),
        ),
      ),
      title: Text(
        account.name,
        style: TextStyle(
          color: account.isActive
              ? null
              : Theme.of(context).colorScheme.outline,
          decoration:
              account.isActive ? null : TextDecoration.lineThrough,
        ),
      ),
      subtitle: Text(account.typeLabel ?? account.type),
      trailing: PopupMenuButton<String>(
        itemBuilder: (_) => [
          const PopupMenuItem(value: 'edit', child: Text('수정')),
          const PopupMenuItem(value: 'delete', child: Text('삭제')),
        ],
        onSelected: (v) {
          if (v == 'edit') onEdit();
          if (v == 'delete') onDelete();
        },
      ),
    );
  }
}
