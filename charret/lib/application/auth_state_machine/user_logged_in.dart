import 'package:charret/application/auth_state_machine/auth_state.dart';
import 'package:charret/application/auth_state_machine/user_logged_in_impl.dart';

abstract class UserLoggedIn extends AuthState {
  factory UserLoggedIn() {
    return UserLoggedInImpl();
  }
}
