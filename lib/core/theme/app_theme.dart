import 'package:flutter/material.dart';

/// 한국 증권 관례: 매수=빨강, 매도=파랑
@immutable
class StockColors extends ThemeExtension<StockColors> {
  const StockColors({required this.buyColor, required this.sellColor});

  final Color buyColor;
  final Color sellColor;

  @override
  StockColors copyWith({Color? buyColor, Color? sellColor}) => StockColors(
        buyColor: buyColor ?? this.buyColor,
        sellColor: sellColor ?? this.sellColor,
      );

  @override
  StockColors lerp(StockColors? other, double t) {
    if (other == null) return this;
    return StockColors(
      buyColor: Color.lerp(buyColor, other.buyColor, t)!,
      sellColor: Color.lerp(sellColor, other.sellColor, t)!,
    );
  }
}

class AppTheme {
  AppTheme._();

  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF37474F), // Blue Grey 800
      brightness: Brightness.light,
    ),
    extensions: const [
      StockColors(
        buyColor: Color(0xFFD32F2F), // Red 700
        sellColor: Color(0xFF1565C0), // Blue 800
      ),
    ],
    appBarTheme: const AppBarTheme(centerTitle: true),
    cardTheme: CardThemeData(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      filled: true,
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF37474F),
      brightness: Brightness.dark,
    ),
    extensions: const [
      StockColors(
        buyColor: Color(0xFFEF9A9A), // Red 200
        sellColor: Color(0xFF90CAF9), // Blue 200
      ),
    ],
    appBarTheme: const AppBarTheme(centerTitle: true),
    cardTheme: CardThemeData(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      filled: true,
    ),
  );
}

extension StockColorsExtension on BuildContext {
  StockColors get stockColors =>
      Theme.of(this).extension<StockColors>() ??
      const StockColors(buyColor: Colors.red, sellColor: Colors.blue);
}
