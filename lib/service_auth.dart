// Copyright 2024 Alphia GmbH
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'crossplatform_io.dart' if (dart.library.js_interop) 'crossplatform_web.dart';
import 'service_functions.dart';
import 'service_widgets.dart';


enum CoreCredProvider {apple, google, microsoft, anonymous}
extension CoreCredProviderExtension on CoreCredProvider {
  String get nameCapitalized {
    return '${name[0].toUpperCase()}${name.substring(1)}';
  }
}

class CoreUserNotifier with ChangeNotifier {
  // Private properties
  User? _user;
  Map<String, dynamic>? _userDoc;

  // Getters and setters
  User? get user => _user;
  set user(User? user) {
    _user = user;
    notifyListeners();
  }
  Map<String, dynamic>? get userDoc => _userDoc;
  set userDoc(Map<String, dynamic>? userDoc) {
    _userDoc = userDoc;
    notifyListeners();
  }
  static String getDisplayName(User? currUser) {
    if (currUser?.isAnonymous ?? false) {
      return CoreInstance.text.guestUser;
    } else if (currUser?.displayName?.isNotEmpty ?? false) {
      return currUser!.displayName!.trim();
    } else if (currUser?.providerData.firstOrNull?.displayName?.isNotEmpty ?? false) {
      return currUser!.providerData.firstOrNull!.displayName!.trim();
    } else {
      return CoreInstance.text.incognitoUser;
    }
  }
  String get displayName => getDisplayName(_user);
  static String getEmail(User? currUser) {
    if (currUser?.email?.isNotEmpty ?? false) {
      return currUser!.email!.trim();
    } else if (currUser?.providerData.firstOrNull?.email?.isNotEmpty ?? false) {
      return currUser!.providerData.firstOrNull!.email!.trim();
    } else {
      return CoreInstance.text.noEmail;
    }
  }
  String get email => getEmail(_user);
  static CoreCredProvider getProviderId(User? currUser) {
    final providerId = currUser?.providerData.firstOrNull?.providerId;
    switch (providerId) {
      case 'apple.com': return CoreCredProvider.apple;
      case 'google.com': return CoreCredProvider.google;
      case 'microsoft.com': return CoreCredProvider.microsoft;
      default: return CoreCredProvider.anonymous;
    }
  }
  CoreCredProvider get providerId => getProviderId(_user);
  String get providerName {
    return '${providerId.name[0].toUpperCase()}${providerId.name.substring(1).split('.').first}';
  }
}

class _ShowSnackbar {
  static void appCheckBlocked() {coreShowSnackbar(content: CoreInstance.text.snackAppCheckBlocked(CorePlatform.platform), isError: true); return;}
  static void userMismatched(User? currUser) {coreShowSnackbar(content: '${CoreInstance.text.snackUserMismatched}\n${CoreUserNotifier.getDisplayName(currUser)}\n${CoreUserNotifier.getEmail(currUser)}', isError: true); return;}
  static void signInCanceled({required CoreCredProvider? credentialProvider, required bool reauthenticate}) {
    coreShowSnackbar(content: !reauthenticate
      ? CoreInstance.text.snackSignInCanceled('${credentialProvider?.name}')
      : CoreInstance.text.snackVerifyCanceled, isError: true);
    return;
  }
}

/// Sign in user with [credentialProvider] or handle signInWithRedirect redirect [credentialProvider==null]
Future<bool> coreSignInUser([CoreCredProvider? credentialProvider]) async {
  try {
    final UserCredential? userCredential;
    // Authenticate
    if (credentialProvider != null) { // Init sign-in
      userCredential = await coreAuthenticateUser(credentialProvider: credentialProvider);
      if (userCredential == null) return false;
    } else { // Handle signInWithRedirect redirect
      if (!CorePlatform.isWeb) return false; // getRedirectResult is only implemented for web
      userCredential = await FirebaseAuth.instance.getRedirectResult();
    }
    if (userCredential.user == null) return false; // If no redirect operation was called, returns a UserCredential with a null User.
    // Double check
    if (FirebaseAuth.instance.currentUser == null) return false;

    // Process
    String? snackbarContent;
    if (userCredential.additionalUserInfo?.isNewUser ?? false) {
      // With Apple provider store user name at first sign in, otherwise name is not stored permanently
      // if (CoreUserNotifier.getProviderId(userCredential.user) == CoreCredProvider.apple) {await FirebaseAuth.instance.currentUser?.updateDisplayName(CoreUserNotifier.getDisplayName(userCredential.user));}
      if (userCredential.user?.isAnonymous ?? false) {
        snackbarContent = CoreInstance.text.snackAccountCreatedGuest;
      } else {
        snackbarContent = '${CoreInstance.text.snackAccountCreatedNew} ${CoreUserNotifier.getDisplayName(userCredential.user)}';
      }
    } else {
      snackbarContent = '${CoreInstance.text.snackWelcomeBack} ${CoreUserNotifier.getDisplayName(userCredential.user)}';
    }
    coreShowSnackbar(content: snackbarContent);
    return true;
  }

  catch (error, stackTrace) {
    CoreInstance.crashlytics.recordError(error, stackTrace, reason: 'errorCode pipe -- $credentialProvider');
    CoreShowSnackbar.genericError();
    return false;
  }
}

Future<bool> coreSignOutUser() async {
  try {
    // Sign out on device
    await FirebaseAuth.instance.signOut(); // Sign out does not require internet connection
    // Double check
    if (FirebaseAuth.instance.currentUser != null) throw StateError('errorCode bird');
    return true;
  }

  catch (error, stackTrace) {
    CoreInstance.crashlytics.recordError(error, stackTrace, reason: 'errorCode forum');
    if (FirebaseAuth.instance.currentUser == null) {
      return true;
    } else {
      CoreShowSnackbar.genericError();
      return false;
    }
  }
}

Future<bool> coreDeleteUser() async {
  try {
    // Double check
    if (FirebaseAuth.instance.currentUser == null) return true;
    // Reauthenticate
    final userCredential = await coreAuthenticateUser(reauthenticate: true);
    final currUser = userCredential?.user;
    if (currUser == null) return false;
    // Delete
    await currUser.delete();
    // Double check
    if (FirebaseAuth.instance.currentUser != null) throw StateError('errorCode tomato');
    return true;
  }

  on FirebaseAuthException catch (error, stackTrace) {
    switch (error.code) {
      case 'network-request-failed': {
        await CoreShowDialog.offline();
        return false;
      }
      default: {
        CoreInstance.crashlytics.recordError(error, stackTrace, reason: 'errorCode coast');
        CoreShowSnackbar.genericError();
        return false;
      }
    }
  }

  catch (error, stackTrace) {
    CoreInstance.crashlytics.recordError(error, stackTrace, reason: 'errorCode envelope');
    CoreShowSnackbar.genericError();
    return false;
  }
}

Future<UserCredential?> coreAuthenticateUser({CoreCredProvider? credentialProvider, bool reauthenticate = false}) async {
  final currUser = FirebaseAuth.instance.currentUser;
  // Authenticate
  try {
    // Double check arguments are in valid combination
    if (((credentialProvider != null) && reauthenticate) || ((credentialProvider == null) && (!reauthenticate || (reauthenticate && (currUser == null))))) {
      throw StateError('errorCode board -- ${credentialProvider?.name} -- $reauthenticate -- ${currUser == null}');
    }
    // Get credentialProvider, if null due to reauthentication
    credentialProvider = credentialProvider ?? CoreUserNotifier.getProviderId(currUser);

    // Split authentication flow by provider
    UserCredential? userCredential;
    /// Apple
    if (credentialProvider == CoreCredProvider.apple) {
      final appleProvider = AppleAuthProvider()..addScope('name')..addScope('email');
      if (!reauthenticate) { // sign-in
        if (!CorePlatform.isWeb) { // Android, iOS
          userCredential = await FirebaseAuth.instance.signInWithProvider(appleProvider);
        } else { // Web
          await FirebaseAuth.instance.signInWithRedirect(appleProvider);
          return null;
        }
      } else { // reauthenticate
        if (!CorePlatform.isWeb) { // Android, iOS
          userCredential = await currUser!.reauthenticateWithProvider(appleProvider);
        } else { // Web
          userCredential = await currUser!.reauthenticateWithPopup(appleProvider);
        }
        // Invalidate the tokens and associated user authorizations for someone when they are no longer associated with your app. https://developer.apple.com/documentation/accountorganizationaldatasharing/revoke-tokens
        await FirebaseFunctions.instanceFor(region: 'europe-west1').httpsCallable('authenticateApple', options: HttpsCallableOptions(limitedUseAppCheckToken: true))
          .call({'code': userCredential.additionalUserInfo?.authorizationCode, 'token': userCredential.credential?.accessToken});
      }
    /// Google
    } else if (credentialProvider == CoreCredProvider.google) {
      if (!CorePlatform.isWeb) { // Android, iOS
        final googleSignIn = GoogleSignIn.instance;
        await googleSignIn.initialize();
        final List<String> scopes = ['https://www.googleapis.com/auth/userinfo.profile', 'https://www.googleapis.com/auth/userinfo.email'];
        GoogleSignInAccount? googleSignInAccount;
        try {
          googleSignInAccount = !reauthenticate ? await googleSignIn.authenticate(scopeHint: scopes) : await googleSignIn.attemptLightweightAuthentication();
          if (googleSignInAccount == null) throw 'googleSignInAccount == null';
        } on GoogleSignInException catch (_) { // signInCanceled: iOS: Google // signInCanceled: Android: Google
          _ShowSnackbar.signInCanceled(credentialProvider: credentialProvider, reauthenticate: reauthenticate); if (kDebugMode) debugPrintStack(label: '\nError "GoogleSignIn()" gracefully handled by:', maxFrames: 2);
          return null;
        }
        final googleSignInAuthorization = await googleSignInAccount.authorizationClient.authorizationForScopes(scopes);
        final authCredential = GoogleAuthProvider.credential(accessToken: googleSignInAuthorization!.accessToken, idToken: googleSignInAccount.authentication.idToken);
        userCredential = !reauthenticate ? await FirebaseAuth.instance.signInWithCredential(authCredential) : await currUser!.reauthenticateWithCredential(authCredential);
      } else { // Web
        final googleProvider = GoogleAuthProvider()..addScope('profile')..addScope('email');
        if (!reauthenticate) { // sign-in
          if (!kDebugMode) {
            await FirebaseAuth.instance.signInWithRedirect(googleProvider);
            return null;
          } else { // Debug mode
            userCredential = await FirebaseAuth.instance.signInWithPopup(googleProvider);
          }
        } else { // reauthenticate
          userCredential = await currUser!.reauthenticateWithPopup(googleProvider);
        }
      }
    /// Microsoft
    } else if (credentialProvider == CoreCredProvider.microsoft) {
      final microsoftProvider = MicrosoftAuthProvider(); // ..addScope('User.ReadBasic.All'); // ..addScope('user.read')..addScope('email');
      if (!reauthenticate) { // sign-in
        if (!CorePlatform.isWeb) { // Android, iOS
          userCredential = await FirebaseAuth.instance.signInWithProvider(microsoftProvider);
        } else { // Web
          await FirebaseAuth.instance.signInWithRedirect(microsoftProvider);
          return null;
        }
      } else { // reauthenticate
        if (!CorePlatform.isWeb) { // Android, iOS
          userCredential = await currUser!.reauthenticateWithProvider(microsoftProvider);
        } else { // Web
          userCredential = await currUser!.reauthenticateWithPopup(microsoftProvider);
        }
      }
    /// Anonymous
    } else if (credentialProvider == CoreCredProvider.anonymous) {
      if (!CorePlatform.isWeb) { // Android, iOS
        userCredential = await FirebaseAuth.instance.signInAnonymously(); // If there is already an anonymous user signed in, that user will be returned instead.
      }
      else { // Web
        throw StateError('errorCode hydrant -- $reauthenticate -- ${currUser == null}');
      }
    } else {
      // 'No valid authentication provider found'
      throw StateError('errorCode saddle'); // Custom exception // The operation was not allowed by the current state of the object
    }

    // Double check
    if (FirebaseAuth.instance.currentUser == null) {
      throw StateError('errorCode celery -- ${!reauthenticate ? 'sign-in': 'verify'}');
    }
    // Return
    return userCredential;
  }

  on FirebaseAuthException catch (error, stackTrace) {
    switch (error.code) {
      case "popup-blocked": {
        coreShowSnackbar(content: CoreInstance.text.snackPopupBlocked, isError: true);
        return null;
      }
      case "web-context-already-presented": {
        coreShowSnackbar(content: CoreInstance.text.snackWebContext, isError: true);
        return null;
      }
      case "canceled": // signInCanceled: iOS: Apple
      case "web-context-canceled": // signInCanceled: Android: Apple
      case "popup-closed-by-user": { // signInCanceled: Web: Apple, Google
        _ShowSnackbar.signInCanceled(credentialProvider: credentialProvider, reauthenticate: reauthenticate); if (kDebugMode) {debugPrintStack(label: '\nError "${error.code}" gracefully handled by:', maxFrames: 2);}
        return null;
      }
      case "user-mismatch": { // Case reauthenticating with different account // Works for Google and Apple
        _ShowSnackbar.userMismatched(currUser);
        return null;
      }
      case "internal-error": // appCheckBlocked: iOS: Apple, Google, Guest // offline: Web: Apple, Google
      case "web-internal-error": { // appCheckBlocked: Android: Apple
        if (CorePlatform.isWeb) {
          await CoreShowDialog.offline(); if (kDebugMode) {debugPrintStack(label: '\nError "${error.code}" gracefully handled by:', maxFrames: 2);}
        }
        else {
          _ShowSnackbar.appCheckBlocked(); if (kDebugMode) {debugPrintStack(label: '\nError "${error.code}" gracefully handled by:', maxFrames: 2);}
        }
        return null;
      }
      case "unknown": {
        if (CorePlatform.isAndroid && (credentialProvider == CoreCredProvider.apple)) { // offline: Android: Apple
          await CoreShowDialog.offline(); if (kDebugMode) {debugPrintStack(label: '\nError "${error.code}" gracefully handled by:', maxFrames: 2);}
        }
        else { // appCheckBlocked: Android: Google, Guest // appCheckBlocked: Web: Apple, Google
          _ShowSnackbar.appCheckBlocked(); if (kDebugMode) {debugPrintStack(label: '\nError "${error.code}" gracefully handled by:', maxFrames: 2);}
        }
        return null;
      }
      case "network-request-failed": {
        if (CorePlatform.isWeb) { // appCheckBlocked: Web redirect: Apple
          _ShowSnackbar.appCheckBlocked(); if (kDebugMode) {debugPrintStack(label: '\nError "${error.code}" gracefully handled by:', maxFrames: 2);}
        } else { // offline: iOS: Guest // offline: Android: Guest
          await CoreShowDialog.offline(); if (kDebugMode) {debugPrintStack(label: '\nError "${error.code}" gracefully handled by:', maxFrames: 2);}
        }
        return null;
      }
      default: {
        CoreInstance.crashlytics.recordError(error, stackTrace, reason: 'errorCode blanket -- ${currUser == null} -- ${credentialProvider?.name}');
        CoreShowSnackbar.genericError(); if (kDebugMode) {debugPrintStack(label: '\nError gracefully handled by:', maxFrames: 2);}
        return null;
      }
    }
  }

  on PlatformException catch (error, stackTrace) {
    switch (error.code) {
      case "network_error": { // offline: iOS: Google // offline: Android: Google // offline: Web: Google
        await CoreShowDialog.offline();  if (kDebugMode) {debugPrintStack(label: '\nError "${error.code}" gracefully handled by:', maxFrames: 2);}
        return null;
      }
      case "status": { // googleSignIn.disconnect() error
        CoreShowSnackbar.genericError();  if (kDebugMode) {debugPrintStack(label: '\nError "${error.code}" gracefully handled by:', maxFrames: 2);}
        return null;
      }
      default: {
        CoreInstance.crashlytics.recordError(error, stackTrace, reason: 'errorCode lava -- errorCode ${error.code} -- ${currUser == null} -- ${credentialProvider?.name}');
        CoreShowSnackbar.genericError(); if (kDebugMode) {debugPrintStack(label: '\nError gracefully handled by:', maxFrames: 2);}
        return null;
      }
    }
  }

  catch (error, stackTrace) {
    CoreInstance.crashlytics.recordError(error, stackTrace, reason: 'errorCode space -- ${currUser == null} -- ${credentialProvider?.name}');
    CoreShowSnackbar.genericError(); if (kDebugMode) {debugPrintStack(label: '\nError gracefully handled by:', maxFrames: 2);}
    return null;
  }
}
