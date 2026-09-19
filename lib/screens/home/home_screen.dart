import 'package:flutter/material.dart';

import '../../config/app_theme.dart';
import '../../localization/app_localizations.dart';
import '../settings/settings_screen.dart';
import 'player_selection_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onLocaleChanged});
  final ValueChanged<Locale> onLocaleChanged;
  @override Widget build(BuildContext context) => Scaffold(body: SafeArea(child: Padding(padding: const EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Spacer(), Container(width: 78, height: 78, decoration: BoxDecoration(gradient: LinearGradient(colors: [AppTheme.green, Color(0xFF0AAE79)]), borderRadius: BorderRadius.all(Radius.circular(24))), child: const Icon(Icons.casino, color: Colors.white, size: 44)), const SizedBox(height: 24),
    Text(context.l10n.text('welcome'), style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900, color: AppTheme.ink)), const SizedBox(height: 8), Text(context.l10n.text('tagline'), style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black54)), const SizedBox(height: 40),
    SizedBox(width: double.infinity, child: ElevatedButton.icon(onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PlayerSelectionScreen())), icon: const Icon(Icons.play_arrow), label: Text(context.l10n.text('localGame')))), const SizedBox(height: 12),
    SizedBox(width: double.infinity, child: OutlinedButton.icon(onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SettingsScreen())), icon: const Icon(Icons.settings), label: Text(context.l10n.text('settings')))), const Spacer(), Center(child: Text('DZ • PLAY WITH PRIDE', style: Theme.of(context).textTheme.labelMedium?.copyWith(letterSpacing: 2, color: AppTheme.red, fontWeight: FontWeight.bold))),
  ])));
}
