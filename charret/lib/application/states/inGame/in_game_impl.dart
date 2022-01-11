import 'package:charret/application/models/auth_user.dart';
import 'package:charret/application/models/data_user.dart';
import 'package:charret/application/models/game.dart';
import 'package:charret/application/models/move.dart';
import 'package:charret/application/models/result.dart';
import 'package:charret/application/states/inGame/in_game.dart';
import 'package:charret/data/data_user/data_user_repository.dart';
import 'package:charret/data/game/game_repository.dart';
import 'package:rxdart/rxdart.dart';

class InGameImpl implements InGame {
  final Game initialGame;
  final AuthUser currentAuthUser;
  final Function goToMenu_;
  InGameImpl(
      {required this.initialGame,
      required this.currentAuthUser,
      required this.goToMenu_})
      : gameStream = GameRepository(currentAuthUser: currentAuthUser)
            .gameStream(gameId: initialGame.uid);

  @override
  final ValueStream<Game> gameStream;

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void makeAMove({required Move move}) {
    GameRepository(currentAuthUser: currentAuthUser)
        .sendAction(move: move, gameId: initialGame.uid);
  }

  @override
  String? tokenToMove;

  @override
  void leave() {
    final move = Move(playerId: currentAuthUser.uid, type: 'abort');
    makeAMove(move: move);
  }

  @override
  Function goToMenu() {
    return goToMenu_();
  }

  @override
  Future<String> getOpponentName() {
    final id = initialGame.player1Uid == currentAuthUser.uid
        ? initialGame.player2Uid
        : initialGame.player1Uid;

    return DataUserRepository(currentAuthUser: currentAuthUser)
        .getDataUserFromId(id: id)
        .then((value) {
      if (value is Success<DataUser>) {
        return value.data!.name;
      } else {
        return 'Unknown';
      }
    });
  }
}
