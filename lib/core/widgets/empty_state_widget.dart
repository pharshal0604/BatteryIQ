import 'package:ev_fleet_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ═══════════════════════════════════════════════
// EMPTY STATE WIDGET — shown when list has no data
// Used on: Vehicle List (no results / no vehicles)
// Variants: full page, inline
// ═══════════════════════════════════════════════

class EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;    // optional CTA button label
  final VoidCallback? onAction; // optional CTA callback
  final EmptySize size;

  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
    this.size = EmptySize.full,
  });

  @override
  Widget build(BuildContext context) {
    return switch (size) {
      EmptySize.full   => _FullEmpty(
          icon:        icon,
          title:       title,
          message:     message,
          actionLabel: actionLabel,
          onAction:    onAction,
        ),
      EmptySize.inline => _InlineEmpty(
          icon:    icon,
          title:   title,
          message: message,
        ),
    };
  }
}

// ═══════════════════════════════════════════════
// EMPTY SIZE ENUM
// ═══════════════════════════════════════════════

enum EmptySize { full, inline }

// ═══════════════════════════════════════════════
// FULL PAGE EMPTY
// ═══════════════════════════════════════════════

class _FullEmpty extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  const _FullEmpty({
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Icon ──────────────────────────────
            Container(
              width:  88,
              height: 88,
              decoration: BoxDecoration(
                color:        AppColors.brandGreen.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(
                icon,
                size:  42,
                color: AppColors.brandGreen,
              ),
            ),
            const SizedBox(height: 20),

            // ── Title ─────────────────────────────
            Text(
              title,
              style: GoogleFonts.lato(
                fontSize:   18,
                fontWeight: FontWeight.bold,
                color:      Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // ── Message ───────────────────────────
            Text(
              message,
              style: GoogleFonts.lato(
                fontSize: 14,
                height:   1.6,
                color:    Theme.of(context).textTheme.bodySmall?.color,
              ),
              textAlign: TextAlign.center,
            ),

            // ── CTA Button — optional ─────────────
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 28),
              SizedBox(
                width: 180,
                child: ElevatedButton(
                  onPressed: onAction,
                  child: Text(
                    actionLabel!,
                    style: GoogleFonts.lato(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// INLINE EMPTY — inside a card or section
// ═══════════════════════════════════════════════

class _InlineEmpty extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;

  const _InlineEmpty({
    required this.icon,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Row(
        children: [
          Icon(
            icon,
            size:  32,
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.lato(
                    fontSize:   14,
                    fontWeight: FontWeight.w600,
                    color:      Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  message,
                  style: GoogleFonts.lato(
                    fontSize: 12,
                    height:   1.5,
                    color:    Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// PRESET EMPTY STATES — fleet-specific, drop-in
// ═══════════════════════════════════════════════

/// No vehicles found after search/filter
class NoVehiclesFound extends StatelessWidget {
  final VoidCallback onClearFilter;

  const NoVehiclesFound({super.key, required this.onClearFilter});

  @override
  Widget build(BuildContext context) {
    return EmptyStateWidget(
      icon:        Icons.search_off_rounded,
      title:       'No Vehicles Found',
      message:     'No vehicles match your current filter or search. Try a different status or clear the search.',
      actionLabel: 'Clear Filter',
      onAction:    onClearFilter,
    );
  }
}

/// Fleet has zero vehicles registered
class NoVehiclesRegistered extends StatelessWidget {
  const NoVehiclesRegistered({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyStateWidget(
      icon:    Icons.electric_car_outlined,
      title:   'No Vehicles Yet',
      message: 'No vehicles are registered in this fleet. Contact your fleet administrator.',
    );
  }
}

/// No alerts for this vehicle
class NoAlertsFound extends StatelessWidget {
  const NoAlertsFound({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyStateWidget(
      icon:    Icons.notifications_off_outlined,
      title:   'No Alerts',
      message: 'This vehicle has no active alerts.',
      size:    EmptySize.inline,
    );
  }
}

/// No trend data available
class NoTrendData extends StatelessWidget {
  const NoTrendData({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyStateWidget(
      icon:    Icons.show_chart_rounded,
      title:   'No Trend Data',
      message: 'Not enough data yet to show degradation trend.',
      size:    EmptySize.inline,
    );
  }
}
