import 'package:charret/application/models/auth_user.dart';
import 'package:charret/application/models/result.dart';
import 'package:charret/data/search/search_repository_impl.dart';

abstract class SearchRepository {
  factory SearchRepository({required AuthUser currentAuthUser}) {
    return SearchRepositoryImpl(currentAuthUser: currentAuthUser);
  }

  Future<Result> addToWaitingRoom();
  Future<Result> removeFromWaitingRoom();
}
