import 'package:charret/application/models/auth_user.dart';
import 'package:charret/application/models/result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/src/streams/value_stream.dart';

import 'package:charret/application/models/data_user.dart';

import 'data_user_repository.dart';
import 'package:rxdart/rxdart.dart';

import 'package:charret/data/extensions/data_user_extension.dart';

class DataUserRepositoryImpl implements DataUserRepository {
  static const usersCollection = 'Users';
  final AuthUser currentAuthUser;

  DataUserRepositoryImpl({required this.currentAuthUser});

  @override
  ValueStream<DataUser> getDataUserStream() {
    return FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(currentAuthUser.uid)
        .snapshots()
        .map((event) {
      if (!event.exists) {
        throw ErrorDescription(
            'Try to get a data user document which does not exist');
      }
      return DataUserExtension.fromDoc(doc: event.data()!);
    }).shareValue();
  }

  @override
  void setUserName(String name) {
    FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(currentAuthUser.uid)
        .set(DataUser(name: name, won: 0, loose: 0).toDoc());
  }

  @override
  Future<Result<DataUser>> getDataUserFromId({required String id}) {
    return FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(id)
        .get()
        .then((value) {
      if (value.exists) {
        return Success(data: DataUserExtension.fromDoc(doc: value.data()!));
      } else {
        return Result.failure() as Result<DataUser>;
      }
    }).catchError((e) => Result.failure() as Result<DataUser>);
  }
}
