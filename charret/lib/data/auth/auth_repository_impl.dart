import 'package:charret/application/models/result.dart';
import 'package:charret/application/states/auth_state.dart';
import 'package:charret/application/states/noUserLoggedIn/no_user_logged_in.dart';
import 'package:charret/application/states/userLoggedIn/user_logged_in.dart';
import 'package:charret/data/auth/auth_repository.dart';
import 'package:charret/data/extensions/auth_user_extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/src/streams/value_stream.dart';
import 'package:rxdart/rxdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  static final AuthRepositoryImpl _singleton = AuthRepositoryImpl._internal();

  factory AuthRepositoryImpl() {
    return _singleton;
  }

  AuthRepositoryImpl._internal();

  @override
  AuthState getAuthState() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return NoUserLoggedIn();
    } else {
      final authUser = AuthUserExtension.fromUser(user: user);
      return UserLoggedIn(authUser: authUser);
    }
  }

  @override
  Future<Result> login({required String email, required String password}) {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => Result.success(message: 'Logged in successffuly'))
        .catchError((e) => Result.failure(message: e.toString()));
  }

  @override
  Future<Result> logout() {
    return FirebaseAuth.instance
        .signOut()
        .then((value) => Result.success(message: 'Logout successfully'))
        .catchError((e) => Result.failure(message: e.toString()));
  }

  @override
  ValueStream<AuthState> getAuthStateStream() {
    return FirebaseAuth.instance
        .authStateChanges()
        .map<AuthState>((user) => user == null
            ? NoUserLoggedIn()
            : UserLoggedIn(authUser: AuthUserExtension.fromUser(user: user)))
        .shareValue();
  }
}
