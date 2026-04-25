import 'package:freezed_annotation/freezed_annotation.dart';

part 'trade_filter.freezed.dart';

@freezed
class TradeFilter with _$TradeFilter {
  const factory TradeFilter({
    DateTime? startDate,
    DateTime? endDate,
    String? accountId,
    String? tickerQuery,
  }) = _TradeFilter;

  const TradeFilter._();

  bool get hasActiveFilter =>
      startDate != null ||
      endDate != null ||
      accountId != null ||
      (tickerQuery != null && tickerQuery!.isNotEmpty);
}
