import 'package:flutter/foundation.dart';

import '../models/game_models.dart';
import 'ludo_rules.dart';

class LocalGameController extends ChangeNotifier {
  LocalGameController({GameState? initial}) : state = initial ?? LudoRules.newGame();
  GameState state;
  final Random _random = Random();

  void roll() {
    if (state.winnerId != null || state.dice != null) return;
    state = state.copyWith(dice: LudoRules.roll(_random));
    notifyListeners();
  }

  void move(int tokenId) {
    final result = LudoRules.move(state, tokenId);
    state = result.state;
    notifyListeners();
  }

  void restart() {
    state = LudoRules.newGame(playerCount: state.players.length);
    notifyListeners();
  }

  List<int> get legalTokens => state.dice == null ? const [] : LudoRules.legalTokenIds(state, state.dice!);
}
