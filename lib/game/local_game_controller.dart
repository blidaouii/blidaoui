import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';

import '../bot/bot_strategy.dart';
import '../models/game_models.dart';
import 'ludo_rules.dart';

class LocalGameController extends ChangeNotifier {
  LocalGameController({GameState? initial}) : state = initial ?? LudoRules.newGame() { _scheduleBot(); }
  GameState state;
  final Random _random = Random();
  Timer? _timer;
  bool paused = false;
  bool soundEnabled = true;
  bool vibrationEnabled = true;
  bool get isBotTurn => state.players[state.currentPlayer].kind == PlayerKind.bot;
  List<int> get legalTokens => state.dice == null ? const [] : LudoRules.legalTokenIds(state, state.dice!);

  void togglePause() { paused = !paused; notifyListeners(); if (!paused) _scheduleBot(); }
  void roll() { if (paused || state.dice != null || state.winnerId != null || isBotTurn) return; _roll(); }
  void _roll() { state = state.copyWith(dice: LudoRules.roll(_random)); notifyListeners(); if (legalTokens.isEmpty) { _timer = Timer(const Duration(milliseconds: 600), _pass); } else if (isBotTurn) _timer = Timer(const Duration(milliseconds: 450), _botMove); }
  void move(int tokenId) { if (paused || isBotTurn || !legalTokens.contains(tokenId)) return; _apply(tokenId); }
  void _botMove() { if (state.dice == null || paused) return; final token = BotStrategies.forPlayer(state.players[state.currentPlayer]).chooseToken(state, legalTokens); token == null ? _pass() : _apply(token); }
  void _apply(int tokenId) { state = LudoRules.move(state, tokenId).state; notifyListeners(); _scheduleBot(); }
  void _pass() { if (state.dice == null || state.winnerId != null) return; state = state.copyWith(dice: null, currentPlayer: (state.currentPlayer + 1) % state.players.length); notifyListeners(); _scheduleBot(); }
  void _scheduleBot() { _timer?.cancel(); if (!paused && state.winnerId == null && isBotTurn && state.dice == null) _timer = Timer(const Duration(milliseconds: 500), _roll); }
  void restart() { _timer?.cancel(); paused = false; state = LudoRules.newGame(playerCount: state.players.length, botPlayers: {for (final player in state.players.where((p) => p.kind == PlayerKind.bot)) player.id}); notifyListeners(); _scheduleBot(); }
  @override void dispose() { _timer?.cancel(); super.dispose(); }
}
