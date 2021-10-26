import 'package:charret/application/states/inGame/in_game.dart';
import 'package:charret/application/states/inMenu/in_menu.dart';
import 'package:charret/application/states/menu_state.dart';
import 'package:charret/application/states/searchGame/search_game.dart';
import 'package:charret/application/states/userLoggedIn/user_logged_in.dart';
import 'package:charret/presentation/screens/game/game_screen.dart';
import 'package:charret/presentation/screens/menu/menu_screen.dart';
import 'package:charret/presentation/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserLoggedInWrapper extends StatelessWidget {
  const UserLoggedInWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MenuState>(
        initialData: context.read<UserLoggedIn>().menuStateMachine.state.value,
        stream: context.read<UserLoggedIn>().menuStateMachine.state,
        builder: (context, snap) {
          final state = snap.data;
          if (state is InMenu) {
            return MenuScreen();
          }
          if (state is SearchGame) {
            return SearchScreen();
          }
          if (state is InGame) {
            return GameScreen();
          }
          return const Center(
            child: Text('ERROR'),
          );
        });
  }
}
