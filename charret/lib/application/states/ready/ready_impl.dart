import 'dart:async';

import 'package:charret/application/state_machine/state_machine.dart';
import 'package:charret/application/states/auth_state.dart';
import 'package:charret/application/states/ready/ready.dart';

class ReadyImpl implements Ready {
  ReadyImpl({required AuthState authState})
      : authStateMachine = StateMachine(initialState: authState) {
    // Test
    /*t = Timer.periodic(const Duration(milliseconds: 800), (_) {
      if (authStateMachine.state.value is NoUserLoggedIn) {
        authStateMachine.add(UserLoggedIn());
      } else {
        authStateMachine.add(NoUserLoggedIn());
      }
    });*/
  }

  //test
  late Timer t;

  @override
  final StateMachine<AuthState> authStateMachine;

  @override
  void dispose() {
    t.cancel();
    authStateMachine.dispose();
  }
}
