import 'package:charret/application/models/move.dart';

extension MoveExtension on Move {
  static const typeField = 'type';
  static const fromField = 'from';
  static const toField = 'to';
  static const addField = 'add';
  static const removeField = 'remove';
  static const playerIdField = 'playerId';

  Map<String, dynamic> toDoc() {
    return {
      typeField: type,
      fromField: from,
      toField: to,
      addField: add,
      removeField: remove,
      playerIdField: playerId
    };
  }
}
