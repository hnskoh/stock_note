import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/constants/trade_action.dart';

part 'trade_model.freezed.dart';

@freezed
class TradeModel with _$TradeModel {
  const factory TradeModel({
    int? id,
    required int accountId,
    required DateTime tradeDate,
    required String tickerName,
    required TradeAction action,
    required double quantity,
    required double price,
    @Default(0.0) double fee,
    required double totalAmount,
    String? note,
    required DateTime createdAt,
    required DateTime updatedAt,
    // 조인용
    String? accountName,
  }) = _TradeModel;

  const TradeModel._();

  factory TradeModel.fromMap(Map<String, dynamic> m) => TradeModel(
        id: m['id'] as int?,
        accountId: m['account_id'] as int,
        tradeDate: DateTime.parse(m['trade_date'] as String),
        tickerName: m['ticker_name'] as String,
        action: TradeAction.fromCode(m['action'] as String),
        quantity: (m['quantity'] as num).toDouble(),
        price: (m['price'] as num).toDouble(),
        fee: (m['fee'] as num).toDouble(),
        totalAmount: (m['total_amount'] as num).toDouble(),
        note: m['note'] as String?,
        createdAt: DateTime.parse(m['created_at'] as String),
        updatedAt: DateTime.parse(m['updated_at'] as String),
        accountName: m['account_name'] as String?,
      );

  Map<String, dynamic> toMap() {
    final now = DateTime.now().toUtc().toIso8601String();
    return {
      if (id != null) 'id': id,
      'account_id': accountId,
      'trade_date': '${tradeDate.year.toString().padLeft(4, '0')}'
          '-${tradeDate.month.toString().padLeft(2, '0')}'
          '-${tradeDate.day.toString().padLeft(2, '0')}',
      'ticker_name': tickerName,
      'action': action.code,
      'quantity': quantity,
      'price': price,
      'fee': fee,
      'total_amount': totalAmount,
      'note': note,
      'created_at': id == null ? now : createdAt.toUtc().toIso8601String(),
      'updated_at': now,
    };
  }

  /// BUY: qty × price + fee / SELL: qty × price - fee
  static double calcTotal({
    required TradeAction action,
    required double quantity,
    required double price,
    required double fee,
  }) =>
      action == TradeAction.buy
          ? quantity * price + fee
          : quantity * price - fee;
}
