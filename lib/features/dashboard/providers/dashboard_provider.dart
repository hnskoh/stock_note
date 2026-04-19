import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/constants/trade_action.dart';
import '../../trades/data/trade_repository.dart';
import '../../trades/domain/trade_filter.dart';
import '../../trades/domain/trade_model.dart';

part 'dashboard_provider.freezed.dart';

@freezed
class DashboardSummary with _$DashboardSummary {
  const factory DashboardSummary({
    required double totalBuyAmount,
    required double totalSellAmount,
    required List<TradeModel> recentTrades,
    required DateTime startDate,
    required DateTime endDate,
  }) = _DashboardSummary;

  const DashboardSummary._();

  double get netInvestment => totalBuyAmount - totalSellAmount;
}

final dashboardSummaryProvider = FutureProvider<DashboardSummary>((ref) async {
  final repo = ref.watch(tradeRepositoryProvider);
  final now = DateTime.now();
  final start = now.subtract(Duration(days: AppConstants.dashboardDays));

  final filter = TradeFilter(startDate: start, endDate: now);
  final trades = await repo.getFilteredTrades(filter);

  double buy = 0, sell = 0;
  for (final t in trades) {
    if (t.action == TradeAction.buy) {
      buy += t.totalAmount;
    } else {
      sell += t.totalAmount;
    }
  }

  return DashboardSummary(
    totalBuyAmount: buy,
    totalSellAmount: sell,
    recentTrades: trades.take(AppConstants.dashboardRecentCount).toList(),
    startDate: start,
    endDate: now,
  );
});
