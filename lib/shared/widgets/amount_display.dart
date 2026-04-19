import 'package:flutter/material.dart';

import '../../core/utils/currency_formatter.dart';

class AmountDisplay extends StatelessWidget {
  const AmountDisplay({
    required this.amount,
    this.style,
    this.textAlign = TextAlign.right,
    super.key,
  });

  final double amount;
  final TextStyle? style;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      formatKrw(amount),
      style: style,
      textAlign: textAlign,
    );
  }
}
