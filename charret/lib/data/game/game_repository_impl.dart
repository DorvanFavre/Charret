import 'package:charret/application/models/auth_user.dart';
import 'package:charret/application/models/game.dart';
import 'package:charret/data/extensions/game_extension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

import 'game_repository.dart';

class GameRepositoryImpl implements GameRepository {
  static const gamesCollection = 'Games';

  final AuthUser currentAuthUser;
  GameRepositoryImpl({required this.currentAuthUser});

  @override
  ValueStream<Game?> userGameStream() {
    return FirebaseFirestore.instance
        .collection(gamesCollection)
        .where(GameExtension.usersIdsField, arrayContains: currentAuthUser.uid)
        .snapshots()
        .map((doc) {
      if (doc.docs.isEmpty) return null;
      return GameExtension.fromDoc(
          doc: doc.docs.first.data(), uid: doc.docs.first.id);
    }).shareValue();

    /*return FirebaseFirestore.instance
        .collection(gamesCollection)
        .where(GameExtension.usersIdsField, arrayContains: currentAuthUser.uid)
        .snapshots()
        .map((doc) => GameExtension.fromDoc(doc: doc.docs.first.data()));*/
  }
}
