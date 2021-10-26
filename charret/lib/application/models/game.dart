class Game {
  final String uid;

  final String player1Uid;
  final String player2Uid;

  final List<List<List<int>>> board;

  final int player1RemainingTokens;
  final int player2RemainingTokens;

  /// 0: do nothing
  /// 1: player_1_has_to_play
  /// 2: player_2_has_to_play
  /// 10: player 1 won
  /// 12: player 2 won
  final String state;

  Game(
      {required this.uid,
      required this.player1Uid,
      required this.player2Uid,
      required this.player1RemainingTokens,
      required this.player2RemainingTokens,
      required this.board,
      required this.state});
}
