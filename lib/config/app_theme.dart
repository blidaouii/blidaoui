import 'package:flutter/material.dart';

class AppTheme {
  static const green = Color(0xFF087F5B);
  static const red = Color(0xFFD62839);
  static const gold = Color(0xFFF2B134);
  static const ink = Color(0xFF17202A);

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: green, primary: green, secondary: gold),
        scaffoldBackgroundColor: const Color(0xFFF7F8F5),
        fontFamily: 'sans',
        appBarTheme: const AppBarTheme(centerTitle: false, elevation: 0, backgroundColor: Colors.transparent),
        cardTheme: CardThemeData(color: Colors.white, elevation: 2, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
        elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), textStyle: const TextStyle(fontWeight: FontWeight.w700))),
      );
}
