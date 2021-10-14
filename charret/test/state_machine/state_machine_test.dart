import 'package:charret/application/state_machine/state_machine.dart';
import 'package:charret/application/state_machine/state_machine_impl.dart';
import 'package:flutter_test/flutter_test.dart';

import 'state_1_for_test.dart';
import 'state_2_for_test.dart';
import 'state_3_for_test.dart';
import 'state_for_test.dart';

void main() {
  test('State machine test', () async {
    // Instanciate the initial state
    final initialState = State1ForTest();

    // Instanciate the state machine
    final stateMachine =
        StateMachineImpl<StateForTest>(initialState: initialState);

    // Check if the state is correct
    expect(stateMachine.state.value, initialState);

    // Listen for some new state
    stateMachine.state.listen((newState) {
      print(newState.runtimeType);
    });

    // -> Check if it print the current state

    // Wait a sec...
    await Future.delayed(const Duration(seconds: 1));

    // Add new state
    stateMachine.add(State2ForTest());

    // -> check if it prints the 2 state and dispose the 1 state after a little while

    // Wait a sec...
    await Future.delayed(const Duration(milliseconds: 500));

    // Add new state
    stateMachine.add(State3ForTest());

    // -> check if it prints the 3 state and dispose the 2 state after a little while

    // Wait a sec...
    await Future.delayed(const Duration(milliseconds: 1000));

    // Dispose the state machine
    stateMachine.dispose();

    // -> Check if State 3 is disposed

    // Wait for some delayed action to occure
    await Future.delayed(const Duration(seconds: 5));
  });
}
