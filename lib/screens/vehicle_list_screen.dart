import 'package:ev_fleet_app/core/router/app_router.dart';
import 'package:ev_fleet_app/core/theme/app_colors.dart';
import 'package:ev_fleet_app/core/widgets/app_drawer.dart';
import 'package:ev_fleet_app/core/widgets/app_dropdown.dart';
import 'package:ev_fleet_app/core/widgets/app_input_decoration.dart';
import 'package:ev_fleet_app/core/widgets/empty_state_widget.dart';
import 'package:ev_fleet_app/core/widgets/error_retry_widget.dart';
import 'package:ev_fleet_app/core/widgets/loading_shimmer.dart';
import 'package:ev_fleet_app/core/widgets/soh_circle.dart';
import 'package:ev_fleet_app/core/widgets/stress_badge.dart';
import 'package:ev_fleet_app/features/fleet/models/vehicle_item_model.dart';
import 'package:ev_fleet_app/features/fleet/providers/fleet_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class VehicleListScreen extends ConsumerStatefulWidget {
  final String initialFilter;
  final String initialStress;
  final String initialSearch;

  const VehicleListScreen({
    super.key,
    this.initialFilter = 'ALL',
    this.initialStress = 'ALL',
    this.initialSearch = '',
  });

  @override
  ConsumerState<VehicleListScreen> createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends ConsumerState<VehicleListScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialSearch);

    // Apply initial filters from router params
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(statusFilterProvider.notifier).state = widget.initialFilter;
      ref.read(stressFilterProvider.notifier).state = widget.initialStress;
      ref.read(searchQueryProvider.notifier).state  = widget.initialSearch;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vehiclesAsync   = ref.watch(vehicleListProvider);
    final selectedStatus  = ref.watch(statusFilterProvider);
    final selectedStress  = ref.watch(stressFilterProvider);

    return Scaffold(
      appBar: _buildAppBar(context, vehiclesAsync),
      drawer: AppDrawer(
        roleBadgeLabel: 'Fleet Supervisor',
        items: _drawerItems(context),
      ),
      body: Column(
        children: [
          // ── Search + Filters ──────────────────────
          _FilterBar(
            searchController: _searchController,
            selectedStatus:   selectedStatus,
            selectedStress:   selectedStress,
            onSearchChanged: (val) =>
                ref.read(searchQueryProvider.notifier).state = val,
            onSearchCleared: () {
              _searchController.clear();
              ref.read(searchQueryProvider.notifier).state = '';
            },
            onStatusChanged: (val) =>
                ref.read(statusFilterProvider.notifier).state = val ?? 'ALL',
            onStressChanged: (val) =>
                ref.read(stressFilterProvider.notifier).state = val ?? 'ALL',
          ),

          // ── Vehicle List ──────────────────────────
          Expanded(
            child: RefreshIndicator(
              color: AppColors.brandGreen,
              onRefresh: () =>
                  ref.read(vehicleListProvider.notifier).refresh(),
              child: vehiclesAsync.when(
                loading: () => const VehicleListShimmer(),
                error: (e, _) => FleetLoadErrorWidget(
                  onRetry: () => ref.refresh(vehicleListProvider),
                ),
                data: (vehicles) {
                  if (vehicles.isEmpty) {
                    return NoVehiclesFound(
                      onClearFilter: _clearAllFilters,
                    );
                  }
                  return _VehicleList(vehicles: vehicles);
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
    AsyncValue<List<VehicleItemModel>> vehiclesAsync,
  ) {
    final count = vehiclesAsync.value?.length ?? 0;

    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'All Vehicles',
            style: GoogleFonts.lato(
              fontSize:   18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (count > 0)
            Text(
              '$count vehicles',
              style: GoogleFonts.lato(
                fontSize: 12,
                color: Theme.of(context)
                    .appBarTheme
                    .foregroundColor
                    ?.withValues(alpha: 0.7),
              ),
            ),
        ],
      ),
      actions: [
        // Clear filters button — only shown when filter is active
        if (_hasActiveFilters())
          TextButton.icon(
            onPressed: _clearAllFilters,
            icon: const Icon(Icons.filter_alt_off_rounded, size: 16),
            label: Text(
              'Clear',
              style: GoogleFonts.lato(fontWeight: FontWeight.w600),
            ),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.brandGreen,
            ),
          ),
        const SizedBox(width: 4),
      ],
    );
  }

  // ==========================================================================
  // DRAWER ITEMS
  // ==========================================================================

  List<DrawerItem> _drawerItems(BuildContext context) => [
        DrawerItem(
          icon:  Icons.dashboard_outlined,
          title: 'Fleet Dashboard',
          onTap: () {
            Navigator.pop(context);
            context.goToDashboard();
          },
        ),
        DrawerItem(
          icon:       Icons.electric_car_outlined,
          title:      'All Vehicles',
          isSelected: true,
          trailing:   const DrawerBadge('All'),
          onTap:      () => Navigator.pop(context),
        ),
        DrawerItem(
          icon:     Icons.check_circle_outline,
          title:    'Healthy',
          trailing: const DrawerBadge('Healthy', color: AppColors.success),
          onTap: () {
            Navigator.pop(context);
            ref.read(statusFilterProvider.notifier).state = 'HEALTHY';
          },
        ),
        DrawerItem(
          icon:     Icons.warning_amber_outlined,
          title:    'Needs Attention',
          trailing: const DrawerBadge('Attention', color: AppColors.warning),
          onTap: () {
            Navigator.pop(context);
            ref.read(statusFilterProvider.notifier).state = 'ATTENTION';
          },
        ),
        DrawerItem(
          icon:     Icons.error_outline,
          title:    'Critical',
          trailing: const DrawerBadge('Critical', color: AppColors.error),
          onTap: () {
            Navigator.pop(context);
            ref.read(statusFilterProvider.notifier).state = 'CRITICAL';
          },
        ),
        DrawerItem(
          icon:            Icons.notifications_outlined,
          title:           'Alerts',
          isDividerBefore: true,
          onTap:           () => Navigator.pop(context),
        ),
        DrawerItem(
          icon:  Icons.settings_outlined,
          title: 'Settings',
          onTap: () => Navigator.pop(context),
        ),
        DrawerItem(
          icon:            Icons.help_outline,
          title:           'Help & Support',
          isDividerBefore: true,
          onTap: () {
            Navigator.pop(context);
            AppDrawerDialogs.showHelp(context);
          },
        ),
        DrawerItem(
          icon:  Icons.info_outline,
          title: 'About',
          onTap: () {
            Navigator.pop(context);
            AppDrawerDialogs.showAbout(context);
          },
        ),
      ];

  // ==========================================================================
  // HELPERS
  // ==========================================================================

  bool _hasActiveFilters() {
    final status = ref.read(statusFilterProvider);
    final stress = ref.read(stressFilterProvider);
    final search = ref.read(searchQueryProvider);
    return status != 'ALL' || stress != 'ALL' || search.isNotEmpty;
  }

  void _clearAllFilters() {
    ref.read(statusFilterProvider.notifier).state = 'ALL';
    ref.read(stressFilterProvider.notifier).state = 'ALL';
    ref.read(searchQueryProvider.notifier).state  = '';
    _searchController.clear();
  }
}

// ═══════════════════════════════════════════════
// FILTER BAR — search + two dropdowns
// ═══════════════════════════════════════════════

class _FilterBar extends StatelessWidget {
  final TextEditingController searchController;
  final String selectedStatus;
  final String selectedStress;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onSearchCleared;
  final ValueChanged<String?> onStatusChanged;
  final ValueChanged<String?> onStressChanged;

  const _FilterBar({
    required this.searchController,
    required this.selectedStatus,
    required this.selectedStress,
    required this.onSearchChanged,
    required this.onSearchCleared,
    required this.onStatusChanged,
    required this.onStressChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: Column(
        children: [
          // ── Search Field ──────────────────────────
          VehicleSearchField(
            controller: searchController,
            onChanged:  onSearchChanged,
            onClear:    onSearchCleared,
          ),
          const SizedBox(height: 10),

          // ── Dropdowns Row ─────────────────────────
          Row(
            children: [
              // Status filter
              Expanded(
                child: VehicleStatusDropdown(
                  value:      selectedStatus,
                  onSelected: onStatusChanged,
                ),
              ),
              const SizedBox(width: 10),

              // Stress filter
              Expanded(
                child: StressLevelDropdown(
                  value:      selectedStress,
                  onSelected: onStressChanged,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// VEHICLE LIST — scrollable list of tiles
// ═══════════════════════════════════════════════

class _VehicleList extends StatelessWidget {
  final List<VehicleItemModel> vehicles;

  const _VehicleList({required this.vehicles});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding:     const EdgeInsets.symmetric(vertical: 8),
      itemCount:   vehicles.length,
      itemBuilder: (context, index) => _VehicleListTile(
        vehicle: vehicles[index],
        onTap: () => context.pushVehicleDetail(vehicles[index].vehicleId),
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// VEHICLE LIST TILE — full detail tile
// ═══════════════════════════════════════════════

class _VehicleListTile extends StatelessWidget {
  final VehicleItemModel vehicle;
  final VoidCallback onTap;

  const _VehicleListTile({required this.vehicle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final statusColor = AppColors.fromStatus(vehicle.status);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Material(
        color:        Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap:        onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Theme.of(context).dividerColor,
              ),
            ),
            child: Row(
              children: [
                // ── SoH Circle ──────────────────────
                SoHCircleSmall(soh: vehicle.soh),
                const SizedBox(width: 14),

                // ── Vehicle Info ─────────────────────
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row 1: Vehicle ID + stress badge
                      Row(
                        children: [
                          Text(
                            vehicle.vehicleId,
                            style: GoogleFonts.lato(
                              fontSize:   15,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(width: 8),
                          StressBadge(
                            level: vehicle.stressLevel,
                            size:  BadgeSize.small,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),

                      // Row 2: SoH % + RUL
                      Row(
                        children: [
                          Text(
                            vehicle.sohDisplay,
                            style: GoogleFonts.lato(
                              fontSize:   12,
                              fontWeight: FontWeight.w600,
                              color:      AppColors.fromSoH(vehicle.soh),
                            ),
                          ),
                          Text(
                            '  ·  ${vehicle.rulDisplay}',
                            style: GoogleFonts.lato(
                              fontSize: 12,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.color,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),

                      // Row 3: Status chip + last updated
                      Row(
                        children: [
                          // Status chip
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical:   3,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: statusColor.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width:  6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: statusColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  vehicle.status[0] +
                                      vehicle.status
                                          .substring(1)
                                          .toLowerCase(),
                                  style: GoogleFonts.lato(
                                    fontSize:   11,
                                    fontWeight: FontWeight.w600,
                                    color:      statusColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),

                          // Last updated
                          if (vehicle.lastUpdatedTime.isNotEmpty)
                            Text(
                              'Updated ${vehicle.lastUpdatedTime}',
                              style: GoogleFonts.lato(
                                fontSize: 11,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.color,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),

                // ── Chevron ──────────────────────────
                const SizedBox(width: 8),
                Icon(
                  Icons.chevron_right_rounded,
                  size:  20,
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
