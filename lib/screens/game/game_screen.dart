import 'package:flutter/material.dart';

import '../../config/app_theme.dart';
import '../../game/local_game_controller.dart';
import '../../game/ludo_rules.dart';
import '../../models/game_models.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key, required this.controller});
  final LocalGameController controller;
  @override State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _diceAnimation = AnimationController(vsync: this, duration: const Duration(milliseconds: 450));
  @override void initState() { super.initState(); widget.controller.addListener(_refresh); }
  @override void dispose() { widget.controller.removeListener(_refresh); widget.controller.dispose(); _diceAnimation.dispose(); super.dispose(); }
  void _refresh() { if (widget.controller.state.dice != null) _diceAnimation.forward(from: 0); setState(() {}); }

  @override Widget build(BuildContext context) {
    final game = widget.controller; final player = game.state.players[game.state.currentPlayer];
    return Scaffold(appBar: AppBar(title: const Text('Ludo DZ'), actions: [IconButton(tooltip: 'Restart', onPressed: () => _confirmRestart(context), icon: const Icon(Icons.refresh)), IconButton(tooltip: 'Sound', onPressed: () {}, icon: const Icon(Icons.volume_up))]), body: SafeArea(child: LayoutBuilder(builder: (context, constraints) => SingleChildScrollView(padding: const EdgeInsets.fromLTRB(16, 4, 16, 24), child: Column(children: [
      _TurnBanner(player: player, dice: game.state.dice), const SizedBox(height: 14),
      AspectRatio(aspectRatio: 1, child: _Board(state: game.state, legalTokens: game.legalTokens, onToken: game.move)), const SizedBox(height: 14),
      ScaleTransition(scale: Tween(begin: .85, end: 1.0).animate(CurvedAnimation(parent: _diceAnimation, curve: Curves.elasticOut)), child: _DiceButton(value: game.state.dice, enabled: game.state.dice == null && game.state.winnerId == null, onPressed: game.roll)),
      if (game.state.winnerId != null) Padding(padding: const EdgeInsets.only(top: 16), child: Text('${player.name} wins! 🎉', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppTheme.green, fontWeight: FontWeight.w900))),
    ]))));
  }

  Future<void> _confirmRestart(BuildContext context) async { final restart = await showDialog<bool>(context: context, builder: (_) => AlertDialog(title: const Text('Restart game?'), content: const Text('Your current game will be lost.'), actions: [TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('CANCEL')), FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('RESTART'))])); if (restart == true) widget.controller.restart(); }
}

class _DiceButton extends StatelessWidget { const _DiceButton({required this.value, required this.enabled, required this.onPressed}); final int? value; final bool enabled; final VoidCallback onPressed; @override Widget build(BuildContext context) => ElevatedButton.icon(onPressed: enabled ? onPressed : null, icon: const Icon(Icons.casino), label: Text(value == null ? 'ROLL DICE' : 'SELECT A TOKEN')); }
class _TurnBanner extends StatelessWidget { const _TurnBanner({required this.player, required this.dice}); final PlayerState player; final int? dice; @override Widget build(BuildContext context) => Card(child: ListTile(leading: CircleAvatar(backgroundColor: _color(player.color), child: Text(player.name[0])), title: Text('${player.name}’s turn', style: const TextStyle(fontWeight: FontWeight.bold)), subtitle: const Text('Move a highlighted piece'), trailing: dice == null ? const Icon(Icons.hourglass_empty) : Text('$dice', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900)))); }

class _Board extends StatelessWidget {
  const _Board({required this.state, required this.legalTokens, required this.onToken}); final GameState state; final List<int> legalTokens; final ValueChanged<int> onToken;
  @override Widget build(BuildContext context) => Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 18, offset: Offset(0, 8))]), padding: const EdgeInsets.all(10), child: GridView.count(crossAxisCount: 7, physics: const NeverScrollableScrollPhysics(), children: [for (var i = 0; i < 49; i++) _cell(i)]));
  Widget _cell(int index) { final owner = _ownerAt(index); final safe = LudoRules.safeCells.contains(index); return Container(margin: const EdgeInsets.all(2), decoration: BoxDecoration(color: owner == null ? (safe ? AppTheme.gold.withOpacity(.18) : const Color(0xFFF1F4F1)) : _color(owner.color).withOpacity(.22), borderRadius: BorderRadius.circular(7), border: safe ? Border.all(color: AppTheme.gold, width: 1.4) : null), child: Stack(alignment: Alignment.center, children: [if (safe) const Icon(Icons.star, size: 13, color: AppTheme.gold), if (owner != null) ..._tokensForCell(owner, index)])); }
  PlayerColor? _ownerAt(int cell) { for (final p in state.players) { if (state.tokens[p.id]!.any((t) => !t.isHome && !t.isFinished && _cell(p.color, t.progress) == cell)) return p.color; } return null; }
  List<Widget> _tokensForCell(PlayerColor color, int cell) { final p = state.players.firstWhere((item) => item.color == color); final tokens = state.tokens[p.id]!.where((t) => !t.isHome && !t.isFinished && _cell(color, t.progress) == cell).toList(); return [for (final token in tokens) GestureDetector(onTap: legalTokens.contains(token.id) && p.id == state.players[state.currentPlayer].id ? () => onToken(token.id) : null, child: Container(width: 22, height: 22, decoration: BoxDecoration(color: _color(color), shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2), boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 3)]), child: Center(child: Text('${token.id + 1}', style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold))))]; }
  int _cell(PlayerColor color, int progress) { const offsets = {PlayerColor.red: 0, PlayerColor.green: 13, PlayerColor.yellow: 26, PlayerColor.blue: 39}; return (offsets[color]! + progress) % 52; }
}
Color _color(PlayerColor color) => switch (color) { PlayerColor.red => AppTheme.red, PlayerColor.green => AppTheme.green, PlayerColor.yellow => AppTheme.gold, PlayerColor.blue => Colors.blue };
