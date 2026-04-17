// Copyright 2024 Alphia GmbH
import 'package:flutter/cupertino.dart' show CupertinoActivityIndicator;
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'crossplatform_io.dart' if (dart.library.js_interop) 'crossplatform_web.dart';
import 'l10n/app_localizations.dart';
import 'service_auth.dart';
import 'service_functions.dart';
import 'service_theme.dart';


/// Provides core instances.
class CoreInstance {
  static final BuildContext context = navigatorKey.currentState!.context;
  static final dynamic crashlytics = crossFirebaseCrashlyticsInstance;
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final CoreAppLocalizations text = CoreAppLocalizations.of(context);
  static final CoreUserNotifier userNotifier = CoreUserNotifier();
}


/// Provide core animated widget switching by cross-fading. Stateful Widgets have to include a key [Text(text, key: ValueKey<String?>(text))] [const SizedBox(key: ValueKey<bool>(false))]. Optional alignment topCenter (default) or by value [alignment: Alignment.topLeft].
class CoreAnimatedSwitcher extends StatelessWidget {
  const CoreAnimatedSwitcher(this.widget, {super.key,  this.alignment=Alignment.topCenter, this.fit=StackFit.loose});
  final Widget? widget;
  final AlignmentGeometry alignment;
  final StackFit fit;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: CoreTheme.animationDuration *2,
      switchInCurve: const Interval(0.38, 1, curve: Curves.easeOutCubic),
      switchOutCurve: Interval(0.62, 1, curve: Curves.easeInCubic.flipped), // Reverse timing
      layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) { // Default implementation but without Alignment.center to avoid vertical jumping
        return Stack(
          alignment: alignment,
          fit: fit,
          children: <Widget>[
            ...previousChildren,
            ?currentChild,
          ],
        );
      },
      child: widget, // Text(text, key: ValueKey<String?>(text)), // This key causes the AnimatedSwitcher to interpret this as a new child each time the text changes, so that it will begin its animation when the text changes
    );
  }
}


/// Provides core back button widget in iOS style.
class CoreBackButton extends StatelessWidget {
  const CoreBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
      color: Theme.of(context).colorScheme.onSurface,
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: () {Navigator.maybePop(context);},
    );
  }
}


/// Provides core divider widget with options horizontal (default) or vertical [vertical: true].
class CoreDivider extends StatelessWidget {
  const CoreDivider({super.key, this.vertical=false});
  final bool vertical; // Vertical divider option

  @override
  Widget build(BuildContext context) {
    return vertical
      ? const VerticalDivider(
          indent: CoreTheme.padding *0.62,
          endIndent: CoreTheme.padding *0.62,
          thickness: 1.5,
          // thickness: (Theme.of(context).colorScheme.brightness == Brightness.light) ? 1.5 : 2.0, // Irradiation illusion and width needs more emphasis than height
        )
      : const Divider(
          indent: CoreTheme.padding *2,
          endIndent: CoreTheme.padding *2,
        );
  }
}


/// Provides core fade out animation widget. Slow out and fast in. Use with a [Listenable] and a [bool] to indicate if faded in or not.
class CoreFadeOutAnimation extends StatefulWidget {
  const CoreFadeOutAnimation({super.key, required this.child, required this.visible, this.alignment=Alignment.topCenter, this.hasInfiniteWidth=false});
  final Widget child;
  // final Listenable listenable;
  final bool visible;
  final AlignmentGeometry alignment;
  final bool hasInfiniteWidth;
  @override
  State<CoreFadeOutAnimation> createState() => _CoreFadeOutAnimationState();
}
class _CoreFadeOutAnimationState extends State<CoreFadeOutAnimation> {
  @override
  Widget build(BuildContext context) {
    // return ListenableBuilder(
    //   listenable: widget.listenable,
    //   builder: (BuildContext context, Widget? builderChild) {
        return AnimatedCrossFade(
          crossFadeState: widget.visible ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          alignment: widget.alignment,
          duration: CoreTheme.animationDuration,
          firstCurve: const Interval(0, 0.35, curve: Curves.easeInCubic),
          // secondCurve: // Not relevant for invisible SizedBox()
          sizeCurve: const Interval(0.25, 0.75, curve: Curves.fastOutSlowIn),
          firstChild: widget.child,
          secondChild: SizedBox(width: widget.hasInfiniteWidth ? double.infinity : 0, height: 0, key: Key('shrink')),
        );
    //   },
    // );
  }
}

/// Provides core fade in animation widget. Slow in and fast out. Use with a [Listenable] and a [bool] to indicate if faded in or not.
class CoreFadeInAnimation extends StatefulWidget {
  const CoreFadeInAnimation({super.key, required this.child, required this.listenable, required this.visible, this.alignment=Alignment.topCenter, this.hasInfiniteWidth=false});
  final Widget child;
  final Listenable listenable;
  final bool visible;
  final AlignmentGeometry alignment;
  final bool hasInfiniteWidth;
  @override
  State<CoreFadeInAnimation> createState() => _CoreFadeInAnimationState();
}
class _CoreFadeInAnimationState extends State<CoreFadeInAnimation> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.listenable,
      builder: (BuildContext context, Widget? builderChild) {
        return AnimatedCrossFade(
          crossFadeState: !widget.visible ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          alignment: widget.alignment,
          duration: CoreTheme.animationDuration,
          // firstCurve: // Not relevant for invisible SizedBox()
          secondCurve: const Interval(0.50, 1, curve: Curves.easeOutCubic),
          sizeCurve: const Interval(0.25, 0.75, curve: Curves.fastOutSlowIn),
          firstChild: SizedBox(width: widget.hasInfiniteWidth ? double.infinity : 0, height: 0, key: Key('shrink')),
          secondChild: widget.child,
        );
      },
    );
  }
}


/// Provides core circular progress indicator widget. Adaptive to platform.
class CoreProgressIndicator extends StatelessWidget {
  const CoreProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return [TargetPlatform.iOS, TargetPlatform.macOS].contains(Theme.of(context).platform)
      ? CupertinoActivityIndicator(
          radius: CoreTheme.padding *1.2,
          color: Theme.of(context).colorScheme.primary,
        )
      : const Center(
          child: SizedBox(
            width: CoreTheme.padding *4,
            height: CoreTheme.padding *4,
            child: CircularProgressIndicator(),
          ),
        );
  }
}


/// Provides core selection area, if on Web.
class CoreSelectionArea extends StatelessWidget {
  const CoreSelectionArea({super.key, required this.scaffold});
  final Widget scaffold;

  @override
  Widget build(BuildContext context) {
    return CorePlatform.isWeb
      ? scaffold // SelectionArea(child: scaffold) // https://github.com/flutter/flutter/issues/151536#issuecomment-2912736574
      : scaffold;
  }
}


/// Provides core sign-out button widget.
class CoreSignOutButton extends StatelessWidget {
  const CoreSignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: IconButton(
        icon: const Icon(Symbols.logout_rounded),
        tooltip: CoreInstance.text.buttonSignOut,
        onPressed:  () {
          coreSignOutUser().then((result) {if (result) coreShowSnackbar(content: CoreInstance.text.snackSignedOut, clearSnackbars: true);});
        }
      )
    );
  }
}
