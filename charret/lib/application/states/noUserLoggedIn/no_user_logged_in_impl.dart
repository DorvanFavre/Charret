import 'package:charret/application/global_message/global_message.dart';
import 'package:charret/application/states/noUserLoggedIn/no_user_logged_in.dart';
import 'package:charret/data/auth/auth_repository.dart';

class NoUserLoggedInImpl implements NoUserLoggedIn {
  NoUserLoggedInImpl() {
    print('CREATE No user logged in');
  }

  @override
  void dispose() {
    print('DISPOSE No user logged in');
  }

  @override
  void login() {
    AuthRepository()
        .login(email: loginEmail, password: loginPassword)
        .then((result) => GlobalMessage().add(result));
  }

  @override
  String loginEmail = '';

  @override
  String loginPassword = '';

  @override
  void register() {
    // TODO: implement register
  }
}
