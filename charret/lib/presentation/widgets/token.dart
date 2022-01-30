import 'dart:math';

import 'package:charret/application/models/game.dart';
import 'package:charret/application/models/move.dart';
import 'package:charret/application/states/inGame/in_game.dart';
import 'package:charret/presentation/widgets/breath_animation.dart';
import 'package:charret/presentation/widgets/skin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Token extends StatelessWidget {
  final String value;
  final Game game;
  final void Function() setState;
  const Token(
      {Key? key,
      required this.value,
      required this.game,
      required this.setState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inGameState = context.read<InGame>();

    int currentPlayerNumber() {
      return game.player1Uid == inGameState.currentAuthUser.uid ? 1 : 2;
    }

    bool isCurrentPlayerToken() {
      return game.board[value] == currentPlayerNumber();
    }

    bool isOtherPlayerToken() {
      return game.board[value] == (currentPlayerNumber() == 1 ? 2 : 1);
    }

    bool isEmtpy() {
      return game.board[value] == 0;
    }

    bool isPlayerTurn() {
      return (game.state == 'player_1_has_to_play' &&
              game.player1Uid == inGameState.currentAuthUser.uid) ||
          (game.state == 'player_2_has_to_play' &&
              game.player2Uid == inGameState.currentAuthUser.uid);
    }

    bool moveIsAddToken() {
      return game.move == 'add_token';
    }

    bool canAddToken() {
      return isPlayerTurn() && moveIsAddToken() && isEmtpy();
    }

    bool canRemoveToken() {
      return isPlayerTurn() &&
          game.move == 'remove_token' &&
          isOtherPlayerToken();
    }

    bool choseATokenToMove() {
      return isPlayerTurn() &&
          game.move == 'move_token' &&
          inGameState.tokenToMove == null &&
          isCurrentPlayerToken();
    }

    bool isNextToTokenToMove() {
      final z1 = int.parse(inGameState.tokenToMove![0]);
      final y1 = int.parse(inGameState.tokenToMove![1]);
      final x1 = int.parse(inGameState.tokenToMove![2]);

      final z2 = int.parse(value[0]);
      final y2 = int.parse(value[1]);
      final x2 = int.parse(value[2]);

      int sum = 0;

      sum += (x1 - x2).abs();
      sum += (y1 - y2).abs();
      sum += (z1 - z2).abs();

      if (x1 != 1 && x2 != 1 && y1 != 1 && y2 != 1) return false;

      return sum == 1;
    }

    bool canFlight() {
      int numberOfTokensOnBoard = 0;
      (game.board as Map).values.forEach((element) {
        if (element == currentPlayerNumber()) {
          numberOfTokensOnBoard++;
        }
      });
      return numberOfTokensOnBoard == 3;
    }

    bool isValidCaseToGo() {
      return isNextToTokenToMove() || canFlight();
    }

    bool choseACaseToGo() {
      return isPlayerTurn() &&
          game.move == 'move_token' &&
          inGameState.tokenToMove != null &&
          isValidCaseToGo() &&
          isEmtpy();
    }

    bool highlightToken() {
      return canAddToken() ||
          canRemoveToken() ||
          choseATokenToMove() ||
          choseACaseToGo();
    }

    void onTap() {
      if (canAddToken()) {
        inGameState.makeAMove(
            move: Move(
                playerId: inGameState.currentAuthUser.uid,
                type: 'add',
                add: value));
      } else if (canRemoveToken()) {
        inGameState.makeAMove(
            move: Move(
                playerId: inGameState.currentAuthUser.uid,
                type: 'remove',
                remove: value));
      } else if (choseATokenToMove()) {
        inGameState.tokenToMove = value;
        setState();
      } else if (choseACaseToGo()) {
        inGameState.makeAMove(
            move: Move(
                playerId: inGameState.currentAuthUser.uid,
                type: 'move',
                from: inGameState.tokenToMove!,
                to: value));
        inGameState.tokenToMove = null;
      }
    }

    if (game == null) return SizedBox.shrink();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            //
            isEmtpy()
                ? SizedBox.shrink()
                : Skin(isCurrentPlayer: isCurrentPlayerToken()),
            BreathAnimation(
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: highlightToken()
                            ? Colors.amber
                            : Colors.transparent,
                        width: 3)),
              ),
            ),
            //
          ],
        ),
      ),
    );
  }
}
