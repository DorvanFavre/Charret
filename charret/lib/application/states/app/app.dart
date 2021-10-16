import 'package:charret/application/state_machine/state_machine.dart';
import 'package:charret/application/states/app/app_impl.dart';
import 'package:charret/application/states/app_state.dart';

/// This is the top of the application Layer
///
/// Provide an instance of this class to the presentation layer
abstract class App {
  factory App() {
    return AppImpl();
  }
  StateMachine<AppState> get appStateMachine;
}
