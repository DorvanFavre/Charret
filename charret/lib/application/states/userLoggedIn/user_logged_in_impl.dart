import 'package:charret/application/models/auth_user.dart';
import 'package:charret/application/states/userLoggedIn/user_logged_in.dart';

class UserLoggedInImpl implements UserLoggedIn {
  UserLoggedInImpl({required AuthUser authUser}) {
    print('CREATE User Logged In');
  }

  @override
  void dispose() {
    print('DISPOSE User Logged In');
  }
}
