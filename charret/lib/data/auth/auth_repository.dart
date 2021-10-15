import 'package:charret/application/auth_state_machine/auth_state.dart';
import 'package:charret/data/auth/auth_repository_impl.dart';

abstract class AuthRepository {
  factory AuthRepository() {
    return AuthRepositoryImpl();
  }

  Future<AuthState> getAuthState();
}
