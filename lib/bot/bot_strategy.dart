import '../models/game_models.dart';

abstract class BotStrategy {
  const BotStrategy();
  int? chooseToken(List<int> legalTokenIds);
}

class EasyBot extends BotStrategy {
  const EasyBot();
  @override int? chooseToken(List<int> legalTokenIds) => legalTokenIds.isEmpty ? null : legalTokenIds.first;
}

class MediumBot extends BotStrategy {
  const MediumBot();
  @override int? chooseToken(List<int> legalTokenIds) => legalTokenIds.isEmpty ? null : legalTokenIds.last;
}

class HardBot extends BotStrategy {
  const HardBot();
  @override int? chooseToken(List<int> legalTokenIds) => legalTokenIds.isEmpty ? null : legalTokenIds.reduce((a, b) => a > b ? a : b);
}

class BotStrategies {
  static BotStrategy forPlayer(PlayerState player) => const EasyBot();
}
