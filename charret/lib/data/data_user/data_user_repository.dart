import 'package:charret/application/models/auth_user.dart';
import 'package:charret/application/models/data_user.dart';
import 'package:charret/application/models/result.dart';
import 'package:charret/data/data_user/data_user_repository_impl.dart';
import 'package:rxdart/rxdart.dart';

abstract class DataUserRepository {
  factory DataUserRepository({required AuthUser currentAuthUser}) {
    return DataUserRepositoryImpl(currentAuthUser: currentAuthUser);
  }

  ValueStream<DataUser> getDataUserStream();
  void setUserName(String name);

  Future<Result<DataUser>> getDataUserFromId({required String id});
}
