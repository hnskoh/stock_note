import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/trade_action.dart';
import '../../trades/data/trade_repository.dart';
import '../../trades/domain/trade_filter.dart';
import '../../trades/domain/trade_model.dart';

const _recentTradeCount = 20;

// ── 기간 선택 ──────────────────────────────────────────────
enum DashboardPeriod {
  week('7일', 7),
  month('30일', 30),
  threeMonths('3개월', 90),
  all('전체', null);

  const DashboardPeriod(this.label, this.days);
  final String label;
  final int? days;
}

// ── 종목별 요약 ────────────────────────────────────────────
class TickerSummary {
  const TickerSummary({
    required this.tickerName,
    required this.totalBuyAmount,
    required this.totalSellAmount,
    required this.buyCount,
    required this.sellCount,
  });

  final String tickerName;
  final double totalBuyAmount;
  final double totalSellAmount;
  final int buyCount;
  final int sellCount;

  // 순손익: 매도 - 매수 (양수=이익, 음수=투자중)
  double get netAmount => totalSellAmount - totalBuyAmount;

  // 수익률: 매도가 있을 때만 의미 있음
  double get returnRate =>
      totalBuyAmount > 0 ? (netAmount / totalBuyAmount * 100) : 0;

  bool get hasSell => totalSellAmount > 0;
}

// ── 대시보드 데이터 ────────────────────────────────────────
class DashboardData {
  const DashboardData({
    required this.totalBuyAmount,
    required this.totalSellAmount,
    required this.tickerSummaries,
    required this.recentTrades,
    required this.period,
    this.startDate,
  });

  final double totalBuyAmount;
  final double totalSellAmount;
  final List<TickerSummary> tickerSummaries;
  final List<TradeModel> recentTrades; // 기간 무관, 최근 N건
  final DashboardPeriod period;
  final DateTime? startDate;

  double get netAmount => totalSellAmount - totalBuyAmount;
}

// ── Providers ──────────────────────────────────────────────
final dashboardPeriodProvider =
    StateProvider<DashboardPeriod>((_) => DashboardPeriod.month);

final dashboardDataProvider = FutureProvider<DashboardData>((ref) async {
  final period = ref.watch(dashboardPeriodProvider);
  final repo = ref.watch(tradeRepositoryProvider);
  final now = DateTime.now();

  final startDate =
      period.days != null ? now.subtract(Duration(days: period.days!)) : null;

  // 기간 내 거래 (요약 + 종목별 통계용)
  final periodTrades = await repo.getFilteredTrades(
    TradeFilter(startDate: startDate),
  );

  // 전체 거래 (최근 N건 표시용, 기간 무관)
  final allTrades = await repo.getFilteredTrades(const TradeFilter());

  // 기간 내 합계
  double buy = 0, sell = 0;
  for (final t in periodTrades) {
    if (t.action == TradeAction.buy) {
      buy += t.totalAmount;
    } else {
      sell += t.totalAmount;
    }
  }

  // 종목별 집계
  final tickerMap = <String, _TickerAccum>{};
  for (final t in periodTrades) {
    final acc = tickerMap.putIfAbsent(t.tickerName, () => _TickerAccum());
    if (t.action == TradeAction.buy) {
      acc.buyAmount += t.totalAmount;
      acc.buyCount++;
    } else {
      acc.sellAmount += t.totalAmount;
      acc.sellCount++;
    }
  }

  final tickerSummaries = tickerMap.entries
      .map((e) => TickerSummary(
            tickerName: e.key,
            totalBuyAmount: e.value.buyAmount,
            totalSellAmount: e.value.sellAmount,
            buyCount: e.value.buyCount,
            sellCount: e.value.sellCount,
          ))
      .toList()
    ..sort((a, b) =>
        (b.totalBuyAmount + b.totalSellAmount)
            .compareTo(a.totalBuyAmount + a.totalSellAmount));

  return DashboardData(
    totalBuyAmount: buy,
    totalSellAmount: sell,
    tickerSummaries: tickerSummaries,
    recentTrades: allTrades.take(_recentTradeCount).toList(),
    period: period,
    startDate: startDate,
  );
});

class _TickerAccum {
  double buyAmount = 0;
  double sellAmount = 0;
  int buyCount = 0;
  int sellCount = 0;
}
