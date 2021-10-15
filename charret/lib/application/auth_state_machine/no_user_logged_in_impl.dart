import 'package:charret/application/auth_state_machine/no_user_logged_in.dart';

class NoUserLoggedInImpl implements NoUserLoggedIn {
  NoUserLoggedInImpl() {
    print('CREATE No user logged in');
  }

  @override
  void dispose() {
    print('DISPOSE No user logged in');
  }
}
