import 'package:flutter_test/flutter_test.dart';
import 'package:ludo_dz/game/ludo_rules.dart';
import 'package:ludo_dz/models/game_models.dart';

void main() {
  group('Ludo rules', () {
    test('new tokens start home and cannot move without six', () {
      final state = LudoRules.newGame(playerCount: 2);
      expect(LudoRules.legalTokenIds(state.copyWith(dice: 5), 5), isEmpty);
      expect(LudoRules.legalTokenIds(state.copyWith(dice: 6), 6), [0, 1, 2, 3]);
    });

    test('six exits home and grants another turn', () {
      final result = LudoRules.move(LudoRules.newGame(playerCount: 2).copyWith(dice: 6), 0);
      expect(result.state.tokens['p0']![0].progress, 0);
      expect(result.state.currentPlayer, 0);
    });

    test('exact finish is required', () {
      final token = const TokenState(id: 0, progress: 56);
      final state = GameState(players: [const PlayerState(id: 'p0', name: 'A', color: PlayerColor.red)], tokens: {'p0': [token, const TokenState(id: 1), const TokenState(id: 2), const TokenState(id: 3)]}, currentPlayer: 0, dice: 2);
      expect(LudoRules.legalTokenIds(state, 2), [0]);
    });

    test('invalid movement throws', () {
      expect(() => LudoRules.move(LudoRules.newGame(playerCount: 2).copyWith(dice: 3), 0), throwsStateError);
    });

    test('safe cells are defined', () => expect(LudoRules.safeCells, contains(0)));
  });
}
