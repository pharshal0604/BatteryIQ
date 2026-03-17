import 'dart:async';
import 'package:ev_fleet_app/core/config/env.dart';
import 'package:ev_fleet_app/features/fleet/models/fleet_summary_model.dart';
import 'package:ev_fleet_app/features/fleet/models/vehicle_item_model.dart';
import 'package:ev_fleet_app/features/fleet/repository/fleet_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ═══════════════════════════════════════════════
// TOGGLE — set true when backend not ready
// ═══════════════════════════════════════════════

const bool _useMock = true;

// ═══════════════════════════════════════════════
// FILTER PROVIDERS — shared across screens
// ═══════════════════════════════════════════════

final statusFilterProvider = StateProvider<String>((ref) => 'ALL');
final stressFilterProvider = StateProvider<String>((ref) => 'ALL');
final searchQueryProvider  = StateProvider<String>((ref) => '');

// ═══════════════════════════════════════════════
// FLEET SUMMARY PROVIDER
// Auto-polls every N seconds from EnvConfig
// ═══════════════════════════════════════════════

final fleetSummaryProvider =
    AsyncNotifierProvider<FleetSummaryNotifier, FleetSummaryModel>(
  FleetSummaryNotifier.new,
);

class FleetSummaryNotifier extends AsyncNotifier<FleetSummaryModel> {
  Timer? _pollingTimer;

  @override
  Future<FleetSummaryModel> build() async {
    // Cancel timer when provider is disposed
    ref.onDispose(() => _pollingTimer?.cancel());

    // Start polling
    _startPolling();

    return _fetch();
  }

  Future<FleetSummaryModel> _fetch() async {
    final repo = ref.read(fleetRepositoryProvider);
    return _useMock
        ? repo.getFleetSummaryMock()
        : repo.getFleetSummary();
  }

  /// Manual refresh — called on pull-to-refresh
  Future<void> refresh() async {
    state = const AsyncLoading();                    // ✅ state not ref.state
    state = await AsyncValue.guard(_fetch);          // ✅ state not ref.state
  }

  void _startPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(
      Duration(seconds: EnvConfig.pollIntervalSeconds),
      (_) async {
        // Only poll if not already in error state
        if (state is! AsyncError) {                  // ✅ state not ref.state
          state = await AsyncValue.guard(_fetch);    // ✅ state not ref.state
        }
      },
    );
  }
}

// ═══════════════════════════════════════════════
// VEHICLE LIST PROVIDER
// Reacts to filter + search state changes
// ═══════════════════════════════════════════════

final vehicleListProvider =
    AsyncNotifierProvider<VehicleListNotifier, List<VehicleItemModel>>(
  VehicleListNotifier.new,
);

class VehicleListNotifier extends AsyncNotifier<List<VehicleItemModel>> {
  @override
  Future<List<VehicleItemModel>> build() async {
    // Watch filters — auto re-fetches on change
    final status = ref.watch(statusFilterProvider);
    final stress = ref.watch(stressFilterProvider);
    final search = ref.watch(searchQueryProvider);
    return _fetch(status: status, stress: stress, search: search);
  }

  Future<List<VehicleItemModel>> _fetch({
    required String status,
    required String stress,
    required String search,
  }) async {
    final repo = ref.read(fleetRepositoryProvider);
    return _useMock
        ? repo.getVehicleListMock(
            status: status,
            stress: stress,
            search: search,
          )
        : repo.getVehicleList(
            status: status,
            stress: stress,
            search: search,
          );
  }

  /// Manual refresh
  Future<void> refresh() async {
    state = const AsyncLoading();                    // ✅ state not ref.state
    final status = ref.read(statusFilterProvider);
    final stress = ref.read(stressFilterProvider);
    final search = ref.read(searchQueryProvider);
    state = await AsyncValue.guard(
      () => _fetch(status: status, stress: stress, search: search),
    );
  }
}

// ═══════════════════════════════════════════════
// FILTERED VEHICLE COUNT PROVIDER
// Used on Dashboard stat cards
// ═══════════════════════════════════════════════

final filteredCountProvider = Provider.family<int, String>((ref, status) {
  final listAsync = ref.watch(vehicleListProvider);
  return listAsync.when(
    data:    (list) => list.where((v) => v.status == status).length,
    loading: () => 0,
    error:   (_, __) => 0,
  );
});
