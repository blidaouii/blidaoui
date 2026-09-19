import '../models/game_models.dart';

class PlayerProfile {
  const PlayerProfile({this.username = 'Player', this.avatar = '🎲', this.gamesPlayed = 0, this.wins = 0, this.losses = 0, this.coins = 0, this.xp = 0});
  final String username;
  final String avatar;
  final int gamesPlayed;
  final int wins;
  final int losses;
  final int coins;
  final int xp;
  int get level => (xp ~/ 100) + 1;
  PlayerProfile copyWith({String? username, String? avatar, int? gamesPlayed, int? wins, int? losses, int? coins, int? xp}) => PlayerProfile(username: username ?? this.username, avatar: avatar ?? this.avatar, gamesPlayed: gamesPlayed ?? this.gamesPlayed, wins: wins ?? this.wins, losses: losses ?? this.losses, coins: coins ?? this.coins, xp: xp ?? this.xp);
}

class ProfileService {
  ProfileService._();
  static final instance = ProfileService._();
  PlayerProfile profile = const PlayerProfile();
  void recordWin() => profile = profile.copyWith(gamesPlayed: profile.gamesPlayed + 1, wins: profile.wins + 1, coins: profile.coins + 25, xp: profile.xp + 100);
  void recordLoss() => profile = profile.copyWith(gamesPlayed: profile.gamesPlayed + 1, losses: profile.losses + 1, xp: profile.xp + 25);
}
