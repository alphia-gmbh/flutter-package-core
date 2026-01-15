// Copyright 2024 Alphia GmbH
import 'package:flutter/material.dart';

// Rewrite int colors to hex colors
// perl -i -pe 's/Color\((\d+)\)/"Color(0x".sprintf("%08X", $1).")"/ge' lib/service_theme.dart

/// Provides core app scheme including text and color in [.light] or [.dark]. And gives static access to theme parameters.
class CoreTheme {
  final BuildContext context;
  CoreTheme(this.context);

  static const animationDuration = Duration(milliseconds: 300); // Base value 300ms // 0.75: 225ms, 1.0: 300ms, 1.5: 450ms, 2.0: 600ms // Optimum between 200-500ms // Slow open or forward and fast close or backwards // Global animation curves // On screen animation: fastOutSlowIn, Enter animation: outCubic (or decelerate), Exit animation: inCubic (or easeIn)
  static const double maxWidth = 460; // Max card and reading width // Corresponding with webview style CSS
  static const double padding = 16;
  static const double radius = 28; // 24;
  static const double innerRadius = 12; // 14; // Smaller inner radius for text field and snackbar // Outer radius - padding = inner radius

  ThemeData get light => _themeData(lightColorScheme);
  ThemeData get dark => _themeData(darkColorScheme);

  TextTheme _textTheme() {
    final displayTextTheme = Theme.of(context).textTheme.apply(fontFamily: 'InterTight', package: 'alphia_core');
    final bodyTextTheme = Theme.of(context).textTheme.apply(fontFamily: 'Inter', package: 'alphia_core');
    return displayTextTheme.copyWith(
      bodyLarge: bodyTextTheme.bodyLarge!.copyWith(letterSpacing: 0),
      bodyMedium: bodyTextTheme.bodyMedium!.copyWith(letterSpacing: 0),
      bodySmall: bodyTextTheme.bodySmall,
      labelLarge: bodyTextTheme.labelLarge,
      labelMedium: bodyTextTheme.labelMedium,
      labelSmall: bodyTextTheme.labelSmall,
    );
  }

  ThemeData _themeData(ColorScheme colorScheme) {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: _textTheme().apply(
        displayColor: colorScheme.onSurface,
        bodyColor: colorScheme.onSurface,
      ),
      useMaterial3: true,

      appBarTheme: const AppBarTheme(
        centerTitle: true,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: const ButtonStyle(tapTargetSize: MaterialTapTargetSize.padded),
      ),
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: padding *2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(innerRadius)),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        // ignore: deprecated_member_use
        year2023: false,
      ),
      sliderTheme: const SliderThemeData(
        // ignore: deprecated_member_use
        year2023: false,
      ),
      snackBarTheme: const SnackBarThemeData(
        insetPadding: EdgeInsets.all(padding *2), // Margin around SnackBar // Combination with SnackBar width necessary
      ),
      tooltipTheme: const TooltipThemeData(
        waitDuration: Duration(seconds: 1), // Delay for Web mouse hover
      ),

      // dataTableTheme: DataTableThemeData(
      //   dataRowColor: WidgetStateProperty<Color?>.fromMap(<WidgetStatesConstraint, Color?>{
      //     WidgetState.hovered: colorScheme.primary.withValues(alpha: 0.04),
      //     WidgetState.any: null,
      //   }),
      //   // dataRowColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      //   //   if (states.contains(WidgetState.hovered)) return colorScheme.primary.withValues(alpha: 0.04);
      //   //   return null;
      //   // }),
      //   dataRowCursor: WidgetStateProperty<MouseCursor>.fromMap(<WidgetStatesConstraint, MouseCursor>{
      //     WidgetState.any: SystemMouseCursors.basic,
      //   }),
      //   // dataRowCursor: WidgetStateProperty.resolveWith<MouseCursor>((Set<WidgetState> states) {
      //   //   return SystemMouseCursors.basic;
      //   // }),
      // ),
      // iconTheme: IconThemeData(
      //   // color: colorScheme.onSurfaceVariant, // Workaround for IconButtonThemeData not working in dark mode
      //   weight: 500,
      // ),

      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF000000),
    surfaceTint: Color(0xFF5E5E5E),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFF262626),
    onPrimaryContainer: Color(0xFFB1B1B1),
    secondary: Color(0xFF5E5E5E),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFE6E6E6),
    onSecondaryContainer: Color(0xFF4A4A4A),
    tertiary: Color(0xFF000000),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFF262626),
    onTertiaryContainer: Color(0xFFB1B1B1),
    error: Color(0xFF912A3F), // Seed color #DA6275
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFC04E62),
    onErrorContainer: Color(0xFFFFFFFF),
    surface: Color(0xFFF3F3F3), // Seed color
    onSurface: Color(0xFF1D1D1F), // surface with black overlay 88% opacity and blue +2
    onSurfaceVariant: Color(0xFF3D3D3F), // surface with black overlay 75% opacity and blue +2
    outline: Color(0xFF727277), // surface with black overlay 53% opacity and blue +5
    outlineVariant: Color(0xFFC0C0C2), // surface with black overlay 21% opacity and blue +2
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFF303030),
    onInverseSurface: Color(0xFFF1F1F1),
    inversePrimary: Color(0xFFC6C6C6),
    primaryFixed: Color(0xFFE2E2E2),
    onPrimaryFixed: Color(0xFF1B1B1B),
    primaryFixedDim: Color(0xFFC6C6C6),
    onPrimaryFixedVariant: Color(0xFF474747),
    secondaryFixed: Color(0xFFE2E2E2),
    onSecondaryFixed: Color(0xFF1B1B1B),
    secondaryFixedDim: Color(0xFFC6C6C6),
    onSecondaryFixedVariant: Color(0xFF474747),
    tertiaryFixed: Color(0xFFE2E2E2),
    onTertiaryFixed: Color(0xFF1B1B1B),
    tertiaryFixedDim: Color(0xFFC6C6C6),
    onTertiaryFixedVariant: Color(0xFF474747),
    surfaceDim: Color(0xFFD4D4D4), // surfaceContainerHighest -8
    surfaceBright: Color(0xFFF3F3F3), // surface
    surfaceContainerLowest: Color(0xFFF9F9F9), // surface +6
    surfaceContainerLow: Color(0xFFEDEDED), // surface -6
    surfaceContainer: Color(0xFFE8E8E8), // surfaceContainerLow -5
    surfaceContainerHigh: Color(0xFFE2E2E2), // surfaceContainer -6
    surfaceContainerHighest: Color(0xFFDCDCDC), // surfaceContainerHigh -6
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFC6C6C6),
    surfaceTint: Color(0xFFC6C6C6),
    onPrimary: Color(0xFF303030),
    // primaryContainer: Color(0xFF000000),
    // onPrimaryContainer: Color(0xFF969696),
    primaryContainer: Color(0xFF3D3D3D), // secondaryContainer // Time picker selection
    onPrimaryContainer: Color(0xFFD1D1D1), // onSecondaryContainer
    secondary: Color(0xFFC6C6C6),
    onSecondary: Color(0xFF303030),
    secondaryContainer: Color(0xFF3D3D3D),
    onSecondaryContainer: Color(0xFFD1D1D1),
    tertiary: Color(0xFFC6C6C6),
    onTertiary: Color(0xFF303030),
    tertiaryContainer: Color(0xFF000000),
    onTertiaryContainer: Color(0xFF969696),
    error: Color(0xFFFFB2BA), // Seed color #DA6275
    onError: Color(0xFF650521),
    errorContainer: Color(0xFFC04E62),
    onErrorContainer: Color(0xFFFFFFFF),
    surface: Color(0xFF000000), // Seed color
    onSurface: Color(0xFFE1E1E3), // surface with white overlay 88% opacity and blue +2
    onSurfaceVariant: Color(0xFFBFBFC1), // surface with white overlay 75% opacity and blue +2
    outline: Color(0xFF87878C), // surface with white overlay 53% opacity and blue +5
    outlineVariant: Color(0xFF353537), // surface with white overlay 21% opacity and blue +2
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFFE2E2E2),
    onInverseSurface: Color(0xFF303030),
    inversePrimary: Color(0xFF5E5E5E),
    primaryFixed: Color(0xFFE2E2E2),
    onPrimaryFixed: Color(0xFF1B1B1B),
    primaryFixedDim: Color(0xFFC6C6C6),
    onPrimaryFixedVariant: Color(0xFF474747),
    secondaryFixed: Color(0xFFE2E2E2),
    onSecondaryFixed: Color(0xFF1B1B1B),
    secondaryFixedDim: Color(0xFFC6C6C6),
    onSecondaryFixedVariant: Color(0xFF474747),
    tertiaryFixed: Color(0xFFE2E2E2),
    onTertiaryFixed: Color(0xFF1B1B1B),
    tertiaryFixedDim: Color(0xFFC6C6C6),
    onTertiaryFixedVariant: Color(0xFF474747),
    surfaceDim: Color(0xFF000000), // surface
    surfaceBright: Color(0xFF262626), // surfaceContainerHighest +4
    surfaceContainerLowest: Color(0xFF080808), // surface -5 not possible, therefore surfaceContainerLow
    surfaceContainerLow: Color(0xFF080808), // surface +8
    surfaceContainer: Color(0xFF0C0C0C), // surfaceContainerLow +4
    surfaceContainerHigh: Color(0xFF171717), // surfaceContainer +11
    surfaceContainerHighest: Color(0xFF222222), // surfaceContainerHigh +11
  );
}
