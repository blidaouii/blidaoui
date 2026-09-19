import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:ludo_dz/game/ludo_rules.dart';
import 'package:ludo_dz/models/game_models.dart';

void main() {
  group('Ludo rules', () {
    test('supports two, three and four players', () {
      expect(LudoRules.newGame(playerCount: 2).players, hasLength(2));
      expect(LudoRules.newGame(playerCount: 3).players, hasLength(3));
      expect(LudoRules.newGame(playerCount: 4).players, hasLength(4));
      expect(() => LudoRules.newGame(playerCount: 5), throwsArgumentError);
    });

    test('home tokens require six and six grants another turn', () {
      final state = LudoRules.newGame(playerCount: 2).copyWith(dice: 6);
      expect(LudoRules.legalTokenIds(state, 6), [0, 1, 2, 3]);
      final after = LudoRules.move(state, 0).state;
      expect(after.tokens['p0']![0].progress, 0);
      expect(after.currentPlayer, 0);
    });

    test('ordinary movement changes turn and exact finish is enforced', () {
      final start = LudoRules.move(LudoRules.newGame(playerCount: 2).copyWith(dice: 6), 0).state.copyWith(dice: 2);
      expect(LudoRules.move(start, 0).state.currentPlayer, 1);
      final nearFinish = GameState(players: [const PlayerState(id: 'p0', name: 'A', color: PlayerColor.red)], tokens: {'p0': [const TokenState(id: 0, progress: 56), const TokenState(id: 1), const TokenState(id: 2), const TokenState(id: 3)]}, currentPlayer: 0, dice: 2);
      expect(LudoRules.legalTokenIds(nearFinish, 2), isEmpty);
    });

    test('safe cells prevent capture and board coordinates wrap', () {
      expect(LudoRules.safeCells, contains(0));
      expect(LudoRules.boardCell(PlayerColor.red, 52), -1);
      expect(LudoRules.boardCell(PlayerColor.green, 0), 13);
    });

    test('invalid moves throw and dice stays bounded', () {
      expect(() => LudoRules.move(LudoRules.newGame(playerCount: 2).copyWith(dice: 3), 0), throwsStateError);
      for (var i = 0; i < 30; i++) expect(LudoRules.roll(Random()), inInclusiveRange(1, 6));
    });
  });
}
