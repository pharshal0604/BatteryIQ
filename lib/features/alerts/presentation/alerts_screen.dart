import 'package:ev_fleet_app/core/router/app_router.dart';
import 'package:ev_fleet_app/core/theme/app_colors.dart';
import 'package:ev_fleet_app/core/widgets/app_bar_title.dart';
import 'package:ev_fleet_app/core/widgets/empty_state_widget.dart';
import 'package:ev_fleet_app/core/widgets/error_retry_widget.dart';
import 'package:ev_fleet_app/features/alerts/models/alert_model.dart';
import 'package:ev_fleet_app/features/alerts/providers/alerts_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class AlertsScreen extends ConsumerWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alertsAsync = ref.watch(alertsProvider);
    final severity = ref.watch(alertSeverityFilterProvider);

    return Scaffold(
      appBar: _buildAppBar(context, ref, alertsAsync),
      body: Column(
        children: [
          // ── Severity Filter Chips ─────────────────
          _SeverityFilterBar(selected: severity),

          // ── Alert List ────────────────────────────
          Expanded(
            child: RefreshIndicator(
              color: AppColors.brandGreen,
              onRefresh: () => ref.read(alertsProvider.notifier).refresh(),
              child: alertsAsync.when(
                loading: () => const _AlertsShimmer(),
                error: (e, _) => ErrorRetryWidget(
                  message: e.toString(),
                  onRetry: () => ref.read(alertsProvider.notifier).refresh(),
                ),
                data: (alerts) {
                  if (alerts.isEmpty) return const NoAlertsFound();
                  return _AlertList(alerts: alerts);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================================
  // APP BAR
  // ==========================================================================

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<List<AlertModel>> alertsAsync,
  ) {
    final criticalCount = ref.watch(criticalAlertCountProvider);

    return AppBar(
      title: AppBarTitle(
        title: 'Alerts',
        subtitle: alertsAsync.value != null
            ? '${alertsAsync.value!.length} active alert${alertsAsync.value!.length == 1 ? '' : 's'}'
            : null,
      ),
      actions: [
        if (criticalCount > 0)
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$criticalCount Critical',
                  style: GoogleFonts.lato(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════
// SEVERITY FILTER BAR — All / Warning / Critical chips
// ═══════════════════════════════════════════════

class _SeverityFilterBar extends ConsumerWidget {
  final String selected;

  const _SeverityFilterBar({required this.selected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: Row(
        children: [
          _SeverityChip(
            label: 'All',
            value: 'ALL',
            selected: selected,
            color: AppColors.brandGreen,
          ),
          const SizedBox(width: 8),
          _SeverityChip(
            label: 'Warning',
            value: 'WARNING',
            selected: selected,
            color: AppColors.warning,
            icon: Icons.warning_amber_rounded,
          ),
          const SizedBox(width: 8),
          _SeverityChip(
            label: 'Critical',
            value: 'CRITICAL',
            selected: selected,
            color: AppColors.error,
            icon: Icons.bolt_rounded,
          ),
        ],
      ),
    );
  }
}

class _SeverityChip extends ConsumerWidget {
  final String label;
  final String value;
  final String selected;
  final Color color;
  final IconData? icon;

  const _SeverityChip({
    required this.label,
    required this.value,
    required this.selected,
    required this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = selected == value;

    return GestureDetector(
      onTap: () => ref.read(alertSeverityFilterProvider.notifier).state = value,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color : color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? color : color.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 14,
                color: isSelected ? Colors.white : color,
              ),
              const SizedBox(width: 5),
            ],
            Text(
              label,
              style: GoogleFonts.lato(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// ALERT LIST — grouped Critical → Warning
// ═══════════════════════════════════════════════

class _AlertList extends StatelessWidget {
  final List<AlertModel> alerts;

  const _AlertList({required this.alerts});

  @override
  Widget build(BuildContext context) {
    final criticals = alerts.where((a) => a.isCritical).toList();
    final warnings = alerts.where((a) => a.isWarning).toList();

    return ListView(
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      children: [
        // ── Critical Group ───────────────────────
        if (criticals.isNotEmpty) ...[
          _GroupHeader(
            label: 'Critical',
            count: criticals.length,
            color: AppColors.error,
            icon: Icons.bolt_rounded,
          ),
          ...criticals.map((a) => _AlertTile(alert: a)),
        ],

        // ── Warning Group ────────────────────────
        if (warnings.isNotEmpty) ...[
          _GroupHeader(
            label: 'Warning',
            count: warnings.length,
            color: AppColors.warning,
            icon: Icons.warning_amber_rounded,
          ),
          ...warnings.map((a) => _AlertTile(alert: a)),
        ],
      ],
    );
  }
}

// ═══════════════════════════════════════════════
// GROUP HEADER — "Critical  ·  2"
// ═══════════════════════════════════════════════

class _GroupHeader extends StatelessWidget {
  final String label;
  final int count;
  final Color color;
  final IconData icon;

  const _GroupHeader({
    required this.label,
    required this.count,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
      child: Row(
        children: [
          Icon(icon, size: 15, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.lato(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '$count',
              style: GoogleFonts.lato(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// ALERT TILE
// ═══════════════════════════════════════════════

class _AlertTile extends StatelessWidget {
  final AlertModel alert;

  const _AlertTile({required this.alert});

  @override
  Widget build(BuildContext context) {
    final color = alert.isCritical ? AppColors.error : AppColors.warning;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Material(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: () => context.pushVehicleDetail(alert.vehicleId),
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: color.withValues(alpha: 0.25),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Severity Icon ────────────────────
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(alert.typeIcon, size: 18, color: color),
                ),
                const SizedBox(width: 12),

                // ── Content ──────────────────────────
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row 1: Vehicle ID + type badge
                      Row(
                        children: [
                          Text(
                            alert.vehicleId,
                            style: GoogleFonts.lato(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(width: 8),
                          _TypeBadge(
                            label: alert.typeLabel,
                            color: color,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),

                      // Row 2: Message
                      Text(
                        alert.message,
                        style: GoogleFonts.lato(
                          fontSize: 13,
                          height: 1.4,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Row 3: Timestamp
                      Text(
                        alert.timeAgo,
                        style: GoogleFonts.lato(
                          fontSize: 11,
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Chevron ──────────────────────────
                const SizedBox(width: 8),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 20,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// TYPE BADGE — small pill e.g. "Battery Health"
// ═══════════════════════════════════════════════

class _TypeBadge extends StatelessWidget {
  final String label;
  final Color color;

  const _TypeBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Text(
        label,
        style: GoogleFonts.lato(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// SHIMMER — loading skeleton
// ═══════════════════════════════════════════════

class _AlertsShimmer extends StatelessWidget {
  const _AlertsShimmer();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: 5,
      itemBuilder: (context, _) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Container(
          height: 88,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Theme.of(context).dividerColor),
          ),
        ),
      ),
    );
  }
}
