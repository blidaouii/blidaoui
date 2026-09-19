import 'package:flutter/material.dart';

class AppLocalizations {
  AppLocalizations(this.locale);
  final Locale locale;

  static const supportedLocales = [Locale('ar'), Locale('fr'), Locale('en')];
  static const delegate = _AppLocalizationsDelegate();

  static const _values = <String, Map<String, String>>{
    'welcome': {'en': 'Welcome to Ludo DZ', 'fr': 'Bienvenue dans Ludo DZ', 'ar': 'مرحباً بك في لودو DZ'},
    'tagline': {'en': 'Play together. Win with style.', 'fr': 'Jouez ensemble. Gagnez avec style.', 'ar': 'العبوا معاً واربحوا بأناقة'},
    'localGame': {'en': 'Local game', 'fr': 'Partie locale', 'ar': 'لعبة محلية'},
    'players': {'en': 'Players', 'fr': 'Joueurs', 'ar': 'اللاعبون'},
    'start': {'en': 'Start game', 'fr': 'Commencer', 'ar': 'ابدأ اللعبة'},
    'roll': {'en': 'Roll dice', 'fr': 'Lancer le dé', 'ar': 'ارمِ النرد'},
    'yourTurn': {'en': 'Your turn', 'fr': 'À votre tour', 'ar': 'دورك'},
    'settings': {'en': 'Settings', 'fr': 'Paramètres', 'ar': 'الإعدادات'},
    'restart': {'en': 'Restart', 'fr': 'Recommencer', 'ar': 'إعادة اللعبة'},
    'winner': {'en': 'wins!', 'fr': 'gagne !', 'ar': 'يفوز!'},
    'home': {'en': 'Home', 'fr': 'Maison', 'ar': 'القاعدة'},
  };

  String text(String key) => _values[key]?[locale.languageCode] ?? _values[key]?['en'] ?? key;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();
  @override bool isSupported(Locale locale) => AppLocalizations.supportedLocales.any((item) => item.languageCode == locale.languageCode);
  @override Future<AppLocalizations> load(Locale locale) async => AppLocalizations(locale);
  @override bool shouldReload(_AppLocalizationsDelegate old) => false;
}

extension LocalizationContext on BuildContext {
  AppLocalizations get l10n => Localizations.of<AppLocalizations>(this, AppLocalizations) ?? AppLocalizations(const Locale('en'));
}
