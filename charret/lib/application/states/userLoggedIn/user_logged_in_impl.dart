import 'dart:async';

import 'package:charret/application/global_message/global_message.dart';
import 'package:charret/application/models/auth_user.dart';
import 'package:charret/application/models/result.dart';
import 'package:charret/application/states/inGame/in_game.dart';
import 'package:charret/application/states/inMenu/in_menu.dart';
import 'package:charret/application/states/menu_state.dart';
import 'package:charret/application/state_machine/state_machine.dart';
import 'package:charret/application/states/searchGame/search_game.dart';
import 'package:charret/application/states/userLoggedIn/user_logged_in.dart';
import 'package:charret/data/auth/auth_repository.dart';
import 'package:charret/data/game/game_repository.dart';
import 'package:charret/data/search/search_repository.dart';

class UserLoggedInImpl implements UserLoggedIn {
  UserLoggedInImpl({required this.currentAuthUser}) {
    //print('UserLoggedInImpl ${this.hashCode}: create');

    // Listen for games
    gameSubscription = GameRepository(currentAuthUser: currentAuthUser)
        .userGameStream()
        .listen((game) {
      print(menuStateMachine.state.value);
      if (game != null) {
        if (menuStateMachine.state.value is InMenu ||
            menuStateMachine.state.value is SearchGame) {
          GlobalMessage().add(Result.success(message: 'Game found'));
          menuStateMachine
              .add(InGame(game: game, currentAuthUser: currentAuthUser));
        }
      } else {
        menuStateMachine.add(InMenu());
      }
    });
  }

  StreamSubscription? gameSubscription;

  @override
  void dispose() {
    //print('UserLoggedInImpl ${this.hashCode}: dispose');
    gameSubscription?.cancel();
  }

  @override
  void logout() {
    AuthRepository().logout().then((result) => GlobalMessage().add(result));
  }

  @override
  final AuthUser currentAuthUser;

  @override
  StateMachine<MenuState> menuStateMachine =
      StateMachine<MenuState>(initialState: InMenu());

  @override
  void searchGame() {
    menuStateMachine.add(SearchGame());
    SearchRepository(currentAuthUser: currentAuthUser)
        .addToWaitingRoom()
        .then((result) {
      if (result is Failure) {
        menuStateMachine.add(InMenu());
        GlobalMessage().add(result);
      }
    });
  }

  @override
  void abortGameSearching() {
    menuStateMachine.add(InMenu());
    SearchRepository(currentAuthUser: currentAuthUser)
        .removeFromWaitingRoom()
        .then((result) {
      if (result is Failure) {
        menuStateMachine.add(SearchGame());
        GlobalMessage().add(result);
      }
    });
  }
}
