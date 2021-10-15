import 'dart:async';

import 'package:charret/application/app/app.dart';
import 'package:charret/application/app_state_machine/loading.dart';
import 'package:charret/application/app_state_machine/loading_impl.dart';
import 'package:charret/application/app_state_machine/ready.dart';
import 'package:charret/application/app_state_machine/ready_impl.dart';
import 'package:charret/application/auth_state_machine/no_user_logged_in.dart';
import 'package:charret/application/auth_state_machine/no_user_logged_in_impl.dart';
import 'package:charret/application/state_machine/state_machine.dart';
import 'package:charret/application/app_state_machine/app_state.dart';
import 'package:charret/application/state_machine/state_machine_impl.dart';

class AppImpl implements App {
  @override
  final StateMachine<AppState> appStateMachine =
      StateMachine(initialState: Loading());

  AppImpl() {
    // change app state after few seconds
    /*Future.delayed(const Duration(seconds: 3)).then((value) {
      appStateMachine
          .add(Ready(authState: NoUserLoggedIn())); // TODO change here
    });*/

    Timer.periodic(const Duration(seconds: 3), (_) {
      if (appStateMachine.state.value is Loading) {
        appStateMachine.add(Ready(authState: NoUserLoggedIn()));
      } else {
        appStateMachine.add(Loading());
      }
    });
  }
}
