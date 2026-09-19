import 'package:ludo_dz/models/game_models.dart';

abstract class AuthService {
  Future<PlayerState?> signInGuest();
  Future<PlayerState?> signInGoogle();
  Future<PlayerState?> signInApple();
  Future<void> signOut();
}

abstract class RoomService {
  Stream<GameState> watchRoom(String roomId);
  Future<String> createPrivateRoom();
  Future<void> submitServerMove(String roomId, int tokenId);
  Future<int> requestServerDice(String roomId);
}
