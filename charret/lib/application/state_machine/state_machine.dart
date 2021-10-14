import 'package:rxdart/rxdart.dart';

abstract class StateMachine<S> {
  late final ValueStream<S> state;
  void add(S state);
  void dispose();
}
