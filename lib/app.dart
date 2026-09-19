import 'package:flutter/material.dart';
import 'config/app_theme.dart';
import 'localization/app_localizations.dart';
import 'screens/home/home_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'services/settings_service.dart';

class LudoDzApp extends StatefulWidget { const LudoDzApp({super.key}); @override State<LudoDzApp> createState() => _LudoDzAppState(); }
class _LudoDzAppState extends State<LudoDzApp> {
  Locale _locale = const Locale('fr');
  @override Widget build(BuildContext context) => MaterialApp(title: 'Ludo DZ', debugShowCheckedModeBanner: false, theme: AppTheme.light, darkTheme: AppTheme.dark, themeMode: GameSettings.instance.darkTheme ? ThemeMode.dark : ThemeMode.light, locale: _locale, supportedLocales: AppLocalizations.supportedLocales, localizationsDelegates: const [AppLocalizations.delegate, DefaultMaterialLocalizations.delegate, DefaultWidgetsLocalizations.delegate], home: SplashScreen(onComplete: () => HomeScreen(onLocaleChanged: (l) => setState(() => _locale = l), onThemeChanged: (_) => setState(() {}))));
}
