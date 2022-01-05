const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();





exports.onNewUserInWaitingRoom = functions.firestore
    .document('WaitingRoom/{uid}')
    .onCreate((event) => {
        let uid = event.ref.id;
        return admin.firestore().collection('WaitingRoom').get().then(
            async (snap) => {
                if (snap.docs.length >= 2) {
                    let player_1_uid = snap.docs[0].id
                    let player_2_uid = snap.docs[1].id

                    await admin.firestore().collection('WaitingRoom').doc(player_1_uid).delete();
                    await admin.firestore().collection('WaitingRoom').doc(player_2_uid).delete();
                    await admin.firestore().collection('Games').add({
                        playersUids: [player_1_uid, player_2_uid],
                        state: 'do_nothing',
                        board: { '000': 0, '001': 0, '002': 0, '003': 0, '010': 0, '011': 0, '012': 0, '020': 0, '021': 0, '022': 0, '100': 0, '101': 0, '102': 0, '103': 0, '110': 0, '111': 0, '112': 0, '120': 0, '121': 0, '122': 0, '200': 0, '201': 0, '202': 0, '203': 0, '210': 0, '211': 0, '212': 0, '220': 0, '221': 0, '222': 0 },
                        player1RemainingTokens: 9,
                        player2RemainingTokens: 9
                    });

                    functions.logger.log('New created');
                    return null;
                }
                else {
                    functions.logger.log('Not enough players yet');
                    return null;
                }
            }
        )
    });
exports.onNewUserInWaitingRoom = functions.firestore
    .document('WaitingRoom/{uid}')
    .onCreate((event) => {
        let uid = event.ref.id;
        return admin.firestore().collection('WaitingRoom').get().then(
            async (snap) => {
                if (snap.docs.length >= 2) {
                    let player_1_uid = snap.docs[0].id
                    let player_2_uid = snap.docs[1].id
                    const state = (Date.now() % 2) == 1 ? 'player_1_has_to_play' : 'player_2_has_to_play';

                    await admin.firestore().collection('WaitingRoom').doc(player_1_uid).delete();
                    await admin.firestore().collection('WaitingRoom').doc(player_2_uid).delete();
                    await admin.firestore().collection('Games').add({
                        playersUids: [player_1_uid, player_2_uid],
                        state: state,
                        move: 'add_token',
                        board: { '000': 0, '001': 0, '002': 0, '003': 0, '010': 0, '011': 0, '012': 0, '020': 0, '021': 0, '022': 0, '100': 0, '101': 0, '102': 0, '103': 0, '110': 0, '111': 0, '112': 0, '120': 0, '121': 0, '122': 0, '200': 0, '201': 0, '202': 0, '203': 0, '210': 0, '211': 0, '212': 0, '220': 0, '221': 0, '222': 0 },
                        player1RemainingTokens: 9,
                        player2RemainingTokens: 9
                    });

                    functions.logger.log('New created');
                    return null;
                }
                else {
                    functions.logger.log('Not enough players yet');
                    return null;
                }
            }
        )
    });




exports.onMoveCreated = functions.firestore
    .document('Games/{gameId}/Moves/{moveId}')
    .onCreate((move) => {

        const player = move.data().playerId;
        const type = move.data().type;
        const add = move.data().add;
        const remove = move.data().remove;
        const from = move.data().from;
        const to = move.data().to;

        const movedToken = to + add;

        const gameDocId = move.ref.parent.parent.id;

        return admin.firestore().collection('Games').doc(gameDocId).get().then(
            async (game) => {


               


                const state = game.data().state;
                const playerNumber = game.data().playersUids[0] == player ? 1 : 2;
                const otherPlayerNumber = playerNumber == 1 ? 2 : 1;

                // if it's not the player's turn
                if ((state == 'player_1_has_to_play' && playerNumber == 2) || (state == 'player_2_has_to_play' && playerNumber == 1)) {
                    console.log("It's not the player's turn");
                    return;
                }

                let board = game.data().board;
                let gameMove = game.data().move;
                let player1RemainingTokens = game.data().player1RemainingTokens;
                let player2RemainingTokens = game.data().player2RemainingTokens;
                let nextMove = gameMove;
                let nextState = state;

                function combo(token1, token2, token3) {
                    if (movedToken == token1 || movedToken == token2 || movedToken == token3) {
                        if (board[token1] == playerNumber && board[token2] == playerNumber && board[token3] == playerNumber) {
                            return true;
                        }
                        else return false;
                    }
                    else return false;

                }

                function shouldRemoveToken() {
                    return combo('000', '001', '002') || combo('100', '101', '102') || combo('200', '201', '202') || combo('010', '110', '210') || combo('212', '112', '012') || combo('120', '121', '122') || combo('020', '012', '022') || combo('000', '010', '020') || combo('100', '110', '120') || combo('200', '210', '220') || combo('001', '101', '201') || combo('221', '121', '021') || combo('202', '212', '222') || combo('102', '112', '122') || combo('002', '012', '022');

                }


                // ADD
                if (gameMove == 'add_token') {

                    // check if the move can be donne
                    if (board[add] != 0) return;

                    // do the move
                    board[add] = playerNumber;

                    // decrease token
                    if (state == 'player_1_has_to_play') {
                        player1RemainingTokens = player1RemainingTokens - 1;

                        // next move
                        if (shouldRemoveToken()) {
                            nextMove = 'remove_token';
                        }
                        else if (player2RemainingTokens == 0) {
                            nextMove = 'move_token';
                            nextState = 'player_2_has_to_play';
                        }
                        else {
                            nextState = 'player_2_has_to_play';
                        }


                    }
                    else {
                        player2RemainingTokens = player2RemainingTokens - 1;
                        // next move

                        if (shouldRemoveToken()) {
                            nextMove = 'remove_token';
                        }
                        else if (player2RemainingTokens == 0) {
                            nextMove = 'move_token';
                            nextState = 'player_1_has_to_play';
                        }
                        else {
                            nextState = 'player_1_has_to_play';
                        }
                    }

                }

                // Remove
                else if (gameMove == 'remove_token') {

                    // check if it can remove this token
                    if (board[remove] != otherPlayerNumber) return;

                    // do the move
                    board[remove] = 0;


                    if (state == 'player_1_has_to_play') {

                        // next move
                        if (player2RemainingTokens == 0) {
                            nextMove = 'move_token';
                            nextState = 'player_2_has_to_play';
                        }
                        else {
                            nextMove = 'add_token';
                            nextState = 'player_2_has_to_play';
                        }


                    }
                    else {
                        // next move
                        if (player1RemainingTokens == 0) {
                            nextMove = 'move_token';
                            nextState = 'player_1_has_to_play';
                        }
                        else {
                            nextMove = 'add_token';
                            nextState = 'player_1_has_to_play';
                        }
                    }

                }

                // Move
                if (gameMove == 'move_token') {

                    // check if from is players token
                    if(board[from] != playerNumber) return;
                    // check if to is empty
                    if(board[to] != 0) return;


                    // remove from token
                    board[from] = 0;
                    board[to] = playerNumber;

                    // next
                    if (state == 'player_1_has_to_play') { 

                        // next move
                        if (shouldRemoveToken()) {
                            nextMove = 'remove_token';
                        }
                        else {
                            nextState = 'player_2_has_to_play';
                        }


                    }
                    else {
                        // next move
                        if (shouldRemoveToken()) {
                            nextMove = 'remove_token';
                        }
                        else {
                            nextState = 'player_1_has_to_play';
                        }
                    }
                }


                // Check if player has won
                if(player1RemainingTokens == 0){
                    let numberOfTokenOnBoard  = 0;
                    Object.values(board).forEach((value) => {
                        // Prints "greeting Hello" followed by "name John"
                        
                        if( value == otherPlayerNumber){
                            numberOfTokenOnBoard += 1;
                        }
                      });
                    
                    if(numberOfTokenOnBoard<3){
                        nextState = `player_${playerNumber}_has_won`;
                    }
                }
                


                //////////////////////////////
                // Send new board
                return admin.firestore().collection('Games').doc(gameDocId).update({
                    board: board,
                    state: nextState,
                    player1RemainingTokens: player1RemainingTokens,
                    player2RemainingTokens: player2RemainingTokens,
                    move: nextMove,
                });

            })


    });