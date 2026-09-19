import 'dart:math';

import '../models/game_models.dart';

class MoveResult {
  const MoveResult(this.state, {this.captured = false});
  final GameState state;
  final bool captured;
}

class LudoRules {
  static const trackLength = 52;
  static const finishProgress = 57;
  static const safeCells = {0, 8, 13, 21, 26, 34, 39, 47};
  static const _startOffsets = {PlayerColor.red: 0, PlayerColor.green: 13, PlayerColor.yellow: 26, PlayerColor.blue: 39};

  static GameState newGame({int playerCount = 4, int seed = 7}) {
    final colors = PlayerColor.values.take(playerCount).toList();
    final players = [for (var i = 0; i < colors.length; i++) PlayerState(id: 'p$i', name: 'Player ${i + 1}', color: colors[i])];
    return GameState(players: players, tokens: {for (final p in players) p.id: [for (var i = 0; i < 4; i++) TokenState(id: i)]}, currentPlayer: 0);
  }

  static List<int> legalTokenIds(GameState state, int dice) {
    if (dice < 1 || dice > 6 || state.dice != dice) return const [];
    final player = state.players[state.currentPlayer];
    return [for (final token in state.tokens[player.id]!) if (_canMove(token, dice)) token.id];
  }

  static bool _canMove(TokenState token, int dice) => token.isHome ? dice == 6 : !token.isFinished && token.progress + dice <= finishProgress;

  static MoveResult move(GameState state, int tokenId) {
    final dice = state.dice;
    if (dice == null || !legalTokenIds(state, dice).contains(tokenId)) throw StateError('Illegal token move');
    final player = state.players[state.currentPlayer];
    final old = state.tokens[player.id]!;
    final token = old.firstWhere((item) => item.id == tokenId);
    final nextProgress = token.isHome ? 0 : token.progress + dice;
    var captured = false;
    final nextTokens = {...state.tokens, player.id: [for (final item in old) item.id == tokenId ? item.copyWith(progress: nextProgress) : item]};
    if (nextProgress < trackLength && !safeCells.contains(_boardCell(player.color, nextProgress))) {
      for (final opponent in state.players.where((p) => p.id != player.id)) {
        final opponentTokens = nextTokens[opponent.id]!;
        nextTokens[opponent.id] = [for (final item in opponentTokens) if (_boardCell(opponent.color, item.progress) == _boardCell(player.color, nextProgress) && item.progress >= 0 ? (captured = true, item.copyWith(progress: -1)).$2 : item];
      }
    }
    final finished = nextTokens[player.id]!.every((item) => item.isFinished);
    final nextPlayer = dice == 6 || finished ? state.currentPlayer : (state.currentPlayer + 1) % state.players.length;
    return MoveResult(state.copyWith(tokens: nextTokens, currentPlayer: nextPlayer, dice: null, winnerId: finished ? player.id : null), captured: captured);
  }

  static int _boardCell(PlayerColor color, int progress) => progress < 0 || progress >= trackLength ? -1 : (_startOffsets[color]! + progress) % trackLength;
  static int roll(Random random) => random.nextInt(6) + 1;
}
