import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,

      scaffoldBackgroundColor: AppColors.backgroundLight,

      colorScheme: _colorSchemeLight,

      dividerColor: AppColors.borderLight,

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: AppColors.textPrimaryLight,
      ),
      textTheme: AppTypography.buildTextTheme(
        primaryColor: AppColors.textPrimaryLight,
        secondaryColor: AppColors.textSecondaryLight,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceLight,
        elevation: 1,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.borderLight),
        ),
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 6,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceLight,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
      ),

      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        selectedColor: AppColors.primary,
        backgroundColor: AppColors.surfaceVariantLight,
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: AppColors.surfaceVariantLight,
      ),
      segmentedButtonTheme: segmentedButtonTheme(_colorSchemeLight),
    );
  }

  static const ColorScheme _colorSchemeLight = ColorScheme.light(
    primary: AppColors.primary,
    onPrimary: Colors.white,

    secondary: AppColors.secondary,
    onSecondary: Colors.white,

    secondaryContainer: AppColors.secondaryContainer,
    onSecondaryContainer: AppColors.onSecondaryContainer,

    error: AppColors.error,
    onError: Colors.white,

    surface: AppColors.surfaceLight,
    onSurface: AppColors.textPrimaryLight,

    surfaceContainerHighest: AppColors.surfaceVariantLight,
    onSurfaceVariant: AppColors.textSecondaryLight,

    primaryContainer: AppColors.primaryContainer,
    onPrimaryContainer: Color(0xFF3730A3),
  );

  static const ColorScheme _colorSchemeDark = ColorScheme.dark(
    primary: AppColors.primaryDark,
    onPrimary: AppColors.backgroundDark,

    secondary: AppColors.secondaryDark,
    onSecondary: AppColors.backgroundDark,

    secondaryContainer: AppColors.secondaryContainer,
    onSecondaryContainer: AppColors.onSecondaryContainer,

    error: AppColors.error,
    onError: AppColors.backgroundDark,

    surface: AppColors.surfaceDark,
    onSurface: AppColors.textPrimaryDark,

    surfaceContainerHighest: AppColors.surfaceVariantDark,
    onSurfaceVariant: AppColors.textSecondaryDark,

    primaryContainer: AppColors.primaryContainerDark,
    onPrimaryContainer: Color(0xFFE0E7FF),
  );

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,

      scaffoldBackgroundColor: AppColors.backgroundDark,

      colorScheme: _colorSchemeDark,

      dividerColor: AppColors.borderDark,

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundDark,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: AppColors.textPrimaryDark,
      ),
      textTheme: AppTypography.buildTextTheme(
        primaryColor: AppColors.textPrimaryDark,
        secondaryColor: AppColors.textSecondaryDark,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceDark,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.borderDark),
        ),
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryDark,
        foregroundColor: Colors.white,
        elevation: 6,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceDark,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),

      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        selectedColor: AppColors.primaryDark,
        backgroundColor: AppColors.surfaceVariantDark,
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primaryDark,
        linearTrackColor: AppColors.surfaceVariantDark,
      ),
      // Segmented buttons
      segmentedButtonTheme: segmentedButtonTheme(_colorSchemeDark),
    );
  }

  static SegmentedButtonThemeData segmentedButtonTheme(
    ColorScheme colorScheme,
  ) {
    return SegmentedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return colorScheme.surface;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.onPrimary;
          }
          return colorScheme.onSurface;
        }),
      ),
    );
  }
}
