// Copyright 2024 Alphia GmbH
const functions = require("firebase-functions/v1"); // Gen1
const {logger, setGlobalOptions} = require("firebase-functions");
const {onNewFatalIssuePublished, onNewNonfatalIssuePublished} = require("firebase-functions/alerts/crashlytics");
const {onCall} = require("firebase-functions/https");
const {onMessagePublished} = require("firebase-functions/pubsub");
const {initializeApp} = require("firebase-admin/app");
const {getFirestore, Timestamp} = require("firebase-admin/firestore");

initializeApp();
setGlobalOptions({region: "europe-west1", maxInstances: 10});


exports.deleteUserDocs = functions.region("europe-west1").runWith({secrets: ["APPLE_PRIVATE_KEY"]}).auth.user().onDelete(async (user) => {
  try {
    const userDocRef = getFirestore().collection("users").doc(user.uid);
    // Apple revoke token
    if (user.providerData[0]?.providerId === "apple.com") {
      const jsonwebtoken = require("jsonwebtoken");
      const axios = require("axios");
      try {
        const tokenDoc = await userDocRef.collection("token").doc("accessToken").get();
        const accessToken = tokenDoc.data()?.accessToken;
        const clientId = tokenDoc.data()?.clientId;
        // Validate accessToken
        if (typeof accessToken !== "string") {
          throw Error("accessToken invalid");
        }
        // Validate clientId
        if (typeof clientId !== "string") {
          throw Error("clientId invalid");
        }
        // Create JWT
        const clientSecret = jsonwebtoken.sign({
          iss: "10-character TEAM ID associated with your Apple developer account",
          iat: Timestamp.now().seconds - 300, // 5min 5*60sec
          exp: Timestamp.now().seconds + 300,
          aud: "https://appleid.apple.com",
          sub: clientId,
        }, process.env.APPLE_PRIVATE_KEY, { // .p8
          algorithm: "ES256",
          header: {
            alg: "ES256",
            kid: "10-character KEY IDENTIFIER generated for the private key associated with your Apple developer account",
          },
        });
        // Revoke accessToken
        await axios.post("https://appleid.apple.com/auth/revoke", {
          client_id: clientId,
          client_secret: clientSecret,
          token: accessToken,
          token_type_hint: "access_token",
        }, {
          headers: {"Content-Type": "application/x-www-form-urlencoded"},
        });
      } catch (error) {
        logger.error(`Revoking Apple accessToken for uid ${user.uid}: ${error}.`);
      }
    }
    // Delete user document including subcollections
    await getFirestore().recursiveDelete(userDocRef);
    return true;
  } catch (error) {
    logger.error(`Deleting user documents for uid ${user.uid}: ${error}.`);
    return false;
  }
});


exports.authenticateApple = onCall({enforceAppCheck: true, consumeAppCheckToken: true, secrets: ["APPLE_PRIVATE_KEY"]}, async (request) => {
  const uid = request.auth.uid;
  try {
    const signInProvider = request.auth?.token?.firebase?.sign_in_provider;
    if (signInProvider !== "apple.com") {
      throw Error(`signInProvider [${signInProvider}] invalid`);
    }
    const jsonwebtoken = require("jsonwebtoken");
    const axios = require("axios");
    const authorizationCode = request.data.code;
    let accessToken = request.data.token;
    let clientId = "APPLE_SERVICE_ID"; // Apple Service ID on non-iOS platforms and Apple App ID on iOS platform
    if (typeof authorizationCode !== "string") { // Non-iOS platform
      if (typeof accessToken !== "string") {
        throw Error("accessToken invalid");
      }
    } else { // iOS platform
      clientId = "APPLE_APP_ID";
      // Create JWT
      const clientSecret = jsonwebtoken.sign({
        iss: "10-character TEAM ID associated with your Apple developer account",
        iat: Timestamp.now().seconds - 300, // 5min 5*60sec
        exp: Timestamp.now().seconds + 300,
        aud: "https://appleid.apple.com",
        sub: clientId,
      }, process.env.APPLE_PRIVATE_KEY, { // .p8
        algorithm: "ES256",
        header: {
          alg: "ES256",
          kid: "10-character KEY IDENTIFIER generated for the private key associated with your Apple developer account",
        },
      });
      // Get accessToken from authorizationCode
      const response = await axios.post("https://appleid.apple.com/auth/token", {
        client_id: clientId,
        client_secret: clientSecret,
        code: authorizationCode,
        grant_type: "authorization_code",
      }, {
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
      });
      accessToken = response.data.access_token;
    }
    // Write accessToken and clientId to Firestore
    await getFirestore().collection("users").doc(uid).collection("token").doc("accessToken").set({accessToken: accessToken, clientId: clientId});
    return true;
  } catch (error) {
    logger.error(`Getting Apple accessToken for uid ${uid}: ${error}.`);
    return false;
  }
});


exports.manageBilling = onMessagePublished({topic: "billing"}, async (event) => {
  try {
    const projectName = "projects/PROJECT-firebase";
    const costAmount = event.data.message.json.costAmount;
    const budgetAmount = event.data.message.json.budgetAmount;
    // Validate costAmount
    if (typeof costAmount !== "number") {
      throw Error("costAmount invalid");
    }
    // Validate budgetAmount
    if (typeof budgetAmount !== "number") {
      throw Error("budgetAmount invalid");
    }
    logger.info(`Billing: Current cost ${costAmount.toLocaleString("en-US", {style: "currency", currency: event.data.message.json.currencyCode})} with ${(costAmount/budgetAmount).toLocaleString("en-US", {style: "percent"})} of ${budgetAmount.toLocaleString("en-US", {style: "currency", currency: event.data.message.json.currencyCode})} budget spent.`);
    // Disable billing
    if (costAmount > budgetAmount) {
      const {CloudBillingClient} = require("@google-cloud/billing");
      const billingClient = new CloudBillingClient();
      // Get billing info
      const [projectBillingInfo] = await billingClient.getProjectBillingInfo({name: projectName});
      // Validate billingEnabled
      if (typeof projectBillingInfo.billingEnabled !== "boolean") {
        throw Error("billingEnabled invalid");
      }
      // Disable billing
      if (projectBillingInfo.billingEnabled) {
        const [updatedProjectBillingInfo] = await billingClient.updateProjectBillingInfo({
          name: projectName,
          projectBillingInfo: {billingAccountName: ""}, // Disable billing
        });
        logger.warn(`Exceeding budget: Billing disabled with ${(costAmount/budgetAmount).toLocaleString("en-US", {style: "percent"})} of budget spent: ${JSON.stringify(updatedProjectBillingInfo)}.`);
      } else {
        logger.warn(`Exceeding budget: Billing is already disabled with ${(costAmount/budgetAmount).toLocaleString("en-US", {style: "percent"})} of budget spent: ${JSON.stringify(projectBillingInfo)}.`);
      }
    }
    return true;
  } catch (error) {
    logger.error(`Managing Billing: ${error}.`);
    return false;
  }
});


exports.logFatalCrashlytics = onNewFatalIssuePublished(async (event) => {
  const {appVersion, title, subtitle, id} = event.data.payload.issue;
  logger.warn(`Crashlytics: New fatal issue for ${event.appId} in version ${appVersion}: ${title}: ${subtitle}: ID ${id}.`);
  return true;
});


exports.logNonfatalCrashlytics = onNewNonfatalIssuePublished(async (event) => {
  const {appVersion, title, subtitle, id} = event.data.payload.issue;
  logger.warn(`Crashlytics: New non-fatal issue for ${event.appId} in version ${appVersion}: ${title}: ${subtitle}: ID ${id}.`);
  return true;
});
