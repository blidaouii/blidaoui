import 'package:flutter/material.dart';

import '../../config/app_theme.dart';
import '../../game/local_game_controller.dart';
import '../../localization/app_localizations.dart';
import '../../models/game_models.dart';
import '../game/game_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onLocaleChanged});
  final ValueChanged<Locale> onLocaleChanged;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(child: Padding(padding: const EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Spacer(),
          Container(width: 72, height: 72, decoration: BoxDecoration(color: AppTheme.green, borderRadius: BorderRadius.circular(22)), child: const Icon(Icons.casino, color: Colors.white, size: 40)),
          const SizedBox(height: 24),
          Text(context.l10n.text('welcome'), style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900, color: AppTheme.ink)),
          const SizedBox(height: 8),
          Text(context.l10n.text('tagline'), style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black54)),
          const SizedBox(height: 40),
          SizedBox(width: double.infinity, child: ElevatedButton.icon(onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => GameScreen(controller: LocalGameController()))), icon: const Icon(Icons.play_arrow), label: Text(context.l10n.text('localGame')))),
          const SizedBox(height: 14),
          SizedBox(width: double.infinity, child: OutlinedButton.icon(onPressed: () => _showLanguage(context), icon: const Icon(Icons.language), label: Text(context.l10n.text('settings')))),
          const Spacer(),
          Center(child: Text('DZ • PLAY WITH PRIDE', style: Theme.of(context).textTheme.labelMedium?.copyWith(letterSpacing: 2, color: AppTheme.red, fontWeight: FontWeight.bold))),
        ])),
      );

  void _showLanguage(BuildContext context) => showModalBottomSheet<void>(context: context, builder: (_) => Column(mainAxisSize: MainAxisSize.min, children: [for (final locale in AppLocalizations.supportedLocales) ListTile(title: Text(locale.languageCode.toUpperCase()), onTap: () { onLocaleChanged(locale); Navigator.pop(context); })]));
}
