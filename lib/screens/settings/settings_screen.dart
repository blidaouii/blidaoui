import 'package:flutter/material.dart';

import '../../config/app_theme.dart';
import '../../services/settings_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override State<SettingsScreen> createState() => _SettingsScreenState();
}
class _SettingsScreenState extends State<SettingsScreen> {
  final settings = GameSettings.instance;
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Settings')), body: ListView(padding: const EdgeInsets.all(16), children: [
    Card(child: Column(children: [SwitchListTile(title: const Text('Sound effects'), secondary: const Icon(Icons.volume_up, color: AppTheme.green), value: settings.soundEnabled, onChanged: (v) => setState(() => settings.soundEnabled = v)), SwitchListTile(title: const Text('Vibration'), secondary: const Icon(Icons.vibration, color: AppTheme.red), value: settings.vibrationEnabled, onChanged: (v) => setState(() => settings.vibrationEnabled = v))])),
    Card(child: ListTile(leading: const Icon(Icons.language, color: AppTheme.gold), title: const Text('Languages'), subtitle: const Text('العربية • Français • English'))),
  ]));
}
