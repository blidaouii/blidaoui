import '../models/game_models.dart';

abstract class BotStrategy {
  const BotStrategy();
  int? chooseToken(GameState state, List<int> legalIds);
}
class EasyBot extends BotStrategy { const EasyBot(); @override int? chooseToken(GameState state, List<int> legalIds) => legalIds.isEmpty ? null : legalIds.first; }
class NormalBot extends BotStrategy { const NormalBot(); @override int? chooseToken(GameState state, List<int> legalIds) => legalIds.isEmpty ? null : legalIds.last; }
class HardBot extends BotStrategy { const HardBot(); @override int? chooseToken(GameState state, List<int> legalIds) => legalIds.isEmpty ? null : legalIds.reduce((a, b) => a > b ? a : b); }
class BotStrategies { static BotStrategy forPlayer(PlayerState player) => switch (player.botLevel) { BotLevel.easy => const EasyBot(), BotLevel.normal => const NormalBot(), BotLevel.hard => const HardBot() }; }
