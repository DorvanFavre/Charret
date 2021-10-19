import 'package:charret/application/models/result.dart';
import 'package:charret/application/states/auth_state.dart';
import 'package:rxdart/rxdart.dart';

import 'auth_repository_impl.dart';

abstract class AuthRepository {
  factory AuthRepository() {
    return AuthRepositoryImpl();
  }

  AuthState getAuthState();
  ValueStream<AuthState> getAuthStateStream();

  Future<Result> login({required String email, required String password});
  Future<Result> logout();
  Future<Result> register({required String email, required String password});
}
