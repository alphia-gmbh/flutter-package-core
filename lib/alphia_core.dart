// Copyright 2024 Alphia GmbH
library;

export 'crossplatform_io.dart' if (dart.library.js_interop) 'crossplatform_web.dart' show CorePlatform;
export 'l10n/app_localizations.dart' show CoreAppLocalizations;
export 'page_webview.dart' show WebViewPage, coreOpenUrl;
export 'service_auth.dart' show CoreCredProvider, CoreCredProviderExtension, coreAuthenticateUser, coreDeleteUser, coreSignInUser, coreSignOutUser;
export 'service_extensions.dart';
export 'service_functions.dart';
export 'service_theme.dart' show CoreTheme;
export 'service_widgets.dart';
