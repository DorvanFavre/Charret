import 'package:charret/application/models/auth_user.dart';
import 'package:charret/application/models/game.dart';
import 'package:charret/data/game/game_repository_impl.dart';
import 'package:rxdart/rxdart.dart';

abstract class GameRepository {
  factory GameRepository({required AuthUser currentAuthUser}) {
    return GameRepositoryImpl(currentAuthUser: currentAuthUser);
  }

  ValueStream<Game?> userGameStream();
}
