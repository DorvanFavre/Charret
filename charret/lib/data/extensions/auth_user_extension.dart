import 'package:charret/application/models/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension AuthUserExtension on AuthUser {
  static AuthUser fromUser({required User user}) {
    return AuthUser(uid: user.uid);
  }
}
