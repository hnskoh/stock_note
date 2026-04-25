import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/trade_action.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../shared/widgets/confirm_dialog.dart';
import '../data/trade_repository.dart';
import '../domain/trade_model.dart';
import '../providers/trade_provider.dart';

final _tradeByIdProvider =
    FutureProvider.family<TradeModel?, String>((ref, id) {
  return ref.watch(tradeRepositoryProvider).getById(id);
});

class TradeDetailScreen extends ConsumerWidget {
  const TradeDetailScreen({required this.tradeId, super.key});
  final String tradeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tradeAsync = ref.watch(_tradeByIdProvider(tradeId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('매매 상세'),
        actions: [
          tradeAsync.maybeWhen(
            data: (trade) => trade != null
                ? IconButton(
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: () =>
                        context.push('/trades/$tradeId/edit'),
                  )
                : const SizedBox.shrink(),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: tradeAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('오류: $e')),
        data: (trade) {
          if (trade == null) {
            return const Center(child: Text('기록을 찾을 수 없습니다.'));
          }

          final stockColors = context.stockColors;
          final isBuy = trade.action == TradeAction.buy;
          final color =
              isBuy ? stockColors.buyColor : stockColors.sellColor;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: color.withValues(alpha: 0.4)),
                        ),
                        child: Text(
                          trade.action.label,
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        trade.tickerName,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        formatKrw(trade.totalAmount),
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                              color: color,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Column(
                  children: [
                    _DetailRow('매매일', toDisplayDate(trade.tradeDate)),
                    const Divider(height: 1),
                    _DetailRow('계좌', trade.accountName ?? '-'),
                    const Divider(height: 1),
                    _DetailRow('수량', '${formatQuantity(trade.quantity)}주'),
                    const Divider(height: 1),
                    _DetailRow('단가', formatKrw(trade.price)),
                    const Divider(height: 1),
                    _DetailRow('수수료', formatKrw(trade.fee)),
                    const Divider(height: 1),
                    _DetailRow('총 금액', formatKrw(trade.totalAmount),
                        isBold: true),
                  ],
                ),
              ),
              if (trade.note?.isNotEmpty == true) ...[
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '매매 사유 / 메모',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                color:
                                    Theme.of(context).colorScheme.outline,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(trade.note!),
                      ],
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              OutlinedButton.icon(
                onPressed: () => _delete(context, ref, trade.id!),
                icon: const Icon(Icons.delete_outline),
                label: const Text('삭제'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _delete(
      BuildContext context, WidgetRef ref, String id) async {
    final confirmed = await showConfirmDialog(
      context,
      title: '매매 기록 삭제',
      content: '이 매매 기록을 삭제하시겠습니까?',
      confirmLabel: '삭제',
      isDangerous: true,
    );
    if (confirmed && context.mounted) {
      await ref.read(tradeRepositoryProvider).delete(id);
      ref.invalidate(filteredTradesProvider);
      if (context.mounted) context.pop();
    }
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow(this.label, this.value, {this.isBold = false});
  final String label;
  final String value;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.outline)),
          Text(
            value,
            style: isBold
                ? const TextStyle(fontWeight: FontWeight.bold)
                : null,
          ),
        ],
      ),
    );
  }
}
