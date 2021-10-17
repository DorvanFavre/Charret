import 'package:charret/application/global_message/global_message.dart';
import 'package:charret/application/models/auth_user.dart';
import 'package:charret/application/states/userLoggedIn/user_logged_in.dart';
import 'package:charret/data/auth/auth_repository.dart';

class UserLoggedInImpl implements UserLoggedIn {
  UserLoggedInImpl({required AuthUser authUser}) {
    print('CREATE User Logged In');
  }

  @override
  void dispose() {
    print('DISPOSE User Logged In');
  }

  @override
  void logout() {
    AuthRepository().logout().then((result) => GlobalMessage().add(result));
  }
}
