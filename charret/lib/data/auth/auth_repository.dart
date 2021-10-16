import 'package:charret/application/models/result.dart';
import 'package:charret/application/states/auth_state.dart';

import 'auth_repository_impl.dart';

abstract class AuthRepository {
  factory AuthRepository() {
    return AuthRepositoryImpl();
  }

  AuthState getAuthState();

  Future<Result> login({required String email, required String password});
}
