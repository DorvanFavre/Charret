import 'package:charret/application/models/data_user.dart';

extension DataUserExtension on DataUser {
  static const nameField = 'name';
  static const wonField = 'won';
  static const looseField = 'loose';

  static DataUser fromDoc({required Map<String, dynamic> doc}) {
    final String name = doc[nameField] ?? 'Unknown';
    final int won = doc[wonField] ?? 0;
    final int loose = doc[looseField] ?? 0;
    return DataUser(name: name, won: won, loose: loose);
  }

  Map<String, dynamic> toDoc() {
    return {nameField: name};
  }
}
