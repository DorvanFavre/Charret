import 'package:charret/application/global_message/global_message.dart';
import 'package:charret/application/models/result.dart';
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
    String? errorMessage;
    if (registerEmail.trim().isEmpty) {
      errorMessage = 'Enter an email';
    } else if (!registerEmail.contains('@')) {
      errorMessage = 'Enter a valid email';
    } else if (registerPassword.length < 8) {
      errorMessage = 'Password has to be at least 8 character long';
    } else if (registerPassword.compareTo(registerRepeatPassword) != 0) {
      errorMessage = 'Passwords dont match';
    }

    if (errorMessage != null) {
      GlobalMessage().add(Failure(message: errorMessage));
    } else {
      AuthRepository()
          .register(email: registerEmail, password: registerPassword)
          .then((value) {
        GlobalMessage().add(Success(message: value.message));
      });
    }
  }

  @override
  String registerEmail = '';

  @override
  String registerPassword = '';

  @override
  String registerRepeatPassword = '';
}
