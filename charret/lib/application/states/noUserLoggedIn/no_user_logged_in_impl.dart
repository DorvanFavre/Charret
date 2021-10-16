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
        .login(email: 'test@gmail.com', password: '12345678')
        .then((result) => print(result));
  }
}
