import 'package:charret/application/models/game.dart';
import 'package:charret/application/states/inGame/in_game.dart';
import 'package:charret/presentation/widgets/in_hand_token.dart';
import 'package:charret/presentation/widgets/skin.dart';
import 'package:charret/presentation/widgets/token.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    final inGameState = context.read<InGame>();

    return Scaffold(
      appBar: AppBar(
        actions: [
          Spacer(),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    child: Padding(
                        padding: const EdgeInsets.all(50),
                        child: ElevatedButton(
                          child: const Text('Leave the game ?'),
                          onPressed: () {
                            inGameState.leave();
                            Navigator.of(context).pop();
                          },
                        )),
                  ),
                );
              },
              icon: const Icon(FontAwesomeIcons.cog))
        ],
      ),
      body: StreamBuilder<Game>(
          initialData: inGameState.initialGame,
          stream: inGameState.gameStream,
          builder: (context, snap) {
            final game = snap.data!;

            bool isCurrentPlayerPlayer1() {
              return game.player1Uid == inGameState.currentAuthUser.uid;
            }

            // Functions
            Widget tokensInHand(bool isPlayer1) {
              return Container(
                height: 50,
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  for (int i = 0;
                      i <
                          (isPlayer1
                              ? game.player1RemainingTokens
                              : game.player2RemainingTokens);
                      i++)
                    Container(
                        padding: EdgeInsets.all(5),
                        height: 30,
                        width: 30,
                        child: Skin(
                            isCurrentPlayer:
                                isPlayer1 == isCurrentPlayerPlayer1()))
                ]),
              );
            }

            bool isPlayerTurn() {
              return (game.state == 'player_1_has_to_play' &&
                      game.player1Uid == inGameState.currentAuthUser.uid) ||
                  (game.state == 'player_2_has_to_play' &&
                      game.player2Uid == inGameState.currentAuthUser.uid);
            }

            return GestureDetector(
              onTap: () {
                setState(() {
                  inGameState.tokenToMove = null;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // Top Message
                    Center(
                      child: Text(isPlayerTurn() ? 'Your turn' : 'Wait...'),
                    ),
                    isPlayerTurn()
                        ? Center(
                            child: Text(game.move),
                          )
                        : SizedBox.shrink(),

                    // player tokens
                    tokensInHand(!isCurrentPlayerPlayer1()),

                    // Board
                    Expanded(
                      child: Center(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Stack(
                            children: [
                              /*const Image(
                                image: AssetImage('assets/e.jpg'),
                              ),*/
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 35.0, left: 30.0, bottom: 30),
                                child: Image.asset(
                                  'assets/plateau.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              GridView.count(
                                crossAxisCount: 7,
                                children: [
                                  Token(
                                    value: '000',
                                    game: game,
                                    setState: () {
                                      setState(() {});
                                    },
                                  ),
                                  SizedBox.shrink(),
                                  SizedBox.shrink(),
                                  Token(
                                    value: '001',
                                    game: game,
                                    setState: () {
                                      setState(() {});
                                    },
                                  ),
                                  SizedBox.shrink(),
                                  SizedBox.shrink(),
                                  Token(
                                    value: '002',
                                    game: game,
                                    setState: () {
                                      setState(() {});
                                    },
                                  ),
                                  //
                                  SizedBox.shrink(),
                                  Token(
                                    value: '100',
                                    game: game,
                                    setState: () {
                                      setState(() {});
                                    },
                                  ),
                                  SizedBox.shrink(),
                                  Token(
                                    value: '101',
                                    game: game,
                                    setState: () {
                                      setState(() {});
                                    },
                                  ),
                                  SizedBox.shrink(),
                                  Token(
                                    value: '102',
                                    game: game,
                                    setState: () {
                                      setState(() {});
                                    },
                                  ),
                                  SizedBox.shrink(),
                                  //
                                  SizedBox.shrink(),
                                  SizedBox.shrink(),
                                  Token(
                                    value: '200',
                                    game: game,
                                    setState: () {
                                      setState(() {});
                                    },
                                  ),
                                  Token(
                                    value: '201',
                                    game: game,
                                    setState: () {
                                      setState(() {});
                                    },
                                  ),
                                  Token(
                                    value: '202',
                                    game: game,
                                    setState: () {
                                      setState(() {});
                                    },
                                  ),
                                  SizedBox.shrink(),
                                  SizedBox.shrink(),
                                  //
                                  Token(
                                    value: '010',
                                    game: game,
                                    setState: () {
                                      setState(() {});
                                    },
                                  ),
                                  Token(
                                    value: '110',
                                    game: game,
                                    setState: () {
                                      setState(() {});
                                    },
                                  ),
                                  Token(
                                    value: '210',
                                    game: game,
                                    setState: () {
                                      setState(() {});
                                    },
                                  ),
                                  SizedBox.shrink(),
                                  Token(
                                    value: '212',
                                    game: game,
                                    setState: () {
                                      setState(() {});
                                    },
                                  ),
                                  Token(
                                    value: '112',
                                    game: game,
                                    setState: () {
                                      setState(() {});
                                    },
                                  ),
                                  Token(
                                    value: '012',
                                    game: game,
                                    setState: () {
                                      setState(() {});
                                    },
                                  ),
                                  //
                                  SizedBox.shrink(),
                                  SizedBox.shrink(),
                                  Token(
                                    value: '220',
                                    game: game,
                                    setState: () {
                                      setState(() {});
                                    },
                                  ),
                                  Token(
                                    value: '221',
                                    game: game,
                                    setState: () {
                                      setState(() {});
                                    },
                                  ),
                                  Token(
                                    value: '222',
                                    game: game,
                                    setState: () {
                                      setState(() {});
                                    },
                                  ),
                                  SizedBox.shrink(),
                                  SizedBox.shrink(),
                                  //
                                  SizedBox.shrink(),
                                  Token(
                                    value: '120',
                                    game: game,
                                    setState: () {
                                      setState(() {});
                                    },
                                  ),
                                  SizedBox.shrink(),
                                  Token(
                                    value: '121',
                                    game: game,
                                    setState: () {
                                      setState(() {});
                                    },
                                  ),
                                  SizedBox.shrink(),
                                  Token(
                                    value: '122',
                                    game: game,
                                    setState: () {
                                      setState(() {});
                                    },
                                  ),
                                  SizedBox.shrink(),
                                  //
                                  Token(
                                    value: '020',
                                    game: game,
                                    setState: () {
                                      setState(() {});
                                    },
                                  ),
                                  SizedBox.shrink(),
                                  SizedBox.shrink(),
                                  Token(
                                    value: '021',
                                    game: game,
                                    setState: () {
                                      setState(() {});
                                    },
                                  ),
                                  SizedBox.shrink(),
                                  SizedBox.shrink(),
                                  Token(
                                    value: '022',
                                    game: game,
                                    setState: () {
                                      setState(() {});
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // player tokens
                    tokensInHand(isCurrentPlayerPlayer1()),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
