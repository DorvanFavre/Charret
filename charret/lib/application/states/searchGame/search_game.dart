import 'package:charret/application/states/menu_state.dart';
import 'package:charret/application/states/searchGame/search_game_impl.dart';

abstract class SearchGame extends MenuState {
  factory SearchGame() {
    return SearchGameImpl();
  }
}
