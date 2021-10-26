import 'package:charret/application/models/game.dart';
import 'package:charret/application/states/inGame/in_game_impl.dart';
import 'package:charret/application/states/menu_state.dart';

abstract class InGame extends MenuState {
  factory InGame({required Game game}) {
    return InGameImpl(game: game);
  }
}
