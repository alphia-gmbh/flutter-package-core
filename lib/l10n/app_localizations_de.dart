// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class CoreAppLocalizationsDe extends CoreAppLocalizations {
  CoreAppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get buttonCancel => 'Abbrechen';

  @override
  String get buttonClose => 'Schließen';

  @override
  String get buttonContinue => 'Weiter';

  @override
  String get buttonCopy => 'Kopieren';

  @override
  String get buttonDelete => 'Löschen';

  @override
  String get buttonDiscard => 'Verwerfen';

  @override
  String get buttonDownload => 'Herunterladen';

  @override
  String get buttonDuplicate => 'Duplizieren';

  @override
  String get buttonEditDate => 'Datum ändern';

  @override
  String get buttonEditText => 'Text bearbeiten';

  @override
  String get buttonExport => 'Exportieren';

  @override
  String get buttonOk => 'Ok';

  @override
  String get buttonRemove => 'Entfernen';

  @override
  String get buttonSave => 'Speichern';

  @override
  String get buttonShare => 'Teilen';

  @override
  String get buttonTryAgain => 'Erneut versuchen';

  @override
  String get buttonUndo => 'Rückgängig';

  @override
  String get dialogTitleContinue => 'Weiter?';

  @override
  String get dialogTitleDelete => 'Löschen?';

  @override
  String get dialogTitleDiscard => 'Verwerfen?';

  @override
  String get dialogTitleExport => 'Exportieren?';

  @override
  String get dialogTitleGenericError => 'Fehler';

  @override
  String get dialogContentGenericError => 'Etwas ist schiefgelaufen.';

  @override
  String get dialogTitleOffline => 'Kein Internet';

  @override
  String get dialogContentOffline =>
      'Es scheint du bist offline. Bitte verbinde dich mit dem Internet und versuche es dann erneut.';

  @override
  String get dialogTitleRemove => 'Entfernen?';

  @override
  String get dialogTitleUploaded => 'Hochgeladen';

  @override
  String get snackCopied => 'Kopiert';

  @override
  String get snackDeleted => 'Gelöscht';

  @override
  String get snackEditedDate => 'Datum geändert';

  @override
  String get snackEditedText => 'Text geändert';

  @override
  String get snackGenericError => 'Etwas ist schiefgelaufen';

  @override
  String get snackOffline => 'Kein Internet';

  @override
  String get snackSaved => 'Gespeichert';

  @override
  String get buttonMenu => 'Menü';

  @override
  String get appBarMenu => 'Menü';

  @override
  String get titleAccountAndSettings => 'Konto und Einstellungen';

  @override
  String get appBarAccountAndSettings => 'Konto und Einstellungen';

  @override
  String get titleFaq => 'Häufig gestellte Fragen';

  @override
  String get subtitleFaq => 'Sei neugierig';

  @override
  String get titleContact => 'Kontakt und Feedback';

  @override
  String get subtitleContact => 'Lass von dir hören';

  @override
  String get dialogTitleContact => 'Kontakt';

  @override
  String get dialogContentContact =>
      'Schick eine E-Mail und erzähl, was dir durch den Kopf geht:';

  @override
  String draftEmailSubject(String appName, String contactId) {
    return '$appName Feedback (Kontakt ID: $contactId)';
  }

  @override
  String draftEmailBody(String appName) {
    return 'Hi Team $appName,\n\n';
  }

  @override
  String get titleSupportApp => 'Unterstütze die App';

  @override
  String get subtitleSupportApp => 'Freiwillig mitmachen';

  @override
  String get titlePrivacyPolicy => 'Datenschutz';

  @override
  String get subtitlePrivacyPolicy => 'Datenschutzhinweise';

  @override
  String get titleLegalNotice => 'Impressum';

  @override
  String get subtitleLegalNotice => 'Anbieterkennzeichnung';

  @override
  String get titleLicenses => 'Lizenzen';

  @override
  String get appVersion => 'App-Version';

  @override
  String get subtitleAppVersion => 'App-Version';

  @override
  String get copyright2023 => 'Copyright 2023 Alphia GmbH';

  @override
  String get copyright2024 => 'Copyright 2024 Alphia GmbH';

  @override
  String get dialogTitleNoBrowser => 'Fehlender Browser';

  @override
  String get dialogContentNoBrowser =>
      'Dein Gerät hat keinen Webbrowser zum Öffnen von:';

  @override
  String get titleSignUpWith => 'Anmelden mit';

  @override
  String get subtitleSignUpWith => 'Sichere und synchronisiere deine App-Daten';

  @override
  String get buttonSignInWith => 'Anmelden mit';

  @override
  String get buttonSkipForNow => 'Erstmal überspringen';

  @override
  String get buttonContinueWith => 'Weiter mit';

  @override
  String get buttonContinueAsGuest => 'Weiter als Gast';

  @override
  String get guestUser => 'Gastnutzer';

  @override
  String get incognitoUser => 'Inkognito-Nutzer';

  @override
  String get noEmail => 'Keine E-Mail-Adresse';

  @override
  String get snackAccountCreatedNew => 'Neues Konto erstellt für dich';

  @override
  String get snackAccountCreatedGuest => 'Gastkonto erstellt für dich';

  @override
  String get snackWelcomeBack => 'Hurra! Willkommen zurück';

  @override
  String snackAppCheckBlocked(String platform) {
    String _temp0 = intl.Intl.selectLogic(platform, {
      'ios':
          'Sicherheit geht vor! Um maximalen Schutz zu gewährleisten, installiere ausschließlich aus dem Apple App Store',
      'android':
          'Sicherheit geht vor! Um maximalen Schutz zu gewährleisten, installiere ausschließlich aus dem Google Play Store',
      'web':
          'Dein Browser hat den Sicherheitstest nicht bestanden oder ist offline. Die Installation aus dem Apple App Store oder Google Play Store wird als Alternative empfohlen',
      'other':
          'Sicherheit geht vor! Um maximalen Schutz zu gewährleisten, installiere ausschließlich aus dem Apple App Store oder Google Play Store',
    });
    return '$_temp0';
  }

  @override
  String get snackPopupBlocked =>
      'Dein Browser blockiert das Anmelde-Pop-up. Erlaube das Pop-up und versuche es erneut';

  @override
  String snackSignInCanceled(String credentialProvider) {
    String _temp0 = intl.Intl.selectLogic(credentialProvider, {
      'apple': 'mit Apple ',
      'google': 'mit Google ',
      'microsoft': 'mit Microsoft ',
      'anonymous': 'als Gast ',
      'other': '',
    });
    return 'Bei der Anmeldung ${_temp0}ist etwas schiefgelaufen';
  }

  @override
  String get snackUserMismatched =>
      'Um sicherzugehen, dass du es bist, nutze das gleiche Konto wie beim ersten Mal:';

  @override
  String get snackVerifyCanceled =>
      'Bei der Verifizierung ist etwas schiefgelaufen';

  @override
  String get snackWebContext =>
      'Ein Browser-Tab für die Anmeldung scheint bereits geöffnet zu sein. Nutze den offenen Tab oder schließe ihn und versuche es erneut';

  @override
  String get titleUpdatePersonal => 'Persönliche Daten aktualisieren';

  @override
  String get subtitleUpdatePersonal => 'Ändere deine Anmeldemethode';

  @override
  String get appBarUpdatePersonal => 'Persönliche Daten aktualisieren';

  @override
  String get titleUpdatePersonalFirstStep => 'Erster Schritt';

  @override
  String contentUpdatePersonalFirstStep(String providerName, String email) {
    return 'Bitte melde dich erneut mit deinem aktuellen $providerName-Konto an, um zu verifizieren, dass es wirklich du bist ($email).';
  }

  @override
  String get buttonVerifyMe => 'Verifizieren';

  @override
  String get titleUpdatePersonalFirstStepDone => 'Erster Schritt abgeschlossen';

  @override
  String get contentUpdatePersonalFirstStepDone => 'Erfolgreich verifiziert';

  @override
  String get titleUpdatePersonalSecondStep => 'Zweiter Schritt';

  @override
  String get contentUpdatePersonalSecondStep =>
      'Hier kannst du nun auswählen, wie du dich künftig anmelden möchtest, und deinen aktualisierten Nutzernamen und E-Mail-Adresse angeben:';

  @override
  String contentUpdatePersonalSecondStepUnlink(String providerName) {
    return 'Oder du kannst dein Konto von \'Anmelden mit $providerName\' trennen und die App als Gast ohne E-Mail-Adresse weiternutzen:';
  }

  @override
  String get titleExportPersonal => 'Persönliche Daten exportieren';

  @override
  String subtitleExportPersonal(String isAnonymous) {
    String _temp0 = intl.Intl.selectLogic(isAnonymous, {
      'true': 'App-Daten',
      'other': 'Nutzerkontodaten',
    });
    return 'Exportiere deine $_temp0';
  }

  @override
  String get dialogContentExportPersonal =>
      'Eine Kopie deiner persönlichen Daten wird als ZIP-Archiv exportiert. Dein Archiv enthält eine übersichtliche HTML-Datei und eine JSON-Datei für den Import in andere Tagebuch-Apps.\n\nStelle bitte sicher, dass du deine Dateien sorgfältig aufbewahrst, besonders beim Speichern oder Teilen.';

  @override
  String get titleDeleteAccount => 'Persönliche Daten löschen';

  @override
  String subtitleDeleteAccount(String isAnonymous) {
    String _temp0 = intl.Intl.selectLogic(isAnonymous, {
      'true': 'deine App-Daten dauerhaft',
      'other': 'dein Nutzerkonto dauerhaft',
    });
    return 'Lösche $_temp0';
  }

  @override
  String dialogContentDeleteAccount(String isAnonymous, String email) {
    String _temp0 = intl.Intl.selectLogic(isAnonymous, {
      'true': 'Alle deine persönlichen Daten werden dauerhaft gelöscht.',
      'other':
          'Dein Nutzerkonto inklusive aller deiner persönlichen Daten wird dauerhaft gelöscht ($email). Zudem wirst du von allen synchronisierten Geräten abgemeldet.\n\nVor der Löschung musst du dich eventuell nochmal anmelden, um zu verifizieren, dass es wirklich du bist.',
    });
    return '$_temp0';
  }

  @override
  String snackDeleteAccount(String isAnonymous) {
    String _temp0 = intl.Intl.selectLogic(isAnonymous, {
      'true': 'App-Daten',
      'other': 'Nutzerkonto',
    });
    return '$_temp0 dauerhaft gelöscht';
  }

  @override
  String get buttonSignOut => 'Abmelden';

  @override
  String get titleSignOut => 'Abmelden';

  @override
  String get subtitleSignOut => 'Melde dich von deinem Nutzerkonto ab';

  @override
  String get dialogTitleSignOut => 'Abmelden?';

  @override
  String get dialogContentSignOut =>
      'Du wirst abgemeldet. Jedoch kannst du dich jederzeit einfach von jedem Gerät aus erneut anmelden, um wieder auf dein persönliches Nutzerkonto zuzugreifen.';

  @override
  String get snackSignedOut => 'Abgemeldet';

  @override
  String durationMinutesAgo(num minutes) {
    final intl.NumberFormat minutesNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String minutesString = minutesNumberFormat.format(minutes);

    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'vor $minutesString Minuten',
      one: 'vor 1 Minute',
      zero: 'gerade eben',
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
      other: 'vor $hoursString Stunden',
      one: 'vor 1 Stunde',
      zero: 'vor weniger als einer Stunde',
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
      other: 'vor $daysString Tagen um $timeString Uhr',
      one: 'gestern um $timeString Uhr',
      zero: 'heute um $timeString Uhr',
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
      'true': 'am $dateString $timeString',
      'other': 'am $dateYearString $timeString',
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
