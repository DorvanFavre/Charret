import 'package:charret/application/models/auth_user.dart';
import 'package:charret/application/models/result.dart';
import 'package:charret/data/extensions/auth_user_extension.dart';
import 'package:charret/data/extensions/game_extension.dart';
import 'package:charret/data/search/search_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchRepositoryImpl implements SearchRepository {
  final AuthUser currentAuthUser;
  SearchRepositoryImpl({required this.currentAuthUser});

  static const waitingRoomCollection = 'WaitingRoom';

  @override
  Future<Result> addToWaitingRoom() async {
    return FirebaseFirestore.instance
        .collection(waitingRoomCollection)
        .doc(currentAuthUser.uid)
        .set(currentAuthUser.toDoc())
        .then((value) => Result.success())
        .catchError((e) {
      return Result.failure(message: e.toString());
    });
  }

  @override
  Future<Result> removeFromWaitingRoom() {
    return FirebaseFirestore.instance
        .collection(waitingRoomCollection)
        .doc(currentAuthUser.uid)
        .delete()
        .then((value) => Result.success())
        .catchError((e) {
      return Result.failure(message: e.toString());
    });
  }
}
