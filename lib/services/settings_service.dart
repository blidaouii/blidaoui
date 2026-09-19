import 'package:flutter/material.dart';

class GameSettings {
  GameSettings._();
  static final instance = GameSettings._();

  bool soundEnabled = true;
  bool vibrationEnabled = true;
  bool animationsEnabled = true;

  void reset() {
    soundEnabled = true;
    vibrationEnabled = true;
    animationsEnabled = true;
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final settings = GameSettings.instance;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Column(children: [
                SwitchListTile(title: const Text('Sound effects'), secondary: const Icon(Icons.volume_up), value: settings.soundEnabled, onChanged: (value) => setState(() => settings.soundEnabled = value)),
                SwitchListTile(title: const Text('Vibration'), secondary: const Icon(Icons.vibration), value: settings.vibrationEnabled, onChanged: (value) => setState(() => settings.vibrationEnabled = value)),
                SwitchListTile(title: const Text('Animations'), secondary: const Icon(Icons.animation), value: settings.animationsEnabled, onChanged: (value) => setState(() => settings.animationsEnabled = value)),
              ]),
            ),
            Card(child: ListTile(leading: const Icon(Icons.language), title: const Text('Languages'), subtitle: const Text('العربية • Français • English'))),
          ],
        ),
      );
}
