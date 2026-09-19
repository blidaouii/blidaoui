enum PlayerColor { red, green, yellow, blue }
enum PlayerKind { human, bot }
enum BotLevel { easy, normal, hard }

class PlayerState {
  const PlayerState({required this.id, required this.name, required this.color, this.kind = PlayerKind.human, this.botLevel = BotLevel.easy});
  final String id; final String name; final PlayerColor color; final PlayerKind kind; final BotLevel botLevel;
  PlayerState copyWith({String? name, PlayerKind? kind, BotLevel? botLevel}) => PlayerState(id: id, name: name ?? this.name, color: color, kind: kind ?? this.kind, botLevel: botLevel ?? this.botLevel);
}
class TokenState {
  const TokenState({required this.id, this.progress = -1});
  final int id; final int progress;
  bool get isHome => progress == -1; bool get isFinished => progress == 57;
  TokenState copyWith({int? progress}) => TokenState(id: id, progress: progress ?? this.progress);
}
class GameState {
  const GameState({required this.players, required this.tokens, required this.currentPlayer, this.dice, this.winnerId});
  final List<PlayerState> players; final Map<String, List<TokenState>> tokens; final int currentPlayer; final int? dice; final String? winnerId;
  GameState copyWith({List<PlayerState>? players, Map<String, List<TokenState>>? tokens, int? currentPlayer, Object? dice = _unset, Object? winnerId = _unset}) => GameState(players: players ?? this.players, tokens: tokens ?? this.tokens, currentPlayer: currentPlayer ?? this.currentPlayer, dice: identical(dice, _unset) ? this.dice : dice as int?, winnerId: identical(winnerId, _unset) ? this.winnerId : winnerId as String?);
  static const _unset = Object();
}
