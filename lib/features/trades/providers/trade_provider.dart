import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/trade_repository.dart';
import '../domain/trade_filter.dart';
import '../domain/trade_model.dart';

class TradeFilterNotifier extends StateNotifier<TradeFilter> {
  TradeFilterNotifier()
      : super(TradeFilter(
          startDate: DateTime.now().subtract(const Duration(days: 30)),
        ));

  void setStartDate(DateTime? d) => state = state.copyWith(startDate: d);
  void setEndDate(DateTime? d) => state = state.copyWith(endDate: d);
  void setAccount(int? id) => state = state.copyWith(accountId: id);
  void setTickerQuery(String? q) => state = state.copyWith(tickerQuery: q);
  void reset() => state = const TradeFilter();
}

final tradeFilterNotifierProvider =
    StateNotifierProvider<TradeFilterNotifier, TradeFilter>(
  (_) => TradeFilterNotifier(),
);

final filteredTradesProvider = FutureProvider<List<TradeModel>>((ref) {
  final filter = ref.watch(tradeFilterNotifierProvider);
  return ref.watch(tradeRepositoryProvider).getFilteredTrades(filter);
});

final distinctTickersProvider = FutureProvider<List<String>>(
  (ref) => ref.watch(tradeRepositoryProvider).getDistinctTickers(),
);
