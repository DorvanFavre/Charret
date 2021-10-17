import 'dart:async';

import 'package:charret/application/state_machine/state_machine.dart';
import 'package:charret/application/states/auth_state.dart';
import 'package:charret/application/states/ready/ready.dart';
import 'package:charret/data/auth/auth_repository.dart';

class ReadyImpl implements Ready {
  ReadyImpl({required AuthState authState})
      : authStateMachine = StateMachine(initialState: authState) {
    // Listen to user changes
    authSubscription = AuthRepository().getAuthStateStream().listen((state) {
      authStateMachine.add(state);
    });
  }

  StreamSubscription? authSubscription;

  @override
  final StateMachine<AuthState> authStateMachine;

  @override
  void dispose() {
    authSubscription?.cancel();
    authStateMachine.dispose();
  }
}
