import 'package:flutter/material.dart';

class AppTheme {
  static const green = Color(0xFF087F5B); static const red = Color(0xFFD62839); static const gold = Color(0xFFF2B134); static const blue = Color(0xFF2878D0); static const ink = Color(0xFF17202A);
  static ThemeData light = _build(Brightness.light);
  static ThemeData dark = _build(Brightness.dark);
  static ThemeData _build(Brightness brightness) { final dark = brightness == Brightness.dark; final scheme = ColorScheme.fromSeed(seedColor: green, brightness: brightness); return ThemeData(useMaterial3: true, brightness: brightness, colorScheme: scheme, scaffoldBackgroundColor: dark ? const Color(0xFF101816) : const Color(0xFFF7F8F5), appBarTheme: const AppBarTheme(centerTitle: false, elevation: 0, backgroundColor: Colors.transparent), cardTheme: CardTheme(color: dark ? const Color(0xFF1B2622) : Colors.white, elevation: 2, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22))), elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(minimumSize: const Size(0, 52), padding: const EdgeInsets.symmetric(horizontal: 24), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), textStyle: const TextStyle(fontWeight: FontWeight.w800))); }
}
