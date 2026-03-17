import 'package:ev_fleet_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ═══════════════════════════════════════════════
// SECTION CARD — wraps every section on detail screen
// Used on: Vehicle Detail (Health, Trend, Stress, Regen)
// Also reusable on Dashboard for any grouped content
// ═══════════════════════════════════════════════

class SectionCard extends StatelessWidget {
  final String title;
  final IconData titleIcon;
  final Widget child;
  final Widget? trailing;       // optional top-right widget (dropdown, badge)
  final EdgeInsets? padding;    // override inner padding
  final bool showDivider;       // divider between header and content

  const SectionCard({
    super.key,
    required this.title,
    required this.titleIcon,
    required this.child,
    this.trailing,
    this.padding,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color:        Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Section Header ───────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
            child: Row(
              children: [
                // Icon
                Container(
                  padding:      const EdgeInsets.all(7),
                  decoration:   BoxDecoration(
                    color:        AppColors.brandGreen.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    titleIcon,
                    size:  16,
                    color: AppColors.brandGreen,
                  ),
                ),
                const SizedBox(width: 10),

                // Title
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.lato(
                      fontSize:   15,
                      fontWeight: FontWeight.w600,
                      color:      Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),

                // Trailing — optional
                if (trailing != null) trailing!,
              ],
            ),
          ),

          // ── Divider ──────────────────────────────
          if (showDivider)
            Divider(
              height:  1,
              color:   Theme.of(context).dividerColor,
            ),

          // ── Content ──────────────────────────────
          Padding(
            padding: padding ?? const EdgeInsets.all(16),
            child:   child,
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// PRESET SECTION CARDS — for vehicle detail screen
// ═══════════════════════════════════════════════

/// Health & RUL section
class HealthSectionCard extends StatelessWidget {
  final Widget child;
  final Widget? trailing;

  const HealthSectionCard({
    super.key,
    required this.child,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title:     'Health & RUL',
      titleIcon: Icons.battery_charging_full_rounded,
      trailing:  trailing,
      child:     child,
    );
  }
}

/// Degradation Trend section
class TrendSectionCard extends StatelessWidget {
  final Widget child;
  final Widget? trailing;     // TrendRangeDropdown goes here

  const TrendSectionCard({
    super.key,
    required this.child,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title:     'Degradation Trend',
      titleIcon: Icons.show_chart_rounded,
      trailing:  trailing,
      padding:   const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child:     child,
    );
  }
}

/// Driving Stress section
class StressSectionCard extends StatelessWidget {
  final Widget child;

  const StressSectionCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title:     'Driving Stress',
      titleIcon: Icons.speed_rounded,
      child:     child,
    );
  }
}

/// Regeneration Stats section
class RegenSectionCard extends StatelessWidget {
  final Widget child;

  const RegenSectionCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title:     'Regeneration',
      titleIcon: Icons.bolt_rounded,
      child:     child,
    );
  }
}
