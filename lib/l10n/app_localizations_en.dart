// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class CoreAppLocalizationsEn extends CoreAppLocalizations {
  CoreAppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get buttonCancel => 'Cancel';

  @override
  String get buttonClose => 'Close';

  @override
  String get buttonContinue => 'Continue';

  @override
  String get buttonCopy => 'Copy';

  @override
  String get buttonDelete => 'Delete';

  @override
  String get buttonDiscard => 'Discard';

  @override
  String get buttonDownload => 'Download';

  @override
  String get buttonDuplicate => 'Duplicate';

  @override
  String get buttonEditDate => 'Edit date';

  @override
  String get buttonEditText => 'Edit text';

  @override
  String get buttonExport => 'Export';

  @override
  String get buttonOk => 'Got it';

  @override
  String get buttonRemove => 'Remove';

  @override
  String get buttonSave => 'Save';

  @override
  String get buttonShare => 'Share';

  @override
  String get buttonTryAgain => 'Try again';

  @override
  String get buttonUndo => 'Undo';

  @override
  String get dialogTitleContinue => 'Continue?';

  @override
  String get dialogTitleDelete => 'Delete?';

  @override
  String get dialogTitleDiscard => 'Discard?';

  @override
  String get dialogTitleExport => 'Export?';

  @override
  String get dialogTitleGenericError => 'Error';

  @override
  String get dialogContentGenericError => 'Something didn’t go as planned.';

  @override
  String get dialogTitleOffline => 'No internet';

  @override
  String get dialogContentOffline =>
      'Looks like you’re offline. Connect to the internet first and then try again please.';

  @override
  String get dialogTitleRemove => 'Remove?';

  @override
  String get dialogTitleUploaded => 'Uploaded';

  @override
  String get snackCopied => 'Copied';

  @override
  String get snackDeleted => 'Deleted';

  @override
  String get snackEditedDate => 'Date edited';

  @override
  String get snackEditedText => 'Text edited';

  @override
  String get snackGenericError => 'Something didn’t go as planned';

  @override
  String get snackOffline => 'No internet connection';

  @override
  String get snackSaved => 'Saved';

  @override
  String get buttonMenu => 'Menu';

  @override
  String get appBarMenu => 'Menu';

  @override
  String get titleAccountAndSettings => 'Account and settings';

  @override
  String get appBarAccountAndSettings => 'Account and Settings';

  @override
  String get titleFaq => 'Frequently asked questions';

  @override
  String get subtitleFaq => 'Be curious';

  @override
  String get titleContact => 'Contact and feedback';

  @override
  String get subtitleContact => 'Get in touch';

  @override
  String get dialogTitleContact => 'Contact';

  @override
  String get dialogContentContact =>
      'Drop a line via email and tell what’s on your mind:';

  @override
  String draftEmailSubject(String appName, String contactId) {
    return '$appName Feedback (contact ID: $contactId)';
  }

  @override
  String draftEmailBody(String appName) {
    return 'Hi Team $appName,\n\n';
  }

  @override
  String get titleSupportApp => 'Support the app';

  @override
  String get subtitleSupportApp => 'Feel free to contribute';

  @override
  String get titlePrivacyPolicy => 'Privacy policy';

  @override
  String get subtitlePrivacyPolicy => 'Data protection information';

  @override
  String get titleLegalNotice => 'Legal notice';

  @override
  String get subtitleLegalNotice => 'Provider information';

  @override
  String get titleLicenses => 'Licenses';

  @override
  String get appVersion => 'app version';

  @override
  String get subtitleAppVersion => 'App version';

  @override
  String get copyright2023 => 'Copyright 2023 Alphia GmbH';

  @override
  String get copyright2024 => 'Copyright 2024 Alphia GmbH';

  @override
  String get dialogTitleNoBrowser => 'No browser';

  @override
  String get dialogContentNoBrowser =>
      'Your device has no web browser to open:';

  @override
  String get titleSignUpWith => 'Sign up with';

  @override
  String get subtitleSignUpWith => 'Backup and sync your app data';

  @override
  String get buttonSignInWith => 'Sign in with';

  @override
  String get buttonSkipForNow => 'Skip for now';

  @override
  String get buttonContinueWith => 'Continue with';

  @override
  String get buttonContinueAsGuest => 'Continue as Guest';

  @override
  String get guestUser => 'Guest user';

  @override
  String get incognitoUser => 'Incognito user';

  @override
  String get noEmail => 'no email address';

  @override
  String get snackAccountCreatedNew => 'New account created for you';

  @override
  String get snackAccountCreatedGuest => 'Guest account created for you';

  @override
  String get snackWelcomeBack => 'Hooray! Welcome back';

  @override
  String snackAppCheckBlocked(String platform) {
    String _temp0 = intl.Intl.selectLogic(platform, {
      'ios':
          'Security first! To maximize protection, reinstall exclusively from the Apple App Store',
      'android':
          'Security first! To maximize protection, reinstall exclusively from the Google Play Store',
      'web':
          'Your browser failed the security test or is offline. Installing from the Apple App Store or Google Play Store is the recommended alternative',
      'other':
          'Security first! To maximize protection, reinstall exclusively from the Apple App Store or Google Play Store',
    });
    return '$_temp0';
  }

  @override
  String get snackPopupBlocked =>
      'Your browser blocks the sign-in pop-up. Allow the pop-up and then try again';

  @override
  String snackSignInCanceled(String credentialProvider) {
    String _temp0 = intl.Intl.selectLogic(credentialProvider, {
      'apple': 'with Apple ',
      'google': 'with Google ',
      'microsoft': 'with Microsoft ',
      'anonymous': 'as Guest ',
      'other': '',
    });
    return 'Sign in ${_temp0}didn’t go as planned';
  }

  @override
  String get snackUserMismatched =>
      'To verify it’s really you use the same account you have initially signed in with:';

  @override
  String get snackVerifyCanceled => 'Sign in to verify didn’t go as planned';

  @override
  String get snackWebContext =>
      'A browser tab seems already open for sign-in. Use the open tab or close it and try again';

  @override
  String get titleUpdatePersonal => 'Update personal data';

  @override
  String get subtitleUpdatePersonal => 'Change your sign-in method';

  @override
  String get appBarUpdatePersonal => 'Update Personal Data';

  @override
  String get titleUpdatePersonalFirstStep => 'First Step';

  @override
  String contentUpdatePersonalFirstStep(String providerName, String email) {
    return 'Please sign in again using your current $providerName account to verify it’s really you ($email).';
  }

  @override
  String get buttonVerifyMe => 'Verify';

  @override
  String get titleUpdatePersonalFirstStepDone => 'First Step Completed';

  @override
  String get contentUpdatePersonalFirstStepDone => 'Successfully verified';

  @override
  String get titleUpdatePersonalSecondStep => 'Second Step';

  @override
  String get contentUpdatePersonalSecondStep =>
      'Here’s where you get to choose how you want to sign in from now on along with providing your updated user name and email address:';

  @override
  String contentUpdatePersonalSecondStepUnlink(String providerName) {
    return 'Or you can unlink your account from \'Sign in with $providerName\' and continue using the app as guest without an email address:';
  }

  @override
  String get titleExportPersonal => 'Export personal data';

  @override
  String subtitleExportPersonal(String isAnonymous) {
    String _temp0 = intl.Intl.selectLogic(isAnonymous, {
      'true': 'app data',
      'other': 'user account data',
    });
    return 'Export your $_temp0';
  }

  @override
  String get dialogContentExportPersonal =>
      'A copy of your personal data will be exported as ZIP archive. Your archive contains an easy-to-read HTML file and a JSON file for import into other journaling apps.\n\nPlease ensure you keep your files safe and secure, especially when saving or sharing them.';

  @override
  String get titleDeleteAccount => 'Delete personal data';

  @override
  String subtitleDeleteAccount(String isAnonymous) {
    String _temp0 = intl.Intl.selectLogic(isAnonymous, {
      'true': 'app data',
      'other': 'user account',
    });
    return 'Permanently delete your $_temp0';
  }

  @override
  String dialogContentDeleteAccount(String isAnonymous, String email) {
    String _temp0 = intl.Intl.selectLogic(isAnonymous, {
      'true': 'All your personal data will be deleted permanently.',
      'other':
          'Your user account including all your personal data will be deleted permanently ($email). Additionally, you will be signed out from all synced devices.\n\nYou may be asked to sign in again before the deletion to verify it’s really you.',
    });
    return '$_temp0';
  }

  @override
  String snackDeleteAccount(String isAnonymous) {
    String _temp0 = intl.Intl.selectLogic(isAnonymous, {
      'true': 'App data',
      'other': 'User account',
    });
    return '$_temp0 deleted permanently';
  }

  @override
  String get buttonSignOut => 'Sign out';

  @override
  String get titleSignOut => 'Sign out';

  @override
  String get subtitleSignOut => 'Sign out of your user account';

  @override
  String get dialogTitleSignOut => 'Sign out?';

  @override
  String get dialogContentSignOut =>
      'You will be signed out. However, you can simply sign in again from any device to get back to your personal user account.';

  @override
  String get snackSignedOut => 'Signed out';

  @override
  String durationMinutesAgo(num minutes) {
    final intl.NumberFormat minutesNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String minutesString = minutesNumberFormat.format(minutes);

    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutesString minutes ago',
      one: '1 minute ago',
      zero: 'just now',
    );
    return '$_temp0';
  }

  @override
  String durationHoursAgo(num hours) {
    final intl.NumberFormat hoursNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String hoursString = hoursNumberFormat.format(hours);

    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hoursString hours ago',
      one: '1 hour ago',
      zero: 'less than an hour ago',
    );
    return '$_temp0';
  }

  @override
  String durationDaysAgo(num days, DateTime time) {
    final intl.DateFormat timeDateFormat = intl.DateFormat.Hm(localeName);
    final String timeString = timeDateFormat.format(time);

    final intl.NumberFormat daysNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String daysString = daysNumberFormat.format(days);

    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$daysString days ago at $timeString',
      one: 'yesterday at $timeString',
      zero: 'today at $timeString',
    );
    return '$_temp0';
  }

  @override
  String durationYearsAgo(
    String adposition,
    String hideYear,
    DateTime date,
    DateTime dateYear,
    DateTime time,
  ) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.MMMd(localeName);
    final String dateString = dateDateFormat.format(date);
    final intl.DateFormat dateYearDateFormat = intl.DateFormat.yMMMd(
      localeName,
    );
    final String dateYearString = dateYearDateFormat.format(dateYear);
    final intl.DateFormat timeDateFormat = intl.DateFormat.Hm(localeName);
    final String timeString = timeDateFormat.format(time);

    String _temp0 = intl.Intl.selectLogic(hideYear, {
      'true': 'on $dateString $timeString',
      'other': 'on $dateYearString $timeString',
    });
    String _temp1 = intl.Intl.selectLogic(hideYear, {
      'true': '$dateString $timeString',
      'other': '$dateYearString $timeString',
    });
    String _temp2 = intl.Intl.selectLogic(adposition, {
      'true': '$_temp0',
      'other': '$_temp1',
    });
    return '$_temp2';
  }

  @override
  String doubleOneDigit(double double) {
    final intl.NumberFormat doubleNumberFormat =
        intl.NumberFormat.decimalPatternDigits(
          locale: localeName,
          decimalDigits: 1,
        );
    final String doubleString = doubleNumberFormat.format(double);

    return '$doubleString';
  }

  @override
  String doubleTwoDigits(double double) {
    final intl.NumberFormat doubleNumberFormat =
        intl.NumberFormat.decimalPatternDigits(
          locale: localeName,
          decimalDigits: 2,
        );
    final String doubleString = doubleNumberFormat.format(double);

    return '$doubleString';
  }
}
