import 'package:charret/application/models/game.dart';

extension GameExtension on Game {
  static const usersIdsField = 'players_uids';
  static const player1RemainingTokensField = 'player1RemainingTokens';
  static const player2RemainingTokensField = 'player2RemainingTokens';
  static const boardField = 'board';
  static const stateField = 'state';

  static Game fromDoc(
      {required Map<String, dynamic> doc, required String uid}) {
    final String player1Uid =
        ((doc['usersIds'] ?? ['null', 'null']) as List)[0] ?? 'null';
    final String player2Uid =
        ((doc['usersIds'] ?? ['null', 'null']) as List)[1] ?? 'null';

    final int player1RemainingTokens = doc[player1RemainingTokensField] ?? 0;
    final int player2RemainingTokens = doc[player2RemainingTokensField] ?? 0;
    final List<List<List<int>>> board = [];
    // doc[boardField] ?? [];
    final String state = doc[stateField] ?? 'null';

    return Game(
        uid: uid,
        player1Uid: player1Uid,
        player2Uid: player2Uid,
        player1RemainingTokens: player1RemainingTokens,
        player2RemainingTokens: player2RemainingTokens,
        board: board,
        state: state);
  }
}
