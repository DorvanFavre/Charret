import 'package:charret/application/models/auth_user.dart';
import 'package:charret/application/models/game.dart';
import 'package:charret/application/states/inGame/in_game.dart';
import 'package:charret/data/game/game_repository.dart';
import 'package:rxdart/rxdart.dart';

class InGameImpl implements InGame {
  final Game initialGame;
  final AuthUser currentAuthUser;
  InGameImpl({required this.initialGame, required this.currentAuthUser})
      : gameStream = GameRepository(currentAuthUser: currentAuthUser)
            .gameStream(gameId: initialGame.uid);

  @override
  final ValueStream<Game> gameStream;

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
