import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  /* ═══════════════════ DISPLAY ═══════════════════ */

  static const TextStyle displayLarge = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w800,
    color: AppColors.lightTextPrimary,
    letterSpacing: -1.5,
    height: 1.1,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: AppColors.lightTextPrimary,
    letterSpacing: -1.0,
    height: 1.2,
  );

  /* ═══════════════════ HEADING ═══════════════════ */

  static const TextStyle heading = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.lightTextPrimary,
    letterSpacing: -0.3,
  );

  static const TextStyle subheading = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: AppColors.lightTextPrimary,
    letterSpacing: -0.1,
  );

  /* ═══════════════════ CARD / TILE ═══════════════════ */

  static const TextStyle cardTitle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.lightTextPrimary,
    letterSpacing: 0.1,
  );

  static const TextStyle cardSubtitle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.lightTextSecondary,
    height: 1.4,
  );

  /* ═══════════════════ BODY ═══════════════════ */

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.lightTextPrimary,
    height: 1.6,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.lightTextPrimary,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.lightTextSecondary,
    height: 1.4,
  );

  /* ═══════════════════ METRIC (SoH, RUL) ═══════════════════ */

  static const TextStyle metricHero = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w800,
    color: AppColors.lightTextPrimary,
    letterSpacing: -1.5,
    height: 1.0,
  );

  static const TextStyle metricLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.lightTextPrimary,
    letterSpacing: -0.8,
  );

  static const TextStyle metricMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.lightTextPrimary,
    letterSpacing: -0.4,
  );

  static const TextStyle metricUnit = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.lightTextSecondary,
    letterSpacing: 0.5,
  );

  /* ═══════════════════ LABEL / BADGE ═══════════════════ */

  static const TextStyle label = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.lightTextSecondary,
    letterSpacing: 0.6,
  );

  static const TextStyle badgeText = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
    height: 1.0,
  );

  /* ═══════════════════ APPBAR ═══════════════════ */

  static const TextStyle appBarTitle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: AppColors.darkTextPrimary,
    letterSpacing: 0.1,
  );

  /* ═══════════════════ STAT CARD ═══════════════════ */

  static const TextStyle statCount = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    letterSpacing: -1.0,
    height: 1.1,
  );

  static const TextStyle statLabel = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.lightTextSecondary,
    letterSpacing: 0.4,
  );

  /* ═══════════════════ FILTER CHIP ═══════════════════ */

  static const TextStyle chipLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
  );
}
