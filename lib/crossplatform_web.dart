// Cross-platform implementation for _io (Android, iOS) and _web (Web)
// Copyright 2024 Alphia GmbH

class CorePlatform {
  static const isAndroid = false;
  static const isIOS = false;
  // static const isMobile = false; // isAndroid or isIOS
  static const isWeb = true;
  static const platform = 'web';
  static const systemLocale = 'web';
}

// Workaround until Firebase Crashlytics supports web version
final crossFirebaseCrashlyticsInstance = _FirebaseCrashlytics();
class _FirebaseCrashlytics { // Do nothing on web version
  Future<void> recordError(dynamic exception, StackTrace? stack, {dynamic reason, Iterable<Object> information = const [], bool? printDetails, bool fatal = false}) async {}
  Future<void> recordFlutterError(dynamic error) async {}
  Future<void> setCrashlyticsCollectionEnabled(bool enable) async {}
  Future<void> setCustomKey(String key, Object value) async {}
}
