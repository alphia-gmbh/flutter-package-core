// Copyright 2024 Alphia GmbH
import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart' show CupertinoAlertDialog, CupertinoDialogAction, showCupertinoDialog;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'crossplatform_io.dart' if (dart.library.js_interop) 'crossplatform_web.dart';
import 'service_theme.dart';
import 'service_widgets.dart';


/// Draft email with [address], [subject] and [body].
void coreDraftEmail({String address='hello@alphia.io', required String subject, required String body}) async {
  try {
    final draftEmail = Uri(scheme: 'mailto', path: address, query: 'subject=$subject&body=$body');
    final drafted = await launchUrl(draftEmail);
    if (!drafted) throw PlatformException(code: 'errorCode canal');
  } catch (_) {
    coreShowDialog(title: CoreInstance.text.dialogTitleContact, content: '${CoreInstance.text.dialogContentContact} $address', leftButton: null, rightButton: CoreInstance.text.buttonOk);
  }
  return;
}


/// Generate random ID string with optional [length] and [aA0=true] for lowercase, uppercase and numbers or [aA0=false] for only lowercase.
String coreGenerateId({int length=20, bool aA0=true}) {
  final random = Random.secure();
  final characters = aA0 ? 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789' : 'abcdefghijklmnopqrstuvwxyz';
  return List<String>.generate(length, (index) {return characters[random.nextInt(characters.length)];}).join();
}


/// Get time ago from [dateTime] to now.
String coreCalcTimeAgo({required DateTime ago, DateTime? now, bool capitalized=false}) {
  now ??= DateTime.now();
  final difference = now.difference(ago);
  String timeAgo = '';
  if (difference.inMinutes < 60) {
    timeAgo = CoreInstance.text.durationMinutesAgo(difference.inMinutes);
  } else if (difference.inHours < 24) {
    timeAgo = CoreInstance.text.durationHoursAgo(difference.inHours);
  } else if (difference.inDays < 7) {
    timeAgo = CoreInstance.text.durationDaysAgo(difference.inDays, ago);
  } else {
    timeAgo = CoreInstance.text.durationYearsAgo(capitalized.toString(), (ago.year == now.year).toString(), ago, ago, ago);
  }
  return (capitalized && (timeAgo.isNotEmpty)) ? '${timeAgo[0].toUpperCase()}${timeAgo.substring(1)}' : timeAgo;
}


/// Show dialog with [title] and [content] and optional [leftButton] and required [rightButton]. [isError] changes color to errorContainer. [hasTimer] adds countdown timer to rightButton.
Future<bool?> coreShowDialog({String? title, Widget? titleWidget, String? content, Widget? contentWidget, String? leftButton, required String rightButton, List<String>? buttonLabels, List<void Function()?>? buttonFunctions, bool isError=false, bool hasTimer=false}) {

  assert((title != null && titleWidget == null) || (title == null && titleWidget != null), 'errorCode turret');
  assert((content == null && contentWidget == null) || (content != null && contentWidget == null) || (content == null && contentWidget != null), 'errorCode driveway');
  assert((buttonLabels == null && buttonFunctions == null) || (buttonLabels != null && buttonFunctions != null && buttonLabels.length == buttonFunctions.length), 'errorCode quicksand');
  if (isError) HapticFeedback.lightImpact();
  final timerNotifier = ValueNotifier<int>(0);
  if (hasTimer) {
    timerNotifier.value = 9; // Countdown 9 seconds
    Timer.periodic(const Duration(seconds: 1), (timer) {timerNotifier.value--; if (timerNotifier.value <= 0) {timer.cancel();}});
  }

  if ([TargetPlatform.iOS, TargetPlatform.macOS].contains(Theme.of(CoreInstance.context).platform)) {
    return showCupertinoDialog<bool>(
      context: CoreInstance.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          // title: Text(title),
          title: titleWidget ?? ((title != null) ? Text(title) : null),
          content: contentWidget ?? ((content != null) ? Text(content) : null),
          actions: <Widget>[
            if (leftButton != null)
              CupertinoDialogAction(
                onPressed: () {Navigator.of(context).pop(false);},
                child: Text(leftButton),
              ),
            ValueListenableBuilder<int>(
              valueListenable: timerNotifier,
              builder: (BuildContext context, int timerListenable, Widget? child) {
                return CupertinoDialogAction(
                  isDefaultAction: true,
                  isDestructiveAction: isError && (leftButton != null) && (timerListenable <= 0),
                  onPressed: (timerListenable <= 0)
                    ? () {Navigator.of(context).pop(true);}
                    : null,
                  child: Text((timerListenable <= 0)
                    ? rightButton
                    : '$rightButton ($timerListenable)',
                    style: const TextStyle(fontFeatures: [FontFeature.tabularFigures()]), // Monospaced characters for countdown timer
                  ),
                );
              },
            ),
            if ((buttonLabels != null) && (buttonFunctions != null) && (buttonLabels.length == buttonFunctions.length))
              ...[for (final (index, label) in buttonLabels.indexed)
                  CupertinoDialogAction(
                    onPressed: () {Navigator.of(context).pop(); buttonFunctions[index]?.call();},
                    child: Text(label),
                  )
              ],
          ],
        );
      },
    );
  }
  else { // !Platform.isIOS
    return showDialog<bool>(
      context: CoreInstance.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return LayoutBuilder( // SingleChildScrollView necessary to make overflow scrollable, CupertinoAlertDialog is scrollable by default
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
                child: AlertDialog(
                  insetPadding: const EdgeInsets.all(CoreTheme.padding*2), // Margin around AlertDialog
                  title: titleWidget ?? ((title != null) ? Text(title) : null),
                  content: ConstrainedBox( // ConstrainedBox necessary to limit maxWidth, CupertinoAlertDialog is limited by default
                    constraints: const BoxConstraints(maxWidth: CoreTheme.maxWidth - 48 - (CoreTheme.padding *2)), // AlertDialog default content padding 48
                    child: contentWidget ?? ((content != null) ? Text(content) : null),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                  actionsOverflowDirection: VerticalDirection.up, // Apple guidelines // Place the button people are most likely to choose on the trailing side in a row of buttons or at the top in a stack of buttons. Always place the default button on the trailing side of a row or at the top of a stack. Cancel buttons are typically on the leading side of a row or at the bottom of a stack.
                  actions: !((buttonLabels != null) && (buttonFunctions != null) && (buttonLabels.length == buttonFunctions.length))
                    ? <Widget>[
                      if (leftButton != null)
                        TextButton(
                          onPressed: () {Navigator.of(context).pop(false);},
                          child: Text(leftButton),
                        ),
                      ValueListenableBuilder<int>(
                        valueListenable: timerNotifier,
                        builder: (BuildContext context, int timerListenable, Widget? child) {
                          return TextButton(
                            onPressed: (timerListenable <= 0)
                              ? () {Navigator.of(context).pop(true);}
                              : null,
                            style: isError ? TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.errorContainer) : null,
                            child: Text((timerListenable <= 0)
                              ? rightButton
                              : '$rightButton ($timerListenable)',
                              style: const TextStyle(fontFeatures: [FontFeature.tabularFigures()]), // Monospaced characters for countdown timer
                            ),
                          );
                        },
                      ),
                    ]
                    : <Widget>[
                      if (leftButton != null)
                        TextButton(
                          onPressed: () {Navigator.of(context).pop(false);},
                          child: Text(leftButton),
                        ),
                      ValueListenableBuilder<int>(
                        valueListenable: timerNotifier,
                        builder: (BuildContext context, int timerListenable, Widget? child) {
                          return TextButton(
                            onPressed: (timerListenable <= 0)
                              ? () {Navigator.of(context).pop(true);}
                              : null,
                            style: isError ? TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.errorContainer) : null,
                            child: Text((timerListenable <= 0)
                              ? rightButton
                              : '$rightButton ($timerListenable)',
                              style: const TextStyle(fontFeatures: [FontFeature.tabularFigures()]), // Monospaced characters for countdown timer
                            ),
                          );
                        },
                      ),
                      ...[for (final (index, label) in buttonLabels.indexed)
                        TextButton(
                          onPressed: () {Navigator.of(context).pop(); buttonFunctions[index]?.call();},
                          child: Text(label),
                        )
                      ],
                    ].reversed.toList()
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class CoreShowDialog {
  static Future<bool?> genericError() async {
    return await coreShowDialog(title: CoreInstance.text.dialogTitleGenericError, content: CoreInstance.text.dialogContentGenericError, leftButton: null, rightButton: CoreInstance.text.buttonOk);
  }
  static Future<bool?> offline() async {
    return await coreShowDialog(title: CoreInstance.text.dialogTitleOffline, content: CoreInstance.text.dialogContentOffline, leftButton: null, rightButton: CoreInstance.text.buttonOk);
  }
}


/// Show circular progress indicator with barrier. Adaptive to platform.
void coreShowProgressIndicator() {
  showDialog(
    context: CoreInstance.context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const PopScope(
        canPop: false,
        child: CoreProgressIndicator(),
      );
    },
  );
  return;
}


/// Show [content] in snackbar with optional [actionLabel] and [actionFunction]. [clearSnackbars] cancels all previous snackbars. [isError] changes color to errorContainer.
void coreShowSnackbar({required String content, String? actionLabel, void Function()? actionFunction, bool clearSnackbars=false,  bool isError=false}) {
  assert((actionLabel == null && actionFunction == null) || (actionLabel != null && actionFunction != null), 'errorCode voice');
  final context = CoreInstance.context;
  if (clearSnackbars) ScaffoldMessenger.of(context).clearSnackBars();
  final isFixed = CorePlatform.isIOS && ((MediaQuery.widthOf(context) - (CoreTheme.padding *4)) < (CoreTheme.maxWidth - (CoreTheme.padding *2)));
  final iOSWorkaround = CorePlatform.isIOS && (MediaQuery.orientationOf(context) == Orientation.landscape); // Workaround centering for iOS landscape orientation
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: isFixed ? SnackBarBehavior.fixed : SnackBarBehavior.floating,
      width: (isFixed || iOSWorkaround) ? null : min(MediaQuery.widthOf(context) - (CoreTheme.padding *4), CoreTheme.maxWidth - (CoreTheme.padding *2)),
      margin: iOSWorkaround ? EdgeInsets.symmetric(horizontal: (MediaQuery.widthOf(context) - MediaQuery.paddingOf(context).horizontal - min(MediaQuery.widthOf(context) - (CoreTheme.padding *4), CoreTheme.maxWidth - (CoreTheme.padding *2))) /2) : null,
      actionOverflowThreshold: 0.62, // The percentage threshold for action widget's width before it overflows to a new line.
      shape: isFixed ? const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(CoreTheme.innerRadius))) : RoundedRectangleBorder(borderRadius: BorderRadius.circular(CoreTheme.innerRadius)),
      content: Align(
        alignment: ((actionLabel != null) && (actionFunction != null))
          ? Alignment.centerLeft
          : Alignment.center,
        heightFactor: 1, // Only as tall as child
        child: Text(content,
          textAlign: TextAlign.center,
          style: isError ? TextStyle(color: Theme.of(context).colorScheme.onErrorContainer) : null,
        ),
      ),
      backgroundColor: isError ? Theme.of(context).colorScheme.errorContainer : null,
      duration: const Duration(seconds: 7),
      persist: false, // Add this line to restore auto-dismiss behavior
      action: ((actionLabel != null) && (actionFunction != null))
        ? SnackBarAction(label: actionLabel, onPressed: actionFunction)
        : null,
    ),
  );
  return;
}

class CoreShowSnackbar {
  static void genericError() {
    coreShowSnackbar(content: CoreInstance.text.snackGenericError, isError: true);
    return;
  }
}
