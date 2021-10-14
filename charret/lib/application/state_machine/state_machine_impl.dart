import 'package:charret/application/state_machine/m_state.dart';
import 'package:charret/application/state_machine/state_machine.dart';
import 'package:rxdart/rxdart.dart';

class StateMachineImpl<R extends MState> implements StateMachine<R> {
  final timeToDispose = const Duration(milliseconds: 300);

  StateMachineImpl({required R initialState})
      : _subject = BehaviorSubject.seeded(initialState),
        _oldState = initialState {
    state = _subject.stream;
  }

  BehaviorSubject<R> _subject;
  R _oldState;

  @override
  late ValueStream<R> state;

  /// When a new state is added, dispose the old one after a little while (let the presentation close subscriptions of old state befor disposing it)
  @override
  void add(state) {
    _subject.add(state);

    final oldStateTemp = _oldState;
    Future.delayed(timeToDispose).then((value) {
      oldStateTemp.dispose();
    });

    _oldState = state;
  }

  /// Dispose the current state and the BehaviorSubject
  @override
  void dispose() {
    Future.delayed(timeToDispose).then((value) {
      state.value.dispose();
      _subject.close();
    });
  }
}
