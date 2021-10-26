import 'package:charret/application/models/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension AuthUserExtension on AuthUser {
  static const uidField = 'uid';

  static AuthUser fromUser({required User user}) {
    return AuthUser(uid: user.uid);
  }

  Map<String, dynamic> toDoc() {
    return {uidField: uid};
  }

  static AuthUser fromDoc({required Map<String, dynamic> doc}) {
    final uid = doc[uidField];
    return AuthUser(uid: uid);
  }
}
