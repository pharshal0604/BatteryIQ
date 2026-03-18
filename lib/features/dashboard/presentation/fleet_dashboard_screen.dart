import 'package:ev_fleet_app/core/router/app_router.dart';
import 'package:ev_fleet_app/core/theme/app_colors.dart';
import 'package:ev_fleet_app/core/widgets/app_bar_title.dart';
import 'package:ev_fleet_app/core/widgets/app_drawer.dart';
import 'package:ev_fleet_app/core/widgets/empty_state_widget.dart';
import 'package:ev_fleet_app/core/widgets/error_retry_widget.dart';
import 'package:ev_fleet_app/core/widgets/loading_shimmer.dart';
import 'package:ev_fleet_app/core/widgets/soh_circle.dart';
import 'package:ev_fleet_app/core/widgets/stat_card.dart';
import 'package:ev_fleet_app/features/fleet/models/fleet_summary_model.dart';
import 'package:ev_fleet_app/features/fleet/models/vehicle_item_model.dart';
import 'package:ev_fleet_app/features/fleet/providers/fleet_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class FleetDashboardScreen extends ConsumerWidget {
  const FleetDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(fleetSummaryProvider);
    final vehiclesAsync = ref.watch(vehicleListProvider);

    return Scaffold(
      appBar: _buildAppBar(context, ref, summaryAsync),
      drawer: AppDrawer(
        roleBadgeLabel: 'Fleet Supervisor',
        items: _drawerItems(context, ref),
      ),
      body: RefreshIndicator(
        color: AppColors.brandGreen,
        onRefresh: () async {
          await ref.read(fleetSummaryProvider.notifier).refresh();
          await ref.read(vehicleListProvider.notifier).refresh();
        },
        child: summaryAsync.when(
          loading: () => const DashboardShimmer(),
          error: (e, _) => FleetLoadErrorWidget(
            onRetry: () => ref.refresh(fleetSummaryProvider),
          ),
          data: (summary) => CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // ── Fleet Status Banner ──────────────────
              SliverToBoxAdapter(
                child: _FleetStatusBanner(
                  status: summary.fleetStatus,
                  hasCritical: summary.hasCritical,
                ),
              ),

              // ── Stat Cards Row ───────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: FleetStatRow(
                    healthyCount: summary.healthy,
                    attentionCount: summary.attention,
                    criticalCount: summary.critical,
                    onHealthyTap: () =>
                        context.pushVehicleList(filter: 'HEALTHY'),
                    onAttentionTap: () =>
                        context.pushVehicleList(filter: 'ATTENTION'),
                    onCriticalTap: () =>
                        context.pushVehicleList(filter: 'CRITICAL'),
                  ),
                ),
              ),

              // ── Section Header ───────────────────────
              SliverToBoxAdapter(
                child: _SectionHeader(
                  title: 'Fleet Overview',
                  actionLabel: 'View All',
                  onAction: () => context.pushVehicleList(),
                ),
              ),

              // ── Vehicle List ─────────────────────────
              vehiclesAsync.when(
                loading: () => const SliverToBoxAdapter(
                  child: VehicleListShimmer(),
                ),
                error: (e, _) => SliverToBoxAdapter(
                  child: ErrorRetryWidget(
                    message: e.toString(),
                    onRetry: () => ref.refresh(vehicleListProvider),
                    size: ErrorSize.card,
                  ),
                ),
                data: (vehicles) {
                  if (vehicles.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: NoVehiclesRegistered(),
                    );
                  }

                  final preview = vehicles.take(5).toList();

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => _VehicleTile(
                        vehicle: preview[index],
                        onTap: () =>
                            context.pushVehicleDetail(preview[index].vehicleId),
                      ),
                      childCount: preview.length,
                    ),
                  );
                },
              ),

              // ── View All Button ──────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                  child: OutlinedButton.icon(
                    onPressed: () => context.pushVehicleList(),
                    icon: const Icon(Icons.electric_car_outlined, size: 18),
                    label: Text(
                      'View All Vehicles',
                      style: GoogleFonts.lato(fontWeight: FontWeight.w600),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: BorderSide(
                        color: AppColors.brandGreen.withValues(alpha: 0.5),
                      ),
                      foregroundColor: AppColors.brandGreen,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================================
  // APP BAR
  // ==========================================================================

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<dynamic> summaryAsync, // ✅ typed as AsyncValue<dynamic>
  ) {
    return AppBar(
      title: AppBarTitle(
        title: 'Fleet Health',
        subtitle: summaryAsync.value != null
            ? '${summaryAsync.value!.total} vehicles total'
            : null,
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () => context.pushAlerts(),
          tooltip: 'Alerts',
        ),
        // IconButton(
        //   icon: const Icon(Icons.settings_outlined),
        //   onPressed: () => context.pushNamed('settings'),
        //   tooltip: 'Settings',
        // ),
        const SizedBox(width: 6),
      ],
    );
  }

  // ==========================================================================
  // DRAWER ITEMS
  // ==========================================================================

  List<DrawerItem> _drawerItems(BuildContext context, WidgetRef ref) => [
        DrawerItem(
          icon: Icons.dashboard_outlined,
          title: 'Fleet Dashboard',
          isSelected: true,
          onTap: () {}, // drawer closes itself, nothing else needed
        ),
        DrawerItem(
          icon: Icons.check_circle_outline,
          title: 'Healthy',
          trailing: DrawerBadge(
            '${ref.read(fleetSummaryProvider).value?.healthy ?? 0}',
            color: AppColors.success,
          ),
          onTap: () => context.pushVehicleList(filter: 'HEALTHY'),
        ),
        DrawerItem(
          icon: Icons.warning_amber_outlined,
          title: 'Needs Attention',
          trailing: DrawerBadge(
            '${ref.read(fleetSummaryProvider).value?.attention ?? 0}',
            color: AppColors.warning,
          ),
          onTap: () => context.pushVehicleList(filter: 'ATTENTION'),
        ),
        DrawerItem(
          icon: Icons.error_outline,
          title: 'Critical',
          trailing: DrawerBadge(
            '${ref.read(fleetSummaryProvider).value?.critical ?? 0}',
            color: AppColors.error,
          ),
          onTap: () => context.pushVehicleList(filter: 'CRITICAL'),
        ),
        ...AppDrawer.commonItems(context),
      ];
}

// ═══════════════════════════════════════════════
// FLEET STATUS BANNER
// ═══════════════════════════════════════════════

class _FleetStatusBanner extends StatelessWidget {
  final String status;
  final bool hasCritical;

  const _FleetStatusBanner({
    required this.status,
    required this.hasCritical,
  });

  @override
  Widget build(BuildContext context) {
    final color = hasCritical ? AppColors.error : AppColors.success;
    final icon =
        hasCritical ? Icons.warning_amber_rounded : Icons.check_circle_rounded;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              status,
              style: GoogleFonts.lato(
                fontSize: 13,
                fontWeight: FontWeight.w600,
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
// SECTION HEADER
// ═══════════════════════════════════════════════

class _SectionHeader extends StatelessWidget {
  final String title;
  final String actionLabel;
  final VoidCallback onAction;

  const _SectionHeader({
    required this.title,
    required this.actionLabel,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 8, 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          TextButton(
            onPressed: onAction,
            child: Text(
              actionLabel,
              style: GoogleFonts.lato(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.brandGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// VEHICLE TILE
// ═══════════════════════════════════════════════

class _VehicleTile extends StatelessWidget {
  final VehicleItemModel vehicle;
  final VoidCallback onTap;

  const _VehicleTile({required this.vehicle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Material(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Theme.of(context).dividerColor),
            ),
            child: Row(
              children: [
                // SoH Circle
                SoHCircleSmall(soh: vehicle.soh),
                const SizedBox(width: 14),

                // Vehicle Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vehicle.vehicleId,
                        style: GoogleFonts.lato(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        vehicle.rulDisplay,
                        style: GoogleFonts.lato(
                          fontSize: 12,
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                      ),
                    ],
                  ),
                ),

                // Chevron
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
