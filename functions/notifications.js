const firebase = require("./firebase");

/**
 * Automates notification process by checking database and
 * generating an FCM using stored token and specified payload.
 *
 * @param {Object} snapshot User object snapshot
 */
async function handleSnapshot(snapshot) {
  const uuid = snapshot.key; // "UUID"
  const token = snapshot.child("fcm/token").val();

  // YYYY-MM-DD (ISO Format)
  // EST Time in America is UTC Tomorrow
  const today = new Date();
  const yesterday = new Date(today);
  yesterday.setDate(yesterday.getDate() - 1);
  const date = yesterday.toISOString().slice(0, 10);

  const dateExists = snapshot.child("data/" + date).exists();

  const payload = {
    notification: {
      title: "How was your day?",
      body: "Remember to check in today and " +
    "fill out your daily questions!",
      badge: "1",
    },
  };

  if (!dateExists &&
token != "" && token != null) {
    await firebase.messaging().sendToDevice(token, payload);
    console.log("Notification Sent for User: " +
    uuid);
  } else {
    console.log("Notification NOT Sent for User: " +
  uuid);
  }
}

const notifications = async (request, response) => {
  const snapshots = await firebase.database().ref("root/users").once("value");
  const dataSnapArr = [];
  snapshots.forEach(function(childSnapshot) {
    const stuff = childSnapshot;
    stuff.key = childSnapshot.key;
    dataSnapArr.push(stuff);
  });

  await Promise.all(dataSnapArr.map(handleSnapshot));
  response.status(200).send("Notification Function Invoked: YES (200)");
};

module.exports = notifications;

/**
 * OLD NOTIFICATION FUNCTION (INEFFICIENT/MISSING PROMISES FOREACH)
 * Automates notification process by checking database and
 * generating an FCM using stored token and specified payload.
 *
 * @param {Object} request Express Request Object
 * @param {Object} response Express Request Object
 */
/*
const notifications = async (request, response) => {
  const query = firebase.database().ref("root/users").orderByKey();
  query.once("value")
      .then(function(snapshot) {
        snapshot.forEach(function(childSnapshot) {
          const uuid = childSnapshot.key; // "UUID"

          // Retrieve User Token
          firebase.database()
              .ref("root/users/" + uuid + "/fcm").once("value")
              .then(function(fcmSnapshot) {
                const token = fcmSnapshot.child("token").val();
                const notify = fcmSnapshot.child("notify").val();

                // YYYY-MM-DD (ISO Format)
                // EST Time in America is UTC Tomorrow
                const today = new Date();
                const yesterday = new Date(today);
                yesterday.setDate(yesterday.getDate() - 1);
                const date = yesterday.toISOString().slice(0, 10);

                const db = firebase.database().ref("root/users/" +
                  uuid + "/data");
                db.once("value")
                    .then(function(dateSnapshot) {
                      const dateExists = dateSnapshot.child(date).exists();
                      const payload = {
                        notification: {
                          title: "How was your day?",
                          body: "Remember to check in today and " +
                            "fill out your daily questions!",
                        },
                        apns: {
                          payload: {
                            aps: {
                              sound: "default",
                              badge: 1,
                            },
                          },
                        },
                        token: token,
                      };

                      const customPayload = {
                        notification: {
                          title: "Happy July 4th!",
                          body: "Hope your day is good! " +
                            "Remember to check in today and " +
                            "fill out your daily questions!",
                        },
                        apns: {
                          payload: {
                            aps: {
                              sound: "default",
                              badge: 1,
                            },
                          },
                        },
                        token: token,
                      };

                      if (!dateExists &&
                        token != "" && token != null) {
                        firebase.messaging().send(payload)
                            .then((_response) => {
                              console.log(_response);
                              console.log("Notification Sent for User: " +
                                uuid);
                            })
                            .catch((error) => {
                              console.log("------SEND_TO_DEVICE ERROR------");
                              console.log("UUID: " + uuid);
                              console.log(error);
                              console.log("------SEND_TO_DEVICE ERROR------");
                            });
                      } else {
                        console.log("Notification NOT Sent for User: " +
                          uuid);
                      }
                    });
              });
        });
      });
  response.status(200).send("Notification Function Invoked: YES (200)");
};

module.exports = notifications;
*/
