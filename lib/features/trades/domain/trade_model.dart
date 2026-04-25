import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/constants/trade_action.dart';

part 'trade_model.freezed.dart';

@freezed
class TradeModel with _$TradeModel {
  const factory TradeModel({
    String? id,
    required String accountId,
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
    String? accountName,
  }) = _TradeModel;

  const TradeModel._();

  factory TradeModel.fromFirestore(DocumentSnapshot doc) {
    final m = doc.data() as Map<String, dynamic>;
    return TradeModel(
      id: doc.id,
      accountId: m['accountId'] as String,
      tradeDate: (m['tradeDate'] as Timestamp).toDate(),
      tickerName: m['tickerName'] as String,
      action: TradeAction.fromCode(m['action'] as String),
      quantity: (m['quantity'] as num).toDouble(),
      price: (m['price'] as num).toDouble(),
      fee: (m['fee'] as num? ?? 0).toDouble(),
      totalAmount: (m['totalAmount'] as num).toDouble(),
      note: m['note'] as String?,
      createdAt: (m['createdAt'] as Timestamp).toDate(),
      updatedAt: (m['updatedAt'] as Timestamp).toDate(),
      accountName: m['accountName'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    final now = Timestamp.now();
    return {
      'accountId': accountId,
      'accountName': accountName,
      'tradeDate': Timestamp.fromDate(
        DateTime.utc(tradeDate.year, tradeDate.month, tradeDate.day),
      ),
      'tickerName': tickerName,
      'action': action.code,
      'quantity': quantity,
      'price': price,
      'fee': fee,
      'totalAmount': totalAmount,
      'note': note,
      'createdAt': id == null ? now : Timestamp.fromDate(createdAt.toUtc()),
      'updatedAt': now,
    };
  }

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
