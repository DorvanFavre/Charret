import 'package:charret/application/app/app_impl.dart';
import 'package:charret/application/app_state_machine/app_state.dart';
import 'package:charret/application/state_machine/state_machine.dart';

/// This is the top of the application Layer
///
/// Provide an instance of this class to the presentation layer
abstract class App {
  factory App() {
    return AppImpl();
  }
  StateMachine<AppState> get appStateMachine;
}
