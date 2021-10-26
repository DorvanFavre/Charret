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
                    await admin.firestore().collection('Games').add({players_uids: [player_1_uid, player_2_uid]})
                    
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

