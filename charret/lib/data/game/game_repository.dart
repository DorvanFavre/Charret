import 'package:charret/application/models/auth_user.dart';
import 'package:charret/application/models/game.dart';
import 'package:charret/application/models/move.dart';
import 'package:charret/data/game/game_repository_impl.dart';
import 'package:rxdart/rxdart.dart';

abstract class GameRepository {
  factory GameRepository({required AuthUser currentAuthUser}) {
    return GameRepositoryImpl(currentAuthUser: currentAuthUser);
  }

  // receive a game instance when a new game in which the current user play is created
  ValueStream<Game?> userGameStream();

  // Get the game changes (new instance for every changement)
  ValueStream<Game> gameStream({required String gameId});

  void sendAction({required Move move, required String gameId});

  void deleteGame({required String gameId});
}
