import 'package:flutter/material.dart';

import '../../config/app_theme.dart';
import '../../game/local_game_controller.dart';
import '../../game/ludo_rules.dart';
import '../../models/game_models.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key, required this.controller});
  final LocalGameController controller;
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() { super.initState(); widget.controller.addListener(_refresh); }
  @override
  void dispose() { widget.controller.removeListener(_refresh); widget.controller.dispose(); super.dispose(); }
  void _refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final game = widget.controller;
    final player = game.state.players[game.state.currentPlayer];
    return Scaffold(appBar: AppBar(title: const Text('Ludo DZ'), actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.volume_up))]), body: LayoutBuilder(builder: (context, constraints) => SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(children: [
      _TurnBanner(player: player, dice: game.state.dice),
      const SizedBox(height: 16),
      AspectRatio(aspectRatio: 1, child: _Board(state: game.state, legalTokens: game.legalTokens, onToken: game.move)),
      const SizedBox(height: 18),
      if (game.state.winnerId != null) _Winner(player: player) else ElevatedButton.icon(onPressed: game.state.dice == null ? game.roll : null, icon: const Icon(Icons.casino), label: Text(game.state.dice == null ? 'ROLL DICE' : 'SELECT A TOKEN')),
    ]))));
  }
}

class _TurnBanner extends StatelessWidget { const _TurnBanner({required this.player, required this.dice}); final PlayerState player; final int? dice; @override Widget build(BuildContext context) => Card(child: ListTile(leading: CircleAvatar(backgroundColor: _color(player.color), child: Text('${player.name[0]}')), title: Text('${player.name}’s turn', style: const TextStyle(fontWeight: FontWeight.bold)), trailing: dice == null ? const Icon(Icons.hourglass_empty) : Text('$dice', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900)))); }

class _Board extends StatelessWidget { const _Board({required this.state, required this.legalTokens, required this.onToken}); final GameState state; final List<int> legalTokens; final ValueChanged<int> onToken; @override Widget build(BuildContext context) => Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 16)]), padding: const EdgeInsets.all(10), child: GridView.count(crossAxisCount: 7, physics: const NeverScrollableScrollPhysics(), children: [for (var i = 0; i < 49; i++) _cell(i)])); Widget _cell(int index) { final isSafe = LudoRules.safeCells.contains(index); return Container(margin: const EdgeInsets.all(2), decoration: BoxDecoration(color: isSafe ? AppTheme.gold.withOpacity(.25) : const Color(0xFFF1F4F1), borderRadius: BorderRadius.circular(5)), child: isSafe ? const Icon(Icons.star, size: 14, color: AppTheme.gold) : null); } }

class _Winner extends StatelessWidget { const _Winner({required this.player}); final PlayerState player; @override Widget build(BuildContext context) => Text('${player.name} wins! 🎉', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppTheme.green, fontWeight: FontWeight.w900)); }

Color _color(PlayerColor color) => switch (color) { PlayerColor.red => AppTheme.red, PlayerColor.green => AppTheme.green, PlayerColor.yellow => AppTheme.gold, PlayerColor.blue => Colors.blue };
