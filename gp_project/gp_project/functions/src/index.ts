import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
admin.initializeApp();

const db = admin.firestore();
const fcm = admin.messaging();


export const sendToDevice = functions.firestore
  .document('addDoctorRequest/{addDoctorRequestId}')
  .onCreate(async snapshot => {


    const addDoctorRequest = snapshot.data();


    const querySnapshot = await db
      .collection('users')
      .doc(addDoctorRequest!.doctorID)
      .collection('tokens')
      .get();

    const tokens = querySnapshot.docs.map(snap => snap.id);

    const payload: admin.messaging.MessagingPayload = {
      notification: {
        title: 'New Request!',
        body: `you have a request from patient ID: ${addDoctorRequest!.patientID}`,
        icon: 'your-icon-url',
        click_action: 'FLUTTER_NOTIFICATION_CLICK'
      }
    };

    return fcm.sendToDevice(tokens, payload);
  });
// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });
