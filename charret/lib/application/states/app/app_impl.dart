import 'dart:async';

import 'package:charret/application/state_machine/state_machine.dart';
import 'package:charret/application/states/app_state.dart';
import 'package:charret/application/states/loading/loading.dart';
import 'package:charret/application/states/ready/ready.dart';
import 'package:charret/data/auth/auth_repository.dart';

import 'app.dart';

class AppImpl implements App {
  @override
  final StateMachine<AppState> appStateMachine =
      StateMachine(initialState: Loading());

  AppImpl() {
    init();

    /*Timer.periodic(const Duration(seconds: 3), (_) {
      if (appStateMachine.state.value is Loading) {
        appStateMachine.add(Ready(authState: NoUserLoggedIn()));
      } else {
        appStateMachine.add(Loading());
      }
    });*/
  }

  void init() async {
    // Wait 2 sec
    await Future.delayed(const Duration(seconds: 2));

    // Get the current user
    final authState = AuthRepository().getAuthState();

    // Set state Ready
    appStateMachine.add(Ready(authState: authState));
  }
}
