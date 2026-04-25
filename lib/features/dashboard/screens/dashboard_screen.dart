import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/trade_action.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../shared/widgets/empty_state_widget.dart';
import '../../trades/domain/trade_model.dart';
import '../providers/dashboard_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final period = ref.watch(dashboardPeriodProvider);
    final dataAsync = ref.watch(dashboardDataProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('주식 노트')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(dashboardDataProvider.future),
        child: dataAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('오류: $e')),
          data: (data) => CustomScrollView(
            slivers: [
              // 기간 선택
              SliverToBoxAdapter(
                child: _PeriodSelector(selected: period),
              ),
              // 요약 카드
              SliverToBoxAdapter(
                child: _SummaryCard(data: data),
              ),
              // 종목별 현황
              if (data.tickerSummaries.isNotEmpty) ...[
                _SectionHeader('종목별 현황'),
                SliverList.separated(
                  itemCount: data.tickerSummaries.length,
                  separatorBuilder: (_, __) =>
                      const Divider(height: 1, indent: 16, endIndent: 16),
                  itemBuilder: (_, i) =>
                      _TickerRow(summary: data.tickerSummaries[i]),
                ),
              ],
              // 최근 거래
              _SectionHeader('최근 거래 (전체 기준)'),
              if (data.recentTrades.isEmpty)
                SliverToBoxAdapter(
                  child: EmptyStateWidget(
                    message: '매매 기록이 없습니다.\n+ 버튼을 눌러 첫 거래를 기록하세요.',
                    icon: Icons.receipt_long_outlined,
                    action: FilledButton.icon(
                      onPressed: () => context.push('/trades/new'),
                      icon: const Icon(Icons.add),
                      label: const Text('매매 기록 추가'),
                    ),
                  ),
                )
              else
                SliverList.separated(
                  itemCount: data.recentTrades.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (_, i) =>
                      _TradeListItem(trade: data.recentTrades[i]),
                ),
              const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
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

// ── 기간 선택 칩 ───────────────────────────────────────────
class _PeriodSelector extends ConsumerWidget {
  const _PeriodSelector({required this.selected});
  final DashboardPeriod selected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        spacing: 8,
        children: DashboardPeriod.values.map((p) {
          final isSelected = p == selected;
          return FilterChip(
            label: Text(p.label),
            selected: isSelected,
            onSelected: (_) =>
                ref.read(dashboardPeriodProvider.notifier).state = p,
          );
        }).toList(),
      ),
    );
  }
}

// ── 요약 카드 ──────────────────────────────────────────────
class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.data});
  final DashboardData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final stockColors = context.stockColors;
    final net = data.netAmount;
    final netColor = net >= 0 ? stockColors.sellColor : stockColors.buyColor;

    return Card(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.period == DashboardPeriod.all
                  ? '전체 기간'
                  : '최근 ${data.period.label}',
              style: theme.textTheme.labelSmall
                  ?.copyWith(color: theme.colorScheme.outline),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _AmountTile(
                    label: '총 매수',
                    amount: data.totalBuyAmount,
                    color: stockColors.buyColor,
                  ),
                ),
                Expanded(
                  child: _AmountTile(
                    label: '총 매도',
                    amount: data.totalSellAmount,
                    color: stockColors.sellColor,
                  ),
                ),
              ],
            ),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  net >= 0 ? '순 실현손익' : '순 투자금액',
                  style: theme.textTheme.bodyMedium,
                ),
                Text(
                  (net >= 0 ? '+' : '') + formatKrw(net),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: netColor,
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
  const _AmountTile(
      {required this.label, required this.amount, required this.color});
  final String label;
  final double amount;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: color)),
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

// ── 종목별 행 ──────────────────────────────────────────────
class _TickerRow extends StatelessWidget {
  const _TickerRow({required this.summary});
  final TickerSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final stockColors = context.stockColors;
    final net = summary.netAmount;
    final hasReturn = summary.hasSell && summary.totalBuyAmount > 0;
    final returnColor = net >= 0 ? stockColors.sellColor : stockColors.buyColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          // 종목명 + 거래 횟수
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  summary.tickerName,
                  style: theme.textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  [
                    if (summary.buyCount > 0) '매수 ${summary.buyCount}회',
                    if (summary.sellCount > 0) '매도 ${summary.sellCount}회',
                  ].join('  '),
                  style: theme.textTheme.labelSmall
                      ?.copyWith(color: theme.colorScheme.outline),
                ),
              ],
            ),
          ),
          // 금액 + 수익률
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                (net >= 0 ? '+' : '') + formatKrw(net),
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: hasReturn ? returnColor : null,
                ),
              ),
              if (hasReturn)
                Text(
                  '${summary.returnRate >= 0 ? '+' : ''}${summary.returnRate.toStringAsFixed(1)}%',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: returnColor,
                    fontWeight: FontWeight.w600,
                  ),
                )
              else
                Text(
                  '매수 ${formatKrw(summary.totalBuyAmount)}',
                  style: theme.textTheme.labelSmall
                      ?.copyWith(color: theme.colorScheme.outline),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── 섹션 헤더 ──────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Text(
          title,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
      ),
    );
  }
}

// ── 최근 거래 아이템 ───────────────────────────────────────
class _TradeListItem extends StatelessWidget {
  const _TradeListItem({required this.trade});
  final TradeModel trade;

  @override
  Widget build(BuildContext context) {
    final stockColors = context.stockColors;
    final isBuy = trade.action == TradeAction.buy;
    final color = isBuy ? stockColors.buyColor : stockColors.sellColor;

    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            trade.action.label,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      title: Text(
        trade.tickerName,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        '${toDisplayDate(trade.tradeDate)}  ${trade.accountName ?? ''}',
        style: TextStyle(
          fontSize: 12,
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
      trailing: Text(
        formatKrw(trade.totalAmount),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      onTap: () => context.push('/trades/${trade.id}'),
    );
  }
}
