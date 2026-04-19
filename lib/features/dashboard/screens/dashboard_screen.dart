import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/trade_action.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../shared/widgets/empty_state_widget.dart';
import '../../sync/screens/sync_status_widget.dart';
import '../../trades/domain/trade_model.dart';
import '../providers/dashboard_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(dashboardSummaryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('주식 노트'),
        actions: const [SyncStatusChip()],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(dashboardSummaryProvider.future),
        child: summaryAsync.when(
          loading: () =>
              const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('오류: $e')),
          data: (summary) => summary.recentTrades.isEmpty
              ? EmptyStateWidget(
                  message: '매매 기록이 없습니다.\n+ 버튼을 눌러 첫 거래를 기록하세요.',
                  icon: Icons.receipt_long_outlined,
                  action: FilledButton.icon(
                    onPressed: () => context.push('/trades/new'),
                    icon: const Icon(Icons.add),
                    label: const Text('매매 기록 추가'),
                  ),
                )
              : CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: _SummaryCard(
                        buyAmount: summary.totalBuyAmount,
                        sellAmount: summary.totalSellAmount,
                        startDate: summary.startDate,
                        endDate: summary.endDate,
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverList.separated(
                        itemCount: summary.recentTrades.length,
                        separatorBuilder: (_, __) =>
                            const Divider(height: 1),
                        itemBuilder: (ctx, i) =>
                            _TradeListItem(trade: summary.recentTrades[i]),
                      ),
                    ),
                    const SliverPadding(
                        padding: EdgeInsets.only(bottom: 80)),
                  ],
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/trades/new'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.buyAmount,
    required this.sellAmount,
    required this.startDate,
    required this.endDate,
  });

  final double buyAmount;
  final double sellAmount;
  final DateTime startDate;
  final DateTime endDate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final stockColors = context.stockColors;
    final net = buyAmount - sellAmount;

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${toDisplayDate(startDate)} ~ ${toDisplayDate(endDate)}',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _AmountTile(
                    label: '총 매수',
                    amount: buyAmount,
                    color: stockColors.buyColor,
                  ),
                ),
                Expanded(
                  child: _AmountTile(
                    label: '총 매도',
                    amount: sellAmount,
                    color: stockColors.sellColor,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('순 투자금액', style: theme.textTheme.bodyMedium),
                Text(
                  formatKrw(net),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: net >= 0 ? stockColors.buyColor : stockColors.sellColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AmountTile extends StatelessWidget {
  const _AmountTile({
    required this.label,
    required this.amount,
    required this.color,
  });

  final String label;
  final double amount;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: color,
                )),
        const SizedBox(height: 4),
        Text(
          formatKrw(amount),
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _TradeListItem extends StatelessWidget {
  const _TradeListItem({required this.trade});
  final TradeModel trade;

  @override
  Widget build(BuildContext context) {
    final stockColors = context.stockColors;
    final isBuy = trade.action == TradeAction.buy;
    final color = isBuy ? stockColors.buyColor : stockColors.sellColor;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: color.withValues(alpha:0.1),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: color.withValues(alpha:0.4)),
            ),
            child: Text(
              trade.action.label,
              style: TextStyle(
                fontSize: 11,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              trade.tickerName,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            formatKrw(trade.totalAmount),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
      subtitle: Text(
        '${toDisplayDate(trade.tradeDate)}  ${trade.accountName ?? ''}',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
      ),
      onTap: () => context.push('/trades/${trade.id}'),
    );
  }
}
