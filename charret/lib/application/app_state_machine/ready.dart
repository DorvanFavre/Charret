import 'package:charret/application/app_state_machine/ready_impl.dart';
import 'package:charret/application/auth_state_machine/auth_state.dart';
import 'package:charret/application/state_machine/state_machine.dart';

import 'app_state.dart';

abstract class Ready extends AppState {
  factory Ready({required AuthState authState}) {
    return ReadyImpl(authState: authState);
  }
  StateMachine<AuthState> get authStateMachine;
}
