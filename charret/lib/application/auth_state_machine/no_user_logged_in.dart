import 'package:charret/application/auth_state_machine/auth_state.dart';
import 'package:charret/application/auth_state_machine/no_user_logged_in_impl.dart';

abstract class NoUserLoggedIn extends AuthState {
  factory NoUserLoggedIn() {
    return NoUserLoggedInImpl();
  }
}
