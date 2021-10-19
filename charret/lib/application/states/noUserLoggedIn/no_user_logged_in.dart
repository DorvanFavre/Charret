import 'package:charret/application/states/auth_state.dart';
import 'package:charret/application/states/noUserLoggedIn/no_user_logged_in_impl.dart';

abstract class NoUserLoggedIn extends AuthState {
  factory NoUserLoggedIn() {
    return NoUserLoggedInImpl();
  }

  void login();
  void register();
  String loginEmail = '';
  String loginPassword = '';
  String registerEmail = '';
  String registerPassword = '';
  String registerRepeatPassword = '';
}
