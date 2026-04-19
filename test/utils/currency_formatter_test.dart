import 'package:flutter_test/flutter_test.dart';
import 'package:stock_note/core/utils/currency_formatter.dart';

void main() {
  group('formatKrw', () {
    test('정수 금액 포맷', () {
      expect(formatKrw(1234567), '1,234,567원');
      expect(formatKrw(0), '0원');
      expect(formatKrw(1000000), '1,000,000원');
    });

    test('소수점 반올림', () {
      expect(formatKrw(1234.6), '1,235원');
    });
  });

  group('formatQuantity', () {
    test('정수 수량은 소수점 없이', () {
      expect(formatQuantity(10.0), '10');
      expect(formatQuantity(100.0), '100');
    });

    test('소수 수량은 그대로', () {
      expect(formatQuantity(10.5), '10.5');
    });
  });
}
