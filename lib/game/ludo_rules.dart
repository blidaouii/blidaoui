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
  static const safeCells = <int>{0, 8, 13, 21, 26, 34, 39, 47};
  static const startOffsets = <PlayerColor, int>{PlayerColor.red: 0, PlayerColor.green: 13, PlayerColor.yellow: 26, PlayerColor.blue: 39};

  static GameState newGame({int playerCount = 4, Set<String> botPlayers = const {}}) {
    if (playerCount < 2 || playerCount > 4) throw ArgumentError.value(playerCount, 'playerCount', 'must be between 2 and 4');
    final colors = PlayerColor.values.take(playerCount).toList();
    final players = [for (var i = 0; i < colors.length; i++) PlayerState(id: 'p$i', name: botPlayers.contains('p$i') ? 'Bot ${i + 1}' : 'Player ${i + 1}', color: colors[i], kind: botPlayers.contains('p$i') ? PlayerKind.bot : PlayerKind.human)];
    return GameState(players: players, tokens: {for (final p in players) p.id: [for (var i = 0; i < 4; i++) TokenState(id: i)]}, currentPlayer: 0);
  }

  static List<int> legalTokenIds(GameState state, int dice) {
    if (dice < 1 || dice > 6 || state.dice != dice || state.winnerId != null) return const [];
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
    final destination = boardCell(player.color, nextProgress);
    if (destination >= 0 && !safeCells.contains(destination)) {
      for (final opponent in state.players.where((p) => p.id != player.id)) {
        nextTokens[opponent.id] = [for (final item in nextTokens[opponent.id]!) _captureIfPresent(item, opponent.color, destination, () => captured = true)];
      }
    }
    final finished = nextTokens[player.id]!.every((item) => item.isFinished);
    final nextPlayer = dice == 6 ? state.currentPlayer : (state.currentPlayer + 1) % state.players.length;
    return MoveResult(state.copyWith(tokens: nextTokens, currentPlayer: finished ? state.currentPlayer : nextPlayer, dice: null, winnerId: finished ? player.id : null), captured: captured);
  }

  static TokenState _captureIfPresent(TokenState token, PlayerColor color, int destination, void Function() onCapture) {
    if (!token.isHome && !token.isFinished && boardCell(color, token.progress) == destination) { onCapture(); return token.copyWith(progress: -1); }
    return token;
  }

  static int boardCell(PlayerColor color, int progress) => progress < 0 || progress >= trackLength ? -1 : (startOffsets[color]! + progress) % trackLength;
  static int roll(Random random) => random.nextInt(6) + 1;
}
