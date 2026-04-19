enum TradeAction {
  buy('BUY'),
  sell('SELL');

  const TradeAction(this.code);
  final String code;

  static TradeAction fromCode(String code) =>
      values.firstWhere((e) => e.code == code);

  String get label => switch (this) {
        TradeAction.buy => '매수',
        TradeAction.sell => '매도',
      };
}
