import 'package:charret/application/models/auth_user.dart';
import 'package:charret/application/states/auth_state.dart';
import 'package:charret/application/states/userLoggedIn/user_logged_in_impl.dart';

abstract class UserLoggedIn extends AuthState {
  factory UserLoggedIn({required AuthUser authUser}) {
    return UserLoggedInImpl(authUser: authUser);
  }
}
