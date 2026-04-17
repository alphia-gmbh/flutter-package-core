// Cross-platform implementation for _io (Android, iOS) and _web (Web)
// Copyright 2024 Alphia GmbH

import 'dart:io' as io;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';


class CorePlatform {
  static final isAndroid = io.Platform.isAndroid;
  static final isIOS = io.Platform.isIOS;
  // static const isMobile = true; // isAndroid or isIOS
  static const isWeb = false;
  static final platform = io.Platform.operatingSystem;
  static final systemLocale = io.Platform.localeName;
}

// Workaround until Firebase Crashlytics supports web version
final crossFirebaseCrashlyticsInstance = FirebaseCrashlytics.instance;

Future<bool> hasInternetConnection() async {
  try {
    final result = await io.InternetAddress.lookup('firestore.googleapis.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } catch (_) {
    return false;
  }
}
