const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.onNewUserInWaitingRoom = functions.firestore
    .document('WaitingRoom/{uid}')
    .onCreate((event) => {
        let uid = event.ref.id;
        return admin.firestore().collection('WaitingRoom').get().then(
            async (snap) => {
                if(snap.docs.length >= 2) {
                    let player_1_uid = snap.docs[0].id
                    let player_2_uid = snap.docs[1].id

                    await admin.firestore().collection('WaitingRoom').doc(player_1_uid).delete();
                    await admin.firestore().collection('WaitingRoom').doc(player_2_uid).delete();
                    await admin.firestore().collection('Games').add({
                        playersUids: [player_1_uid, player_2_uid],
                        state:'do_nothing', 
                        board: {'000':0,'001':0,'002':0,'003':0,'010':0,'011':0,'012':0,'020':0,'021':0,'022':0,'100':0,'101':0,'102':0,'103':0,'110':0,'111':0,'112':0,'120':0,'121':0,'122':0,'200':0,'201':0,'202':0,'203':0,'210':0,'211':0,'212':0,'220':0,'221':0,'222':0},
                        player1RemainingTokens: 9,
                        player2RemainingTokens: 9
                    });
                    
                    functions.logger.log('New created');
                    return null;
                }
                else{
                    functions.logger.log('Not enough players yet');
                    return null;
                }
            }
        )
    });

