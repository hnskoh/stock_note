import 'package:flutter_test/flutter_test.dart';
import 'package:stock_note/core/constants/trade_action.dart';
import 'package:stock_note/features/trades/domain/trade_model.dart';

void main() {
  group('TradeModel.calcTotal', () {
    test('BUY: 수량 × 단가 + 수수료', () {
      final total = TradeModel.calcTotal(
        action: TradeAction.buy,
        quantity: 10,
        price: 50000,
        fee: 250,
      );
      expect(total, equals(500250.0));
    });

    test('SELL: 수량 × 단가 - 수수료', () {
      final total = TradeModel.calcTotal(
        action: TradeAction.sell,
        quantity: 10,
        price: 50000,
        fee: 250,
      );
      expect(total, equals(499750.0));
    });

    test('수수료 0인 경우', () {
      final total = TradeModel.calcTotal(
        action: TradeAction.buy,
        quantity: 5,
        price: 100000,
        fee: 0,
      );
      expect(total, equals(500000.0));
    });

    test('소수 수량 처리', () {
      final total = TradeModel.calcTotal(
        action: TradeAction.buy,
        quantity: 1.5,
        price: 100000,
        fee: 100,
      );
      expect(total, equals(150100.0));
    });
  });
}
