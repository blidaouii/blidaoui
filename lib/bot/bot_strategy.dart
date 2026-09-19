import '../game/local_game_controller.dart';

abstract class BotStrategy {
  int? chooseToken(LocalGameController game);
}

class EasyBot implements BotStrategy {
  @override
  int? chooseToken(LocalGameController game) => game.legalTokens.isEmpty ? null : game.legalTokens.first;
}

class MediumBot extends EasyBot {
  @override
  int? chooseToken(LocalGameController game) => game.legalTokens.isEmpty ? null : game.legalTokens.last;
}

class HardBot extends EasyBot {
  @override
  int? chooseToken(LocalGameController game) => game.legalTokens.isEmpty ? null : game.legalTokens.first;
}
