import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

abstract class AppTheme {
  static ThemeData get light => _build(_lightScheme);
  static ThemeData get dark => _build(_darkScheme);

  static const ColorScheme _lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primaryDark,
    onPrimary: AppColors.background,
    primaryContainer: AppColors.primaryLight,
    onPrimaryContainer: AppColors.text,
    secondary: AppColors.primary,
    onSecondary: AppColors.text,
    secondaryContainer: AppColors.primaryLight,
    onSecondaryContainer: AppColors.text,
    error: Color(0xFFB3261E),
    onError: AppColors.background,
    surface: AppColors.background,
    onSurface: AppColors.text,
    surfaceContainerLowest: AppColors.background,
    surfaceContainerLow: AppColors.backgroundAlt,
    surfaceContainer: AppColors.backgroundMuted,
    onSurfaceVariant: AppColors.textMuted,
    outline: AppColors.border,
    outlineVariant: AppColors.border,
  );

  static final ColorScheme _darkScheme = ColorScheme.fromSeed(
    seedColor: AppColors.primaryDark,
    brightness: Brightness.dark,
  );

  static ThemeData _build(ColorScheme scheme) {
    final base = ThemeData(useMaterial3: true, colorScheme: scheme);

    return base.copyWith(
      scaffoldBackgroundColor: scheme.surface,
      dividerColor: scheme.outline,
      textTheme: GoogleFonts.poppinsTextTheme(base.textTheme).copyWith(
        displayLarge: AppTextStyles.titleBold30,
        displayMedium: AppTextStyles.titleBold25,
        displaySmall: AppTextStyles.titleBold20,
        headlineMedium: AppTextStyles.titleSemiBold25,
        headlineSmall: AppTextStyles.titleSemiBold20,
        titleLarge: AppTextStyles.titleSemiBold20,
        titleMedium: AppTextStyles.titleSemiBold15,
        titleSmall: AppTextStyles.labelMedium15,
        bodyLarge: AppTextStyles.paragraphRegular15,
        bodyMedium: AppTextStyles.paragraphMedium12,
        bodySmall: AppTextStyles.paragraphMedium10,
        labelLarge: AppTextStyles.labelMedium15,
        labelMedium: AppTextStyles.labelMedium12,
        labelSmall: AppTextStyles.labelMedium12,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTextStyles.titleSemiBold20.copyWith(
          color: scheme.onSurface,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.backgroundAlt,
        hintStyle: AppTextStyles.paragraphRegular15.copyWith(
          color: AppColors.textMuted,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.primary, width: 1.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          textStyle: AppTextStyles.labelMedium15,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.link,
          textStyle: AppTextStyles.labelMedium15,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.onSurface,
          side: const BorderSide(color: AppColors.border),
          textStyle: AppTextStyles.labelMedium15,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
