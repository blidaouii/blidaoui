import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';

import '../bot/bot_strategy.dart';
import '../models/game_models.dart';
import 'ludo_rules.dart';

class LocalGameController extends ChangeNotifier {
  LocalGameController({GameState? initial}) : state = initial ?? LudoRules.newGame();
  GameState state;
  final Random _random = Random();
  Timer? _botTimer;
  bool soundEnabled = true;
  bool vibrationEnabled = true;

  bool get isBotTurn => state.players[state.currentPlayer].kind == PlayerKind.bot;

  void roll() {
    if (state.winnerId != null || state.dice != null || isBotTurn) return;
    _rollForCurrentPlayer();
  }

  void _rollForCurrentPlayer() {
    state = state.copyWith(dice: LudoRules.roll(_random));
    notifyListeners();
    if (state.dice != null && LudoRules.legalTokenIds(state, state.dice!).isEmpty) {
      _botTimer = Timer(const Duration(milliseconds: 600), _passTurn);
    } else if (isBotTurn) {
      _botTimer = Timer(const Duration(milliseconds: 550), _playBotMove);
    }
  }

  void move(int tokenId) {
    if (isBotTurn) return;
    _applyMove(tokenId);
  }

  void _playBotMove() {
    if (state.dice == null) return;
    final tokenId = BotStrategies.forPlayer(state.players[state.currentPlayer]).chooseToken(legalTokens);
    if (tokenId == null) {
      _passTurn();
      return;
    }
    _applyMove(tokenId);
  }

  void _applyMove(int tokenId) {
    final result = LudoRules.move(state, tokenId);
    state = result.state;
    notifyListeners();
    if (state.winnerId == null && isBotTurn) {
      _botTimer = Timer(const Duration(milliseconds: 650), _rollBotTurn);
    }
  }

  void _rollBotTurn() {
    if (state.dice == null && isBotTurn && state.winnerId == null) _rollForCurrentPlayer();
  }

  void _passTurn() {
    if (state.dice == null) return;
    state = state.copyWith(dice: null, currentPlayer: (state.currentPlayer + 1) % state.players.length);
    notifyListeners();
    if (isBotTurn) _botTimer = Timer(const Duration(milliseconds: 500), _rollBotTurn);
  }

  void restart() {
    _botTimer?.cancel();
    state = LudoRules.newGame(playerCount: state.players.length, botPlayers: {for (final p in state.players.where((p) => p.kind == PlayerKind.bot)) p.id});
    notifyListeners();
  }

  List<int> get legalTokens => state.dice == null ? const [] : LudoRules.legalTokenIds(state, state.dice!);

  @override
  void dispose() {
    _botTimer?.cancel();
    super.dispose();
  }
}
