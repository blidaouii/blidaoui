import 'package:flutter/material.dart';

import 'config/app_theme.dart';
import 'localization/app_localizations.dart';
import 'screens/home/home_screen.dart';
import 'screens/splash/splash_screen.dart';

class LudoDzApp extends StatefulWidget { const LudoDzApp({super.key}); @override State<LudoDzApp> createState() => _LudoDzAppState(); }
class _LudoDzAppState extends State<LudoDzApp> {
  Locale _locale = const Locale('fr'); ThemeMode _mode = ThemeMode.system;
  @override Widget build(BuildContext context) => MaterialApp(title: 'Ludo DZ', debugShowCheckedModeBanner: false, theme: AppTheme.light, darkTheme: AppTheme.dark, themeMode: _mode, locale: _locale, supportedLocales: AppLocalizations.supportedLocales, localizationsDelegates: const [AppLocalizations.delegate, DefaultMaterialLocalizations.delegate, DefaultWidgetsLocalizations.delegate], home: SplashScreen(onComplete: () => HomeScreen(onLocaleChanged: (l) => setState(() => _locale = l), onThemeChanged: (dark) => setState(() => _mode = dark ? ThemeMode.dark : ThemeMode.light))));
}
