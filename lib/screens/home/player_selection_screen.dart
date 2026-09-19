import 'package:flutter/material.dart';
import '../../config/app_theme.dart';
import '../../game/ludo_rules.dart';
import '../../game/local_game_controller.dart';
import '../../models/game_models.dart';
import '../game/game_screen.dart';

class PlayerSelectionScreen extends StatefulWidget { const PlayerSelectionScreen({super.key}); @override State<PlayerSelectionScreen> createState() => _PlayerSelectionScreenState(); }
class _PlayerSelectionScreenState extends State<PlayerSelectionScreen> { int count = 4; final bots = <int>{}; BotLevel level = BotLevel.normal;
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('New local game')), body: ListView(padding: const EdgeInsets.all(20), children: [Text('Players', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900)), const SizedBox(height: 12), SegmentedButton<int>(segments: const [ButtonSegment(value: 2, label: Text('2')), ButtonSegment(value: 3, label: Text('3')), ButtonSegment(value: 4, label: Text('4'))], selected: {count}, onSelectionChanged: (v) => setState(() { count = v.first; bots.removeWhere((i) => i >= count); })), const SizedBox(height: 12), DropdownButtonFormField<BotLevel>(value: level, decoration: const InputDecoration(labelText: 'Bot difficulty'), items: const [DropdownMenuItem(value: BotLevel.easy, child: Text('Easy')), DropdownMenuItem(value: BotLevel.normal, child: Text('Normal')), DropdownMenuItem(value: BotLevel.hard, child: Text('Hard'))], onChanged: (v) => setState(() => level = v ?? BotLevel.normal)), const SizedBox(height: 12), for (var i = 0; i < count; i++) Card(child: SwitchListTile(value: bots.contains(i), onChanged: (v) => setState(() => v ? bots.add(i) : bots.remove(i)), secondary: CircleAvatar(backgroundColor: _color(PlayerColor.values[i]), child: Text('${i + 1}')), title: Text('Player ${i + 1}'), subtitle: Text(bots.contains(i) ? 'Computer' : 'Human'))), const SizedBox(height: 16), ElevatedButton.icon(onPressed: _start, icon: const Icon(Icons.play_arrow), label: const Text('START GAME')) ]));
  void _start() { final initial = LudoRules.newGame(playerCount: count, botPlayers: {for (final i in bots) 'p$i'}); Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => GameScreen(controller: LocalGameController(initial: initial)))); }
}
Color _color(PlayerColor c) => switch (c) { PlayerColor.red => AppTheme.red, PlayerColor.green => AppTheme.green, PlayerColor.yellow => AppTheme.gold, PlayerColor.blue => AppTheme.blue };
