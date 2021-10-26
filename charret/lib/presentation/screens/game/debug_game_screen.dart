import 'package:charret/application/models/game.dart';
import 'package:charret/application/states/inGame/in_game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DebugGameScreen extends StatelessWidget {
  const DebugGameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inGameState = context.read<InGame>();

    return StreamBuilder<Game>(
        initialData: inGameState.initialGame,
        stream: inGameState.gameStream,
        builder: (context, snap) {
          final game = snap.data!;
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('In game'),
                Text('Game uid: ' + game.uid),
                Text('player 1 uid: ' + game.player1Uid),
                Text('player 2 uid: ' + game.player2Uid),
                Text('board: ' + game.board.toString()),
                Text('player 1 tokens: ' +
                    game.player1RemainingTokens.toString()),
                Text('player 2 tokens: ' +
                    game.player2RemainingTokens.toString()),
                Text('state : ' + game.state.toString())
              ],
            ),
          );
        });
  }
}
