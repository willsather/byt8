const firebase = require("./firebase");

/**
 * Iterates over realtime database and checks
 * how many users exist and how many store data.
 *
 * @param {Object} request Express Request Object
 * @param {Object} response Express Request Object
 */
const users = async (request, response) => {
  const query = firebase.database().ref("root/users").orderByKey();
  let activeUsers = 0;
  let users = 0;
  query.once("value")
      .then(function(snapshot) {
        snapshot.forEach(function(childSnapshot) {
          // const uuid = childSnapshot.key;
          users++;
          if (childSnapshot.child("data").exists()) {
            activeUsers++;
          }
        });
        console.log("Total Users: " + users);
        console.log("Active Users: " + activeUsers);
      });
  response.status(200).send("User Counting Invoked: YES (200)");
};

module.exports = users;
