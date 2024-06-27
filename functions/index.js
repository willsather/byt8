const functions = require("firebase-functions");

const notifications = require("./notifications");
const users = require("./users");

module.exports = {
  "notifications": functions.https.onRequest(notifications),
  "users": functions.https.onRequest(users),
};
