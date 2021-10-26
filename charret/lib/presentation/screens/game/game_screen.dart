import 'package:charret/application/models/game.dart';
import 'package:charret/application/states/inGame/in_game.dart';
import 'package:charret/presentation/widgets/in_hand_token.dart';
import 'package:charret/presentation/widgets/token.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inGameState = context.read<InGame>();

    return StreamBuilder<Game>(
        initialData: inGameState.initialGame,
        stream: inGameState.gameStream,
        builder: (context, snap) {
          final game = snap.data!;

          // Functions
          Widget tokensInHand() {
            return Container(
              height: 50,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                for (int i = 0;
                    i <
                        (game.player1Uid == inGameState.currentAuthUser.uid
                            ? game.player2RemainingTokens
                            : game.player1RemainingTokens);
                    i++)
                  InHandToken()
              ]),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Top Message
                Align(
                  alignment: Alignment.topCenter,
                  child: Stack(
                    children: [
                      game.state == 'player_1_has_to_play' &&
                              game.player1Uid == inGameState.currentAuthUser.uid
                          ? const Text('Your turn !')
                          : const SizedBox.shrink(),
                      game.state == 'player_2_has_to_play' &&
                              game.player2Uid == inGameState.currentAuthUser.uid
                          ? const Text('Your turn !')
                          : const SizedBox.shrink(),
                      game.state == 'player_1_has_to_play' &&
                              game.player1Uid != inGameState.currentAuthUser.uid
                          ? const Text('Other player turn...')
                          : const SizedBox.shrink(),
                      game.state == 'player_2_has_to_play' &&
                              game.player2Uid != inGameState.currentAuthUser.uid
                          ? const Text('Other player turn...')
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),

                // player tokens
                tokensInHand(),

                // Board
                Center(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: GridView.count(
                      crossAxisCount: 7,
                      children: [
                        Token(value: game.board['000']),
                        SizedBox.shrink(),
                        SizedBox.shrink(),
                        Token(value: game.board['001']),
                        SizedBox.shrink(),
                        SizedBox.shrink(),
                        Token(value: game.board['002']),
                        //
                        SizedBox.shrink(),
                        Token(value: game.board['100']),
                        SizedBox.shrink(),
                        Token(value: game.board['101']),
                        SizedBox.shrink(),
                        Token(value: game.board['102']),
                        SizedBox.shrink(),
                        //
                        SizedBox.shrink(),
                        SizedBox.shrink(),
                        Token(value: game.board['200']),
                        Token(value: game.board['201']),
                        Token(value: game.board['202']),
                        SizedBox.shrink(),
                        SizedBox.shrink(),
                        //
                        Token(value: game.board['010']),
                        Token(value: game.board['110']),
                        Token(value: game.board['210']),
                        SizedBox.shrink(),
                        Token(value: game.board['012']),
                        Token(value: game.board['112']),
                        Token(value: game.board['212']),
                        //
                        SizedBox.shrink(),
                        SizedBox.shrink(),
                        Token(value: game.board['220']),
                        Token(value: game.board['221']),
                        Token(value: game.board['222']),
                        SizedBox.shrink(),
                        SizedBox.shrink(),
                        //
                        SizedBox.shrink(),
                        Token(value: game.board['120']),
                        SizedBox.shrink(),
                        Token(value: game.board['121']),
                        SizedBox.shrink(),
                        Token(value: game.board['122']),
                        SizedBox.shrink(),
                        //
                        Token(value: game.board['020']),
                        SizedBox.shrink(),
                        SizedBox.shrink(),
                        Token(value: game.board['021']),
                        SizedBox.shrink(),
                        SizedBox.shrink(),
                        Token(value: game.board['022']),
                      ],
                    ),
                  ),
                ),

                // player tokens
                tokensInHand(),
              ],
            ),
          );
        });
  }
}
