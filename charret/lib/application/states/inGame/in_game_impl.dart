import 'package:charret/application/models/game.dart';
import 'package:charret/application/states/inGame/in_game.dart';

class InGameImpl implements InGame {
  final Game game;
  InGameImpl({required this.game});

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
