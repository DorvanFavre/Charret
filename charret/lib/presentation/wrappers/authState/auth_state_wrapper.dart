import 'package:charret/application/states/auth_state.dart';
import 'package:charret/application/states/noUserLoggedIn/no_user_logged_in.dart';
import 'package:charret/application/states/ready/ready.dart';
import 'package:charret/application/states/userLoggedIn/user_logged_in.dart';
import 'package:charret/presentation/screens/auth/auth_screen.dart';
import 'package:charret/presentation/screens/menu/menu_screen.dart';
import 'package:charret/presentation/wrappers/userLoggedInWrapper/user_logged_in_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthStateWrapper extends StatelessWidget {
  const AuthStateWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
        initialData: context.read<Ready>().authStateMachine.state.value,
        stream: context.read<Ready>().authStateMachine.state,
        builder: (context, snap) {
          final state = snap.data;
          if (state is NoUserLoggedIn) {
            return Provider<NoUserLoggedIn>.value(
                value: state,
                builder: (context, _) {
                  return const AuthScreen();
                });
          }
          if (state is UserLoggedIn) {
            return Provider<UserLoggedIn>.value(
                value: state,
                builder: (context, _) {
                  return const UserLoggedInWrapper();
                });
          }
          return const Center(
            child: Text('ERROR'),
          );
        });
  }
}
