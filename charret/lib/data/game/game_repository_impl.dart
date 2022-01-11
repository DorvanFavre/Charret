import 'package:charret/application/models/auth_user.dart';
import 'package:charret/application/models/game.dart';
import 'package:charret/application/models/move.dart';
import 'package:charret/data/extensions/game_extension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:charret/data/extensions/move_extension.dart';

import 'game_repository.dart';

class GameRepositoryImpl implements GameRepository {
  static const gamesCollection = 'Games';
  static const movesCollection = 'Moves';

  final AuthUser currentAuthUser;
  GameRepositoryImpl({required this.currentAuthUser});

  @override
  ValueStream<Game?> userGameStream() {
    return FirebaseFirestore.instance
        .collection(gamesCollection)
        .where(GameExtension.usersIdsField, arrayContains: currentAuthUser.uid)
        .where(GameExtension.isFinished, isEqualTo: false)
        .snapshots()
        .map((snap) {
      if (snap.docs.isEmpty) return null;
      return GameExtension.fromDoc(
          doc: snap.docs.first.data(), uid: snap.docs.first.id);
    }).shareValue();

    /*return FirebaseFirestore.instance
        .collection(gamesCollection)
        .where(GameExtension.usersIdsField, arrayContains: currentAuthUser.uid)
        .snapshots()
        .map((doc) => GameExtension.fromDoc(doc: doc.docs.first.data()));*/
  }

  @override
  ValueStream<Game> gameStream({required String gameId}) {
    return FirebaseFirestore.instance
        .collection(gamesCollection)
        .doc(gameId)
        .snapshots()
        .map((snap) {
      if (!snap.exists) {
        throw ErrorDescription(
            'Try to get a game document which does not exist');
      }
      return GameExtension.fromDoc(doc: snap.data()!, uid: snap.id);
    }).shareValue();
  }

  @override
  void sendAction({required Move move, required String gameId}) {
    FirebaseFirestore.instance
        .collection(gamesCollection)
        .doc(gameId)
        .collection(movesCollection)
        .add(move.toDoc());
  }

  @override
  void deleteGame({required String gameId}) {
    FirebaseFirestore.instance.collection(gamesCollection).doc(gameId).delete();
  }
}
