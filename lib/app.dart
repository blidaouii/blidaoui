import 'package:flutter/material.dart';

import 'config/app_theme.dart';
import 'localization/app_localizations.dart';
import 'screens/home/home_screen.dart';

class LudoDzApp extends StatefulWidget {
  const LudoDzApp({super.key});

  @override
  State<LudoDzApp> createState() => _LudoDzAppState();
}

class _LudoDzAppState extends State<LudoDzApp> {
  Locale _locale = const Locale('fr');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ludo DZ',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      locale: _locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      home: HomeScreen(onLocaleChanged: (locale) => setState(() => _locale = locale)),
    );
  }
}
