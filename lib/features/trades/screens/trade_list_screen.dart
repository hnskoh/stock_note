import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/trade_action.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../shared/widgets/confirm_dialog.dart';
import '../../../shared/widgets/empty_state_widget.dart';
import '../../accounts/providers/account_provider.dart';
import '../data/trade_repository.dart';
import '../domain/trade_model.dart';
import '../providers/trade_provider.dart';

class TradeListScreen extends ConsumerStatefulWidget {
  const TradeListScreen({super.key});

  @override
  ConsumerState<TradeListScreen> createState() => _TradeListScreenState();
}

class _TradeListScreenState extends ConsumerState<TradeListScreen> {
  final _tickerController = TextEditingController();

  @override
  void dispose() {
    _tickerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(tradeFilterNotifierProvider);
    final tradesAsync = ref.watch(filteredTradesProvider);
    final accountsAsync = ref.watch(accountListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('매매 기록'),
        actions: [
          if (filter.hasActiveFilter)
            IconButton(
              icon: const Icon(Icons.filter_alt_off),
              tooltip: '필터 초기화',
              onPressed: () {
                _tickerController.clear();
                ref.read(tradeFilterNotifierProvider.notifier).reset();
              },
            ),
        ],
      ),
      body: Column(
        children: [
          // 필터 바
          _FilterBar(
            filter: filter,
            tickerController: _tickerController,
            accountsAsync: accountsAsync,
            notifier: ref.read(tradeFilterNotifierProvider.notifier),
          ),
          const Divider(height: 1),
          // 목록
          Expanded(
            child: tradesAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('오류: $e')),
              data: (trades) => trades.isEmpty
                  ? EmptyStateWidget(
                      message: filter.hasActiveFilter
                          ? '검색 결과가 없습니다.'
                          : '매매 기록이 없습니다.',
                      icon: Icons.receipt_long_outlined,
                    )
                  : ListView.separated(
                      itemCount: trades.length,
                      separatorBuilder: (_, __) =>
                          const Divider(height: 1),
                      itemBuilder: (ctx, i) => _DismissibleTradeItem(
                        trade: trades[i],
                        onDelete: () => _deleteTrade(trades[i]),
                      ),
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/trades/new'),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _deleteTrade(TradeModel trade) async {
    final confirmed = await showConfirmDialog(
      context,
      title: '매매 기록 삭제',
      content:
          '${trade.tickerName} ${trade.action.label} 기록을 삭제하시겠습니까?',
      confirmLabel: '삭제',
      isDangerous: true,
    );
    if (confirmed && mounted) {
      await ref
          .read(tradeRepositoryProvider)
          .delete(trade.id!);
      ref.invalidate(filteredTradesProvider);
    }
  }
}

class _FilterBar extends StatelessWidget {
  const _FilterBar({
    required this.filter,
    required this.tickerController,
    required this.accountsAsync,
    required this.notifier,
  });

  final dynamic filter;
  final TextEditingController tickerController;
  final dynamic accountsAsync;
  final dynamic notifier;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          // 종목명 검색
          SizedBox(
            width: 160,
            child: TextField(
              controller: tickerController,
              decoration: const InputDecoration(
                hintText: '종목명 검색',
                prefixIcon: Icon(Icons.search),
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              ),
              onChanged: notifier.setTickerQuery,
            ),
          ),
          const SizedBox(width: 8),
          // 날짜 필터
          ActionChip(
            avatar: const Icon(Icons.date_range, size: 16),
            label: Text(
              filter.startDate != null
                  ? toDisplayDate(filter.startDate!)
                  : '시작일',
              style: const TextStyle(fontSize: 12),
            ),
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: filter.startDate ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (picked != null) notifier.setStartDate(picked);
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Text('~'),
          ),
          ActionChip(
            avatar: const Icon(Icons.date_range, size: 16),
            label: Text(
              filter.endDate != null
                  ? toDisplayDate(filter.endDate!)
                  : '종료일',
              style: const TextStyle(fontSize: 12),
            ),
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: filter.endDate ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (picked != null) notifier.setEndDate(picked);
            },
          ),
        ],
      ),
    );
  }
}

class _DismissibleTradeItem extends StatelessWidget {
  const _DismissibleTradeItem({
    required this.trade,
    required this.onDelete,
  });

  final TradeModel trade;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(trade.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).colorScheme.errorContainer,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: Icon(
          Icons.delete,
          color: Theme.of(context).colorScheme.onErrorContainer,
        ),
      ),
      confirmDismiss: (_) async {
        onDelete();
        return false; // 삭제는 onDelete에서 처리
      },
      child: _TradeItem(trade: trade),
    );
  }
}

class _TradeItem extends StatelessWidget {
  const _TradeItem({required this.trade});
  final TradeModel trade;

  @override
  Widget build(BuildContext context) {
    final stockColors = context.stockColors;
    final isBuy = trade.action == TradeAction.buy;
    final color = isBuy ? stockColors.buyColor : stockColors.sellColor;

    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            trade.action.label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
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
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            formatKrw(trade.totalAmount),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            '${formatQuantity(trade.quantity)}주 × ${formatKrw(trade.price)}',
            style: TextStyle(
              fontSize: 11,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ],
      ),
      onTap: () => context.push('/trades/${trade.id}'),
    );
  }
}
