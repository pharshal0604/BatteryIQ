import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  /* ═══════════════ BRAND ═══════════════ */
  static const Color brandGreen = Color(0xFF6DBB63);

  /* ═══════════════ LIGHT MODE ═══════════════ */
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFF7F7F7);
  static const Color lightTextPrimary = Color(0xFF1C1F26);
  static const Color lightTextSecondary = Color(0xFF6B7280);
  static const Color lightDivider = Color(0xFFE5E7EB);
  static const Color lightIcon = Color(0xFF6DBB63);

  /* ═══════════════ DARK MODE ═══════════════ */
  static const Color darkBackground = Color(0xFF0F1216);
  static const Color darkSurface = Color(0xFF151A20);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFF9CA3AF);
  static const Color darkDivider = Color(0xFF1F2933);
  static const Color darkIcon = Color(0xFF6DBB63);

  /* ═══════════════ STATUS ═══════════════ */
  static const Color success = Color(0xFF22C55E);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);

  // Background tints — Light
  static const Color successBgLight = Color(0xFFDCFCE7);
  static const Color errorBgLight = Color(0xFFFFE4E6);
  static const Color warningBgLight = Color(0xFFFEF3C7);

  // Background tints — Dark
  static const Color successBgDark = Color(0xFF052E16);
  static const Color errorBgDark = Color(0xFF2D0A0A);
  static const Color warningBgDark = Color(0xFF2D1F00);

  /* ═══════════════ CHART ═══════════════ */
  static const Color chartLine = Color(0xFF6DBB63);
  static const Color chartFill = Color(0x266DBB63);
  static const Color chartDot = Color(0xFF4CAF50);
  static const Color chartGrid = Color(0xFF1F2933);

  /* ═══════════════ REGEN ═══════════════ */
  static const Color regenUsed = Color(0xFFEF4444);
  static const Color regenSaved = Color(0xFF22C55E);

  /* ═══════════════ HELPERS ═══════════════ */

  static Color fromSoH(double soh) {
    if (soh >= 85) return success;
    if (soh >= 70) return warning;
    return error;
  }

  static Color bgFromSoH(double soh) {
    if (soh >= 85) return successBgLight;
    if (soh >= 70) return warningBgLight;
    return errorBgLight;
  }

  static String statusFromSoH(double soh) {
    if (soh >= 85) return 'Good';
    if (soh >= 70) return 'Monitor';
    return 'Critical';
  }

  static IconData iconFromSoH(double soh) {
    if (soh >= 85) return Icons.check_circle_rounded;
    if (soh >= 70) return Icons.warning_amber_rounded;
    return Icons.error_rounded;
  }

  static Color fromStress(String level) {
    switch (level.toUpperCase()) {
      case 'LOW':
        return success;
      case 'MEDIUM':
        return warning;
      case 'HIGH':
        return error;
      default:
        return warning;
    }
  }

  static Color fromStatus(String status) {
    switch (status.toUpperCase()) {
      case 'HEALTHY':
        return success;
      case 'ATTENTION':
        return warning;
      case 'CRITICAL':
        return error;
      default:
        return warning;
    }
  }

  static Color bgFromStress(String level) {
    switch (level.toUpperCase()) {
      case 'LOW':
        return successBgLight;
      case 'MEDIUM':
        return warningBgLight;
      case 'HIGH':
        return errorBgLight;
      default:
        return warningBgLight;
    }
  }

  static IconData iconFromStress(String level) {
    switch (level.toUpperCase()) {
      case 'LOW':
        return Icons.thumb_up_rounded;
      case 'MEDIUM':
        return Icons.warning_amber_rounded;
      case 'HIGH':
        return Icons.local_fire_department_rounded;
      default:
        return Icons.info_rounded;
    }
  }
}
