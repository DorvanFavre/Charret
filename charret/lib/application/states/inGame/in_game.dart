import 'package:charret/application/models/auth_user.dart';
import 'package:charret/application/models/game.dart';
import 'package:charret/application/models/move.dart';
import 'package:charret/application/states/inGame/in_game_impl.dart';
import 'package:charret/application/states/menu_state.dart';
import 'package:rxdart/rxdart.dart';

abstract class InGame extends MenuState {
  factory InGame({required Game game, required AuthUser currentAuthUser}) {
    return InGameImpl(initialGame: game, currentAuthUser: currentAuthUser);
  }

  // Game received by the database
  ValueStream<Game> get gameStream;
  Game get initialGame;
  AuthUser get currentAuthUser;
  void leave();
  void makeAMove({required Move move});
  String? tokenToMove;
}
