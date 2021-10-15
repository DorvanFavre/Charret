import 'package:charret/application/app/app_impl.dart';
import 'package:charret/application/app_state_machine/app_state.dart';
import 'package:charret/application/app_state_machine/loading.dart';
import 'package:charret/application/app_state_machine/ready.dart';
import 'package:charret/application/app_state_machine/ready_impl.dart';
import 'package:charret/application/auth_state_machine/auth_state.dart';
import 'package:charret/application/auth_state_machine/no_user_logged_in.dart';
import 'package:charret/application/auth_state_machine/user_logged_in.dart';
import 'package:charret/presentation/screens/auth/auth_screen.dart';
import 'package:charret/presentation/screens/loading/loading_screen.dart';
import 'package:charret/presentation/screens/menu/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthStateWrapper extends StatelessWidget {
  const AuthStateWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
        stream: context.read<Ready>().authStateMachine.state,
        builder: (context, snap) {
          final state = snap.data;
          if (state is NoUserLoggedIn) {
            return const AuthScreen();
          }
          if (state is UserLoggedIn) {
            return const MenuScreen();
          }
          return const Center(
            child: Text('ERROR'),
          );
        });
  }
}
