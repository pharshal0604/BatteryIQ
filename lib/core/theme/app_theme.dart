import 'package:ev_fleet_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  /// ==================== LIGHT THEME ====================
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    // Scaffold
    scaffoldBackgroundColor: AppColors.lightBackground,
    shadowColor: Colors.black.withValues(alpha: 0.05),

    // Color Scheme
    colorScheme: const ColorScheme.light(
      primary: AppColors.brandGreen,
      secondary: AppColors.brandGreen,
      surface: AppColors.lightSurface,
      error: AppColors.error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.lightTextPrimary,
      onError: Colors.white,
    ),

    // AppBar
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      iconTheme: const IconThemeData(color: AppColors.lightTextPrimary),
      titleTextStyle: GoogleFonts.lato(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.lightTextPrimary,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),

    // Divider
    dividerColor: AppColors.lightDivider,
    dividerTheme: const DividerThemeData(
      color: AppColors.lightDivider,
      thickness: 1,
    ),

    // Icon
    iconTheme: const IconThemeData(color: AppColors.lightIcon, size: 24),

    // Card
    cardTheme: CardThemeData(
      color: AppColors.lightSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppColors.lightDivider, width: 1),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    ),

    // Chip
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.lightSurface,
      selectedColor: AppColors.brandGreen,
      disabledColor: AppColors.lightDivider,
      labelStyle: GoogleFonts.lato(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.lightTextPrimary,
      ),
      secondaryLabelStyle: GoogleFonts.lato(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      side: const BorderSide(color: AppColors.lightDivider),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      showCheckmark: false,
    ),

    // Progress Indicator
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.brandGreen,
      linearTrackColor: AppColors.lightDivider,
      linearMinHeight: 6,
    ),

    // Bottom Sheet
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.lightBackground,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    ),

    // Snackbar
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.lightTextPrimary,
      contentTextStyle: GoogleFonts.lato(
        fontSize: 14,
        color: Colors.white,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      behavior: SnackBarBehavior.floating,
      insetPadding: const EdgeInsets.all(12),
    ),

    // Text Theme
    textTheme: GoogleFonts.latoTextTheme().copyWith(
      displayLarge: GoogleFonts.lato(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.lightTextPrimary,
      ),
      displayMedium: GoogleFonts.lato(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.lightTextPrimary,
      ),
      displaySmall: GoogleFonts.lato(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.lightTextPrimary,
      ),
      headlineLarge: GoogleFonts.lato(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColors.lightTextPrimary,
      ),
      headlineMedium: GoogleFonts.lato(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.lightTextPrimary,
      ),
      titleLarge: GoogleFonts.lato(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.lightTextPrimary,
      ),
      titleMedium: GoogleFonts.lato(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.lightTextPrimary,
      ),
      bodyLarge: GoogleFonts.lato(
        fontSize: 16,
        color: AppColors.lightTextPrimary,
      ),
      bodyMedium: GoogleFonts.lato(
        fontSize: 14,
        color: AppColors.lightTextSecondary,
      ),
      bodySmall: GoogleFonts.lato(
        fontSize: 12,
        color: AppColors.lightTextSecondary,
      ),
    ),

    // Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.brandGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        textStyle: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),

    // Outlined Button
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.brandGreen,
        side: const BorderSide(color: AppColors.brandGreen, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        textStyle: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),

    // Text Button
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.brandGreen,
        textStyle: GoogleFonts.lato(fontSize: 13, fontWeight: FontWeight.w500),
      ),
    ),

    // Input Decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightSurface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.lightDivider),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.lightDivider),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.brandGreen, width: 2),
      ),
      labelStyle: GoogleFonts.lato(color: AppColors.lightTextSecondary),
      hintStyle: GoogleFonts.lato(color: AppColors.lightTextSecondary),
    ),

    // Radio
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.brandGreen;
        return AppColors.lightTextSecondary;
      }),
    ),
  );

  /// ==================== DARK THEME ====================
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    // Scaffold
    scaffoldBackgroundColor: AppColors.darkBackground,
    shadowColor: Colors.black.withValues(alpha: 0.2),

    // Color Scheme
    colorScheme: const ColorScheme.dark(
      primary: AppColors.brandGreen,
      secondary: AppColors.brandGreen,
      surface: AppColors.darkSurface,
      error: AppColors.error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.darkTextPrimary,
      onError: Colors.white,
    ),

    // AppBar
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      iconTheme: const IconThemeData(color: AppColors.darkTextPrimary),
      titleTextStyle: GoogleFonts.lato(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.darkTextPrimary,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
    ),

    // Divider
    dividerColor: AppColors.darkDivider,
    dividerTheme: const DividerThemeData(
      color: AppColors.darkDivider,
      thickness: 1,
    ),

    // Icon
    iconTheme: const IconThemeData(color: AppColors.darkIcon, size: 24),

    // Card
    cardTheme: CardThemeData(
      color: AppColors.darkSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppColors.darkDivider, width: 1),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    ),

    // Chip
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.darkSurface,
      selectedColor: AppColors.brandGreen,
      disabledColor: AppColors.darkDivider,
      labelStyle: GoogleFonts.lato(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.darkTextPrimary,
      ),
      secondaryLabelStyle: GoogleFonts.lato(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      side: const BorderSide(color: AppColors.darkDivider),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      showCheckmark: false,
    ),

    // Progress Indicator
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.brandGreen,
      linearTrackColor: AppColors.darkDivider,
      linearMinHeight: 6,
    ),

    // Bottom Sheet
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.darkSurface,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    ),

    // Snackbar
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.darkSurface,
      contentTextStyle: GoogleFonts.lato(
        fontSize: 14,
        color: AppColors.darkTextPrimary,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      behavior: SnackBarBehavior.floating,
      insetPadding: const EdgeInsets.all(12),
    ),

    // Text Theme
    textTheme: GoogleFonts.latoTextTheme().copyWith(
      displayLarge: GoogleFonts.lato(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.darkTextPrimary,
      ),
      displayMedium: GoogleFonts.lato(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.darkTextPrimary,
      ),
      displaySmall: GoogleFonts.lato(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.darkTextPrimary,
      ),
      headlineLarge: GoogleFonts.lato(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColors.darkTextPrimary,
      ),
      headlineMedium: GoogleFonts.lato(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.darkTextPrimary,
      ),
      titleLarge: GoogleFonts.lato(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.darkTextPrimary,
      ),
      titleMedium: GoogleFonts.lato(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.darkTextPrimary,
      ),
      bodyLarge: GoogleFonts.lato(
        fontSize: 16,
        color: AppColors.darkTextPrimary,
      ),
      bodyMedium: GoogleFonts.lato(
        fontSize: 14,
        color: AppColors.darkTextSecondary,
      ),
      bodySmall: GoogleFonts.lato(
        fontSize: 12,
        color: AppColors.darkTextSecondary,
      ),
    ),

    // Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.brandGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        textStyle: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),

    // Outlined Button
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.brandGreen,
        side: const BorderSide(color: AppColors.brandGreen, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        textStyle: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),

    // Text Button
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.brandGreen,
        textStyle: GoogleFonts.lato(fontSize: 13, fontWeight: FontWeight.w500),
      ),
    ),

    // Input Decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkSurface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.darkDivider),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.darkDivider),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.brandGreen, width: 2),
      ),
      labelStyle: GoogleFonts.lato(color: AppColors.darkTextSecondary),
      hintStyle: GoogleFonts.lato(color: AppColors.darkTextSecondary),
    ),

    // Radio
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.brandGreen;
        return AppColors.darkTextSecondary;
      }),
    ),
  );
}
