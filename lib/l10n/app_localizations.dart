import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of CoreAppLocalizations
/// returned by `CoreAppLocalizations.of(context)`.
///
/// Applications need to include `CoreAppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: CoreAppLocalizations.localizationsDelegates,
///   supportedLocales: CoreAppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the CoreAppLocalizations.supportedLocales
/// property.
abstract class CoreAppLocalizations {
  CoreAppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static CoreAppLocalizations of(BuildContext context) {
    return Localizations.of<CoreAppLocalizations>(
      context,
      CoreAppLocalizations,
    )!;
  }

  static const LocalizationsDelegate<CoreAppLocalizations> delegate =
      _CoreAppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('en', 'US'),
    Locale('en', 'UK'),
    Locale('de'),
  ];

  /// No description provided for @buttonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get buttonCancel;

  /// No description provided for @buttonClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get buttonClose;

  /// No description provided for @buttonContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get buttonContinue;

  /// No description provided for @buttonCopy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get buttonCopy;

  /// No description provided for @buttonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get buttonDelete;

  /// No description provided for @buttonDiscard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get buttonDiscard;

  /// No description provided for @buttonDownload.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get buttonDownload;

  /// No description provided for @buttonDuplicate.
  ///
  /// In en, this message translates to:
  /// **'Duplicate'**
  String get buttonDuplicate;

  /// No description provided for @buttonEditDate.
  ///
  /// In en, this message translates to:
  /// **'Edit date'**
  String get buttonEditDate;

  /// No description provided for @buttonEditText.
  ///
  /// In en, this message translates to:
  /// **'Edit text'**
  String get buttonEditText;

  /// No description provided for @buttonExport.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get buttonExport;

  /// No description provided for @buttonOk.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get buttonOk;

  /// No description provided for @buttonRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get buttonRemove;

  /// No description provided for @buttonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get buttonSave;

  /// No description provided for @buttonShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get buttonShare;

  /// No description provided for @buttonTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get buttonTryAgain;

  /// No description provided for @buttonUndo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get buttonUndo;

  /// No description provided for @dialogTitleContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue?'**
  String get dialogTitleContinue;

  /// No description provided for @dialogTitleDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete?'**
  String get dialogTitleDelete;

  /// No description provided for @dialogTitleDiscard.
  ///
  /// In en, this message translates to:
  /// **'Discard?'**
  String get dialogTitleDiscard;

  /// No description provided for @dialogTitleExport.
  ///
  /// In en, this message translates to:
  /// **'Export?'**
  String get dialogTitleExport;

  /// No description provided for @dialogTitleGenericError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get dialogTitleGenericError;

  /// No description provided for @dialogContentGenericError.
  ///
  /// In en, this message translates to:
  /// **'Something didn’t go as planned.'**
  String get dialogContentGenericError;

  /// No description provided for @dialogTitleOffline.
  ///
  /// In en, this message translates to:
  /// **'No internet'**
  String get dialogTitleOffline;

  /// No description provided for @dialogContentOffline.
  ///
  /// In en, this message translates to:
  /// **'Looks like you’re offline. Connect to the internet first and then try again please.'**
  String get dialogContentOffline;

  /// No description provided for @dialogTitleRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove?'**
  String get dialogTitleRemove;

  /// No description provided for @dialogTitleUploaded.
  ///
  /// In en, this message translates to:
  /// **'Uploaded'**
  String get dialogTitleUploaded;

  /// No description provided for @snackCopied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get snackCopied;

  /// No description provided for @snackDeleted.
  ///
  /// In en, this message translates to:
  /// **'Deleted'**
  String get snackDeleted;

  /// No description provided for @snackEditedDate.
  ///
  /// In en, this message translates to:
  /// **'Date edited'**
  String get snackEditedDate;

  /// No description provided for @snackEditedText.
  ///
  /// In en, this message translates to:
  /// **'Text edited'**
  String get snackEditedText;

  /// No description provided for @snackGenericError.
  ///
  /// In en, this message translates to:
  /// **'Something didn’t go as planned'**
  String get snackGenericError;

  /// No description provided for @snackOffline.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get snackOffline;

  /// No description provided for @snackSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get snackSaved;

  /// No description provided for @buttonMenu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get buttonMenu;

  /// No description provided for @appBarMenu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get appBarMenu;

  /// No description provided for @titleAccountAndSettings.
  ///
  /// In en, this message translates to:
  /// **'Account and settings'**
  String get titleAccountAndSettings;

  /// No description provided for @appBarAccountAndSettings.
  ///
  /// In en, this message translates to:
  /// **'Account and Settings'**
  String get appBarAccountAndSettings;

  /// No description provided for @titleFaq.
  ///
  /// In en, this message translates to:
  /// **'Frequently asked questions'**
  String get titleFaq;

  /// No description provided for @subtitleFaq.
  ///
  /// In en, this message translates to:
  /// **'Be curious'**
  String get subtitleFaq;

  /// No description provided for @titleContact.
  ///
  /// In en, this message translates to:
  /// **'Contact and feedback'**
  String get titleContact;

  /// No description provided for @subtitleContact.
  ///
  /// In en, this message translates to:
  /// **'Get in touch'**
  String get subtitleContact;

  /// No description provided for @dialogTitleContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get dialogTitleContact;

  /// No description provided for @dialogContentContact.
  ///
  /// In en, this message translates to:
  /// **'Drop a line via email and tell what’s on your mind:'**
  String get dialogContentContact;

  /// No description provided for @draftEmailSubject.
  ///
  /// In en, this message translates to:
  /// **'{appName} Feedback (contact ID: {contactId})'**
  String draftEmailSubject(String appName, String contactId);

  /// No description provided for @draftEmailBody.
  ///
  /// In en, this message translates to:
  /// **'Hi Team {appName},\n\n'**
  String draftEmailBody(String appName);

  /// No description provided for @titleSupportApp.
  ///
  /// In en, this message translates to:
  /// **'Support the app'**
  String get titleSupportApp;

  /// No description provided for @subtitleSupportApp.
  ///
  /// In en, this message translates to:
  /// **'Feel free to contribute'**
  String get subtitleSupportApp;

  /// No description provided for @titlePrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get titlePrivacyPolicy;

  /// No description provided for @subtitlePrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Data protection information'**
  String get subtitlePrivacyPolicy;

  /// No description provided for @titleLegalNotice.
  ///
  /// In en, this message translates to:
  /// **'Legal notice'**
  String get titleLegalNotice;

  /// No description provided for @subtitleLegalNotice.
  ///
  /// In en, this message translates to:
  /// **'Provider information'**
  String get subtitleLegalNotice;

  /// No description provided for @titleLicenses.
  ///
  /// In en, this message translates to:
  /// **'Licenses'**
  String get titleLicenses;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'app version'**
  String get appVersion;

  /// No description provided for @subtitleAppVersion.
  ///
  /// In en, this message translates to:
  /// **'App version'**
  String get subtitleAppVersion;

  /// No description provided for @copyright2023.
  ///
  /// In en, this message translates to:
  /// **'Copyright 2023 Alphia GmbH'**
  String get copyright2023;

  /// No description provided for @copyright2024.
  ///
  /// In en, this message translates to:
  /// **'Copyright 2024 Alphia GmbH'**
  String get copyright2024;

  /// No description provided for @dialogTitleNoBrowser.
  ///
  /// In en, this message translates to:
  /// **'No browser'**
  String get dialogTitleNoBrowser;

  /// No description provided for @dialogContentNoBrowser.
  ///
  /// In en, this message translates to:
  /// **'Your device has no web browser to open:'**
  String get dialogContentNoBrowser;

  /// No description provided for @titleSignUpWith.
  ///
  /// In en, this message translates to:
  /// **'Sign up with'**
  String get titleSignUpWith;

  /// No description provided for @subtitleSignUpWith.
  ///
  /// In en, this message translates to:
  /// **'Backup and sync your app data'**
  String get subtitleSignUpWith;

  /// No description provided for @buttonSignInWith.
  ///
  /// In en, this message translates to:
  /// **'Sign in with'**
  String get buttonSignInWith;

  /// No description provided for @buttonSkipForNow.
  ///
  /// In en, this message translates to:
  /// **'Skip for now'**
  String get buttonSkipForNow;

  /// No description provided for @buttonContinueWith.
  ///
  /// In en, this message translates to:
  /// **'Continue with'**
  String get buttonContinueWith;

  /// No description provided for @buttonContinueAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as Guest'**
  String get buttonContinueAsGuest;

  /// No description provided for @guestUser.
  ///
  /// In en, this message translates to:
  /// **'Guest user'**
  String get guestUser;

  /// No description provided for @incognitoUser.
  ///
  /// In en, this message translates to:
  /// **'Incognito user'**
  String get incognitoUser;

  /// No description provided for @noEmail.
  ///
  /// In en, this message translates to:
  /// **'no email address'**
  String get noEmail;

  /// No description provided for @snackAccountCreatedNew.
  ///
  /// In en, this message translates to:
  /// **'New account created for you'**
  String get snackAccountCreatedNew;

  /// No description provided for @snackAccountCreatedGuest.
  ///
  /// In en, this message translates to:
  /// **'Guest account created for you'**
  String get snackAccountCreatedGuest;

  /// No description provided for @snackWelcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Hooray! Welcome back'**
  String get snackWelcomeBack;

  /// No description provided for @snackAppCheckBlocked.
  ///
  /// In en, this message translates to:
  /// **'{platform, select, ios{Security first! To maximize protection, reinstall exclusively from the Apple App Store} android{Security first! To maximize protection, reinstall exclusively from the Google Play Store} web{Your browser failed the security test or is offline. Installing from the Apple App Store or Google Play Store is the recommended alternative} other{Security first! To maximize protection, reinstall exclusively from the Apple App Store or Google Play Store}}'**
  String snackAppCheckBlocked(String platform);

  /// No description provided for @snackPopupBlocked.
  ///
  /// In en, this message translates to:
  /// **'Your browser blocks the sign-in pop-up. Allow the pop-up and then try again'**
  String get snackPopupBlocked;

  /// No description provided for @snackSignInCanceled.
  ///
  /// In en, this message translates to:
  /// **'Sign in {credentialProvider, select, apple{with Apple } google{with Google } microsoft{with Microsoft } anonymous{as Guest } other{}}didn’t go as planned'**
  String snackSignInCanceled(String credentialProvider);

  /// No description provided for @snackUserMismatched.
  ///
  /// In en, this message translates to:
  /// **'To verify it’s really you use the same account you have initially signed in with:'**
  String get snackUserMismatched;

  /// No description provided for @snackVerifyCanceled.
  ///
  /// In en, this message translates to:
  /// **'Sign in to verify didn’t go as planned'**
  String get snackVerifyCanceled;

  /// No description provided for @snackWebContext.
  ///
  /// In en, this message translates to:
  /// **'A browser tab seems already open for sign-in. Use the open tab or close it and try again'**
  String get snackWebContext;

  /// No description provided for @titleUpdatePersonal.
  ///
  /// In en, this message translates to:
  /// **'Update personal data'**
  String get titleUpdatePersonal;

  /// No description provided for @subtitleUpdatePersonal.
  ///
  /// In en, this message translates to:
  /// **'Change your sign-in method'**
  String get subtitleUpdatePersonal;

  /// No description provided for @appBarUpdatePersonal.
  ///
  /// In en, this message translates to:
  /// **'Update Personal Data'**
  String get appBarUpdatePersonal;

  /// No description provided for @titleUpdatePersonalFirstStep.
  ///
  /// In en, this message translates to:
  /// **'First Step'**
  String get titleUpdatePersonalFirstStep;

  /// No description provided for @contentUpdatePersonalFirstStep.
  ///
  /// In en, this message translates to:
  /// **'Please sign in again using your current {providerName} account to verify it’s really you ({email}).'**
  String contentUpdatePersonalFirstStep(String providerName, String email);

  /// No description provided for @buttonVerifyMe.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get buttonVerifyMe;

  /// No description provided for @titleUpdatePersonalFirstStepDone.
  ///
  /// In en, this message translates to:
  /// **'First Step Completed'**
  String get titleUpdatePersonalFirstStepDone;

  /// No description provided for @contentUpdatePersonalFirstStepDone.
  ///
  /// In en, this message translates to:
  /// **'Successfully verified'**
  String get contentUpdatePersonalFirstStepDone;

  /// No description provided for @titleUpdatePersonalSecondStep.
  ///
  /// In en, this message translates to:
  /// **'Second Step'**
  String get titleUpdatePersonalSecondStep;

  /// No description provided for @contentUpdatePersonalSecondStep.
  ///
  /// In en, this message translates to:
  /// **'Here’s where you get to choose how you want to sign in from now on along with providing your updated user name and email address:'**
  String get contentUpdatePersonalSecondStep;

  /// No description provided for @contentUpdatePersonalSecondStepUnlink.
  ///
  /// In en, this message translates to:
  /// **'Or you can unlink your account from \'\'Sign in with {providerName}\'\' and continue using the app as guest without an email address:'**
  String contentUpdatePersonalSecondStepUnlink(String providerName);

  /// No description provided for @titleExportPersonal.
  ///
  /// In en, this message translates to:
  /// **'Export personal data'**
  String get titleExportPersonal;

  /// No description provided for @subtitleExportPersonal.
  ///
  /// In en, this message translates to:
  /// **'Export your {isAnonymous, select, true{app data} other{user account data}}'**
  String subtitleExportPersonal(String isAnonymous);

  /// No description provided for @dialogContentExportPersonal.
  ///
  /// In en, this message translates to:
  /// **'A copy of your personal data will be exported as ZIP archive. Your archive contains an easy-to-read HTML file and a JSON file for import into other journaling apps.\n\nPlease ensure you keep your files safe and secure, especially when saving or sharing them.'**
  String get dialogContentExportPersonal;

  /// No description provided for @titleDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete personal data'**
  String get titleDeleteAccount;

  /// No description provided for @subtitleDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Permanently delete your {isAnonymous, select, true{app data} other{user account}}'**
  String subtitleDeleteAccount(String isAnonymous);

  /// No description provided for @dialogContentDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'{isAnonymous, select, true{All your personal data will be deleted permanently.} other{Your user account including all your personal data will be deleted permanently ({email}). Additionally, you will be signed out from all synced devices.\n\nYou may be asked to sign in again before the deletion to verify it’s really you.}}'**
  String dialogContentDeleteAccount(String isAnonymous, String email);

  /// No description provided for @snackDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'{isAnonymous, select, true{App data} other{User account}} deleted permanently'**
  String snackDeleteAccount(String isAnonymous);

  /// No description provided for @buttonSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get buttonSignOut;

  /// No description provided for @titleSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get titleSignOut;

  /// No description provided for @subtitleSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out of your user account'**
  String get subtitleSignOut;

  /// No description provided for @dialogTitleSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out?'**
  String get dialogTitleSignOut;

  /// No description provided for @dialogContentSignOut.
  ///
  /// In en, this message translates to:
  /// **'You will be signed out. However, you can simply sign in again from any device to get back to your personal user account.'**
  String get dialogContentSignOut;

  /// No description provided for @snackSignedOut.
  ///
  /// In en, this message translates to:
  /// **'Signed out'**
  String get snackSignedOut;

  /// No description provided for @durationMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes, plural, =0{just now} =1{1 minute ago} other{{minutes} minutes ago}}'**
  String durationMinutesAgo(num minutes);

  /// No description provided for @durationHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours, plural, =0{less than an hour ago} =1{1 hour ago} other{{hours} hours ago}}'**
  String durationHoursAgo(num hours);

  /// No description provided for @durationDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =0{today at {time}} =1{yesterday at {time}} other{{days} days ago at {time}}}'**
  String durationDaysAgo(num days, DateTime time);

  /// No description provided for @durationYearsAgo.
  ///
  /// In en, this message translates to:
  /// **'{adposition, select, true{{hideYear, select, true{on {date} {time}} other{on {dateYear} {time}}}} other{{hideYear, select, true{{date} {time}} other{{dateYear} {time}}}}}'**
  String durationYearsAgo(
    String adposition,
    String hideYear,
    DateTime date,
    DateTime dateYear,
    DateTime time,
  );

  /// No description provided for @doubleOneDigit.
  ///
  /// In en, this message translates to:
  /// **'{double}'**
  String doubleOneDigit(double double);

  /// No description provided for @doubleTwoDigits.
  ///
  /// In en, this message translates to:
  /// **'{double}'**
  String doubleTwoDigits(double double);
}

class _CoreAppLocalizationsDelegate
    extends LocalizationsDelegate<CoreAppLocalizations> {
  const _CoreAppLocalizationsDelegate();

  @override
  Future<CoreAppLocalizations> load(Locale locale) {
    return SynchronousFuture<CoreAppLocalizations>(
      lookupCoreAppLocalizations(locale),
    );
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_CoreAppLocalizationsDelegate old) => false;
}

CoreAppLocalizations lookupCoreAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return CoreAppLocalizationsDe();
    case 'en':
      return CoreAppLocalizationsEn();
  }

  throw FlutterError(
    'CoreAppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
