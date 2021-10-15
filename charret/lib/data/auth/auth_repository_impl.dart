import 'package:charret/application/auth_state_machine/auth_state.dart';
import 'package:charret/application/auth_state_machine/no_user_logged_in.dart';
import 'package:charret/data/auth/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  static final AuthRepositoryImpl _singleton = AuthRepositoryImpl._internal();

  factory AuthRepositoryImpl() {
    return _singleton;
  }

  AuthRepositoryImpl._internal();

  @override
  Future<AuthState> getAuthState() {
    throw UnimplementedError();
  }
}
