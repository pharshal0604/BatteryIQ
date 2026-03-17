import 'package:ev_fleet_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ═══════════════════════════════════════════════
// STRESS BADGE — driving stress level chip
// Used on: Vehicle List tile + Vehicle Detail screen
// Input:   level string → 'LOW' | 'MEDIUM' | 'HIGH'
// ═══════════════════════════════════════════════

class StressBadge extends StatelessWidget {
  final String level; // 'LOW' | 'MEDIUM' | 'HIGH'
  final BadgeSize size;
  final bool showIcon;

  const StressBadge({
    super.key,
    required this.level,
    this.size = BadgeSize.medium,
    this.showIcon = true,
  });

  // ── Derived properties ────────────────────────

  String get _label =>
      level.isNotEmpty
          ? level[0].toUpperCase() + level.substring(1).toLowerCase()
          : 'Unknown';

  Color get _color => AppColors.fromStress(level);


  IconData get _icon => AppColors.iconFromStress(level);

  // ── Size tokens ───────────────────────────────

  double get _fontSize => switch (size) {
        BadgeSize.small  => 10,
        BadgeSize.medium => 11,
        BadgeSize.large  => 13,
      };

  double get _iconSize => switch (size) {
        BadgeSize.small  => 10,
        BadgeSize.medium => 12,
        BadgeSize.large  => 14,
      };

  EdgeInsets get _padding => switch (size) {
        BadgeSize.small  => const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        BadgeSize.medium => const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        BadgeSize.large  => const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      };

  @override
  Widget build(BuildContext context) {
    final bgColor = AppColors.bgFromStress(level);
    final color   = AppColors.fromStress(level);
    final icon    = AppColors.iconFromStress(level);

    return Container(
      padding: _padding,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withValues(alpha: 0.35),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) ...[
            Icon(icon, size: _iconSize, color: color),
            const SizedBox(width: 4),
          ],
          Text(
            _label,
            style: GoogleFonts.lato(
              fontSize: _fontSize,
              fontWeight: FontWeight.w700,
              color: color,
              letterSpacing: 0.3,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// BADGE SIZE ENUM
// ═══════════════════════════════════════════════

enum BadgeSize { small, medium, large }

// ═══════════════════════════════════════════════
// STRESS LEVEL ROW — icon + label + badge
// Used on Vehicle Detail driving stress section
// ═══════════════════════════════════════════════

class StressLevelRow extends StatelessWidget {
  final String level; // 'LOW' | 'MEDIUM' | 'HIGH'
  final String description; // e.g. 'Your driving impact'

  const StressLevelRow({
    super.key,
    required this.level,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Description
        Expanded(
          child: Text(
            description,
            style: GoogleFonts.lato(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Badge
        StressBadge(
          level: level,
          size:  BadgeSize.large,
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════
// STRESS INSIGHT TILE — single bullet point
// Used in Vehicle Detail → Driving Stress section
// ═══════════════════════════════════════════════

class StressInsightTile extends StatelessWidget {
  final String message;
  final bool isAboveAverage; // true → warning color, false → ok color

  const StressInsightTile({
    super.key,
    required this.message,
    this.isAboveAverage = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isAboveAverage ? AppColors.warning : AppColors.success;
    final icon  = isAboveAverage
        ? Icons.arrow_upward_rounded
        : Icons.check_rounded;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bullet icon
          Container(
            margin: const EdgeInsets.only(top: 2),
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 10, color: color),
          ),
          const SizedBox(width: 10),

          // Message
          Expanded(
            child: Text(
              message,
              style: GoogleFonts.lato(
                fontSize: 13,
                height: 1.5,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
