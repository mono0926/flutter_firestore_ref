import * as functions from 'firebase-functions'

export const now = functions.https.onCall((data, context) => {
  return { time: new Date().toISOString() }
})

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });
