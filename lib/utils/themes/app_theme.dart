import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../styles/app_text_styles.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Color scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        background: AppColors.background,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimary,
        onBackground: AppColors.textPrimary,
        onError: Colors.white,
      ),

      // App bar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Medium',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),

      // Text theme
      textTheme: TextTheme(
        displayLarge: AppTextStyles.headline1,
        displayMedium: AppTextStyles.headline2,
        displaySmall: AppTextStyles.headline3,
        headlineMedium: AppTextStyles.headline4,
        headlineSmall: AppTextStyles.headline5,
        titleLarge: AppTextStyles.headline6,
        titleMedium: AppTextStyles.subtitle1,
        titleSmall: AppTextStyles.subtitle2,
        bodyLarge: AppTextStyles.bodyText1,
        bodyMedium: AppTextStyles.bodyText2,
        bodySmall: AppTextStyles.caption,
        labelLarge: AppTextStyles.button,
        labelSmall: AppTextStyles.overline,
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: AppTextStyles.button,
        ),
      ),

      // Outlined button theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: AppTextStyles.primaryButton,
        ),
      ),

      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: AppTextStyles.primaryButton,
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.lightGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.lightGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        labelStyle:
            AppTextStyles.bodyText2.copyWith(color: AppColors.textSecondary),
        hintStyle: AppTextStyles.bodyText2.copyWith(color: AppColors.textLight),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),

      // Card theme
      cardTheme: CardTheme(
        color: AppColors.cardBackground,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(8),
      ),

      // Floating action button theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 4,
      ),

      // Progress indicator theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: AppColors.lightGrey,
        circularTrackColor: AppColors.lightGrey,
      ),

      // Snack bar theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.darkGrey,
        contentTextStyle: AppTextStyles.bodyText2.copyWith(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 4,
      ),

      // Bottom navigation bar theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Font family
      fontFamily: 'Regular',
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // Color scheme
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: Color(0xFF1E1E1E),
        background: Color(0xFF121212),
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        onBackground: Colors.white,
        onError: Colors.white,
      ),

      // App bar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Medium',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),

      // Text theme with adjusted colors for dark mode
      textTheme: TextTheme(
        displayLarge: AppTextStyles.headline1.copyWith(color: Colors.white),
        displayMedium: AppTextStyles.headline2.copyWith(color: Colors.white),
        displaySmall: AppTextStyles.headline3.copyWith(color: Colors.white),
        headlineMedium: AppTextStyles.headline4.copyWith(color: Colors.white),
        headlineSmall: AppTextStyles.headline5.copyWith(color: Colors.white),
        titleLarge: AppTextStyles.headline6.copyWith(color: Colors.white),
        titleMedium: AppTextStyles.subtitle1.copyWith(color: Colors.white),
        titleSmall: AppTextStyles.subtitle2.copyWith(color: Colors.white),
        bodyLarge: AppTextStyles.bodyText1.copyWith(color: Colors.white70),
        bodyMedium: AppTextStyles.bodyText2.copyWith(color: Colors.white70),
        bodySmall: AppTextStyles.caption.copyWith(color: Colors.white60),
        labelLarge: AppTextStyles.button,
        labelSmall: AppTextStyles.overline,
      ),

      // Font family
      fontFamily: 'Regular',
    );
  }
}
