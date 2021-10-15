import 'package:charret/application/auth_state_machine/user_logged_in.dart';

class UserLoggedInImpl implements UserLoggedIn {
  UserLoggedInImpl() {
    print('CREATE User Logged In');
  }

  @override
  void dispose() {
    print('DISPOSE User Logged In');
  }
}
