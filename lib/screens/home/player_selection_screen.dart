import 'package:flutter/material.dart';

import '../../config/app_theme.dart';
import '../../game/local_game_controller.dart';
import '../../game/ludo_rules.dart';
import '../../models/game_models.dart';
import '../game/game_screen.dart';

class PlayerSelectionScreen extends StatefulWidget {
  const PlayerSelectionScreen({super.key});
  @override State<PlayerSelectionScreen> createState() => _PlayerSelectionScreenState();
}

class _PlayerSelectionScreenState extends State<PlayerSelectionScreen> {
  int count = 4;
  final Set<int> bots = {};
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('New local game')), body: Padding(padding: const EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    Text('Players', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900)), const SizedBox(height: 14),
    SegmentedButton<int>(segments: const [ButtonSegment(value: 2, label: Text('2')), ButtonSegment(value: 3, label: Text('3')), ButtonSegment(value: 4, label: Text('4'))], selected: {count}, onSelectionChanged: (v) => setState(() { count = v.first; bots.removeWhere((i) => i >= count); })),
    const SizedBox(height: 20),
    for (var i = 0; i < count; i++) Card(child: SwitchListTile(value: bots.contains(i), onChanged: (value) => setState(() => value ? bots.add(i) : bots.remove(i)), secondary: CircleAvatar(backgroundColor: _color(PlayerColor.values[i]), child: Text('${i + 1}')), title: Text('Player ${i + 1}'), subtitle: Text(bots.contains(i) ? 'Computer player' : 'Human player'))),
    const Spacer(), ElevatedButton.icon(onPressed: () { final ids = {for (final i in bots) 'p$i'}; Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => GameScreen(controller: LocalGameController(initial: LudoRules.newGame(playerCount: count, botPlayers: ids))))); }, icon: const Icon(Icons.play_arrow), label: const Text('START GAME')),
  ])));
}
Color _color(PlayerColor color) => switch (color) { PlayerColor.red => AppTheme.red, PlayerColor.green => AppTheme.green, PlayerColor.yellow => AppTheme.gold, PlayerColor.blue => Colors.blue };
