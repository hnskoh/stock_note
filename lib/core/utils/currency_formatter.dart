import 'package:intl/intl.dart';

final _krwFormat = NumberFormat('#,###', 'ko_KR');

String formatKrw(double amount) => '${_krwFormat.format(amount.round())}원';

String formatQuantity(double qty) =>
    qty == qty.roundToDouble() ? qty.toStringAsFixed(0) : qty.toString();
