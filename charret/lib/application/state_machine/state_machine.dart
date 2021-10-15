import 'package:charret/application/state_machine/m_state.dart';
import 'package:charret/application/state_machine/state_machine_impl.dart';
import 'package:rxdart/rxdart.dart';

abstract class StateMachine<S extends MState> {
  factory StateMachine({required S initialState}) {
    return StateMachineImpl<S>(initialState: initialState);
  }
  late final ValueStream<S> state;
  void add(S state);
  void dispose();
}
