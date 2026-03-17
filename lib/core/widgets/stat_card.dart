import 'package:ev_fleet_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ═══════════════════════════════════════════════
// STAT CARD — Fleet Dashboard Summary Cards
// Shows count + label + optional subtitle
// Tappable → navigates to filtered vehicle list
// ═══════════════════════════════════════════════

class StatCard extends StatelessWidget {
  final String label;
  final int count;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;
  final String? subtitle; // optional e.g. "2 new since yesterday"

  const StatCard({
    super.key,
    required this.label,
    required this.count,
    required this.color,
    required this.icon,
    required this.onTap,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: color.withValues(alpha: 0.25),
              width: 1.2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Icon ──────────────────────────────────
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 18),
              ),

              const SizedBox(height: 14),

              // ── Count ─────────────────────────────────
              Text(
                '$count',
                style: GoogleFonts.lato(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: color,
                  height: 1.0,
                ),
              ),

              const SizedBox(height: 4),

              // ── Label ─────────────────────────────────
              Text(
                label,
                style: GoogleFonts.lato(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              // ── Subtitle — optional ───────────────────
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle!,
                  style: GoogleFonts.lato(
                    fontSize: 10,
                    color: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.color
                        ?.withValues(alpha: 0.6),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],

              const SizedBox(height: 8),

              // ── Tap hint ──────────────────────────────
              Row(
                children: [
                  Text(
                    'View all',
                    style: GoogleFonts.lato(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 11,
                    color: color,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// PRESET STAT CARDS — fleet-specific, drop-in ready
// ═══════════════════════════════════════════════

class HealthyStatCard extends StatelessWidget {
  final int count;
  final VoidCallback onTap;
  final String? subtitle;

  const HealthyStatCard({
    super.key,
    required this.count,
    required this.onTap,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return StatCard(
      label: 'Healthy',
      count: count,
      color: AppColors.success,
      icon: Icons.check_circle_rounded,
      onTap: onTap,
      subtitle: subtitle,
    );
  }
}

class AttentionStatCard extends StatelessWidget {
  final int count;
  final VoidCallback onTap;
  final String? subtitle;

  const AttentionStatCard({
    super.key,
    required this.count,
    required this.onTap,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return StatCard(
      label: 'Attention',
      count: count,
      color: AppColors.warning,
      icon: Icons.warning_amber_rounded,
      onTap: onTap,
      subtitle: subtitle,
    );
  }
}

class CriticalStatCard extends StatelessWidget {
  final int count;
  final VoidCallback onTap;
  final String? subtitle;

  const CriticalStatCard({
    super.key,
    required this.count,
    required this.onTap,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return StatCard(
      label: 'Critical',
      count: count,
      color: AppColors.error,
      icon: Icons.error_rounded,
      onTap: onTap,
      subtitle: subtitle,
    );
  }
}

// ═══════════════════════════════════════════════
// STAT CARD ROW — wraps all 3 cards in one line
// Drop directly into Dashboard screen body
// ═══════════════════════════════════════════════

class FleetStatRow extends StatelessWidget {
  final int healthyCount;
  final int attentionCount;
  final int criticalCount;
  final VoidCallback onHealthyTap;
  final VoidCallback onAttentionTap;
  final VoidCallback onCriticalTap;

  const FleetStatRow({
    super.key,
    required this.healthyCount,
    required this.attentionCount,
    required this.criticalCount,
    required this.onHealthyTap,
    required this.onAttentionTap,
    required this.onCriticalTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HealthyStatCard(
            count: healthyCount,
            onTap: onHealthyTap,
          ),
          const SizedBox(width: 10),
          AttentionStatCard(
            count: attentionCount,
            onTap: onAttentionTap,
          ),
          const SizedBox(width: 10),
          CriticalStatCard(
            count: criticalCount,
            onTap: onCriticalTap,
          ),
        ],
      ),
    );
  }
}
