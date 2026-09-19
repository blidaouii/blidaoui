import 'package:flutter/material.dart';

import '../../config/app_theme.dart';
import '../../game/local_game_controller.dart';
import '../../models/game_models.dart';
import '../game/game_screen.dart';

class PlayerSelectionScreen extends StatefulWidget {
  const PlayerSelectionScreen({super.key});
  @override
  State<PlayerSelectionScreen> createState() => _PlayerSelectionScreenState();
}

class _PlayerSelectionScreenState extends State<PlayerSelectionScreen> {
  int count = 4;
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Choose players')), body: Padding(padding: const EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    Text('Local Ludo', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900)),
    const SizedBox(height: 8), const Text('Play with 2 to 4 players on one device.'),
    const SizedBox(height: 28),
    SegmentedButton<int>(segments: const [ButtonSegment(value: 2, label: Text('2')), ButtonSegment(value: 3, label: Text('3')), ButtonSegment(value: 4, label: Text('4'))], selected: {count}, onSelectionChanged: (value) => setState(() => count = value.first)),
    const Spacer(),
    ElevatedButton.icon(onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => GameScreen(controller: LocalGameController(initial: LudoRules.newGame(playerCount: count))))), icon: const Icon(Icons.play_arrow), label: const Text('START GAME')),
  ])));
}
