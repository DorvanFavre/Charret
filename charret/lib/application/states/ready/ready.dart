import 'package:charret/application/state_machine/state_machine.dart';
import 'package:charret/application/states/app_state.dart';
import 'package:charret/application/states/auth_state.dart';
import 'package:charret/application/states/ready/ready_impl.dart';

/// Listen to user changes
abstract class Ready extends AppState {
  factory Ready({required AuthState authState}) {
    return ReadyImpl(authState: authState);
  }
  StateMachine<AuthState> get authStateMachine;
}
