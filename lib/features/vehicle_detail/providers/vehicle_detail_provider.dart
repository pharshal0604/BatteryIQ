import 'package:ev_fleet_app/core/config/env.dart';
import 'package:ev_fleet_app/features/vehicle_detail/models/regen_data_model.dart';
import 'package:ev_fleet_app/features/vehicle_detail/models/stress_insight_model.dart';
import 'package:ev_fleet_app/features/vehicle_detail/models/vehicle_detail_model.dart';
import 'package:ev_fleet_app/features/vehicle_detail/repository/vehicle_detail_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ═══════════════════════════════════════════════
// TOGGLE — set true when backend not ready
// ═══════════════════════════════════════════════

// ═══════════════════════════════════════════════
// TREND RANGE PROVIDER
// Shared state for the time range dropdown
// ═══════════════════════════════════════════════

final trendRangeProvider =
    StateProvider.family<String, String>((ref, vehicleId) => '30D');

// ═══════════════════════════════════════════════
// VEHICLE DETAIL PROVIDER
// family → keyed by vehicleId
// ═══════════════════════════════════════════════

final vehicleDetailProvider = AsyncNotifierProvider.family<
    VehicleDetailNotifier,
    VehicleDetailModel,
    String>(VehicleDetailNotifier.new);

class VehicleDetailNotifier
    extends FamilyAsyncNotifier<VehicleDetailModel, String> {
  @override
  Future<VehicleDetailModel> build(String arg) async {
    return _fetch(arg);
  }

  Future<VehicleDetailModel> _fetch(String vehicleId) async {
    final repo = ref.read(vehicleDetailRepositoryProvider);
    return EnvConfig.useMock 
        ? repo.getVehicleDetailMock(vehicleId)
        : repo.getVehicleDetail(vehicleId);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetch(arg));
  }
}

// ═══════════════════════════════════════════════
// SOH TREND PROVIDER
// Re-fetches when trendRangeProvider changes
// ═══════════════════════════════════════════════

final vehicleTrendProvider = AsyncNotifierProvider.family<
    VehicleTrendNotifier,
    List<SoHTrendPoint>,
    String>(VehicleTrendNotifier.new);

class VehicleTrendNotifier
    extends FamilyAsyncNotifier<List<SoHTrendPoint>, String> {
  @override
  Future<List<SoHTrendPoint>> build(String arg) async {
    // Watch range — auto re-fetches on dropdown change
    final range = ref.watch(trendRangeProvider(arg));
    return _fetch(arg, range);
  }

  Future<List<SoHTrendPoint>> _fetch(
      String vehicleId, String range) async {
    final repo = ref.read(vehicleDetailRepositoryProvider);
    return EnvConfig.useMock 
        ? repo.getVehicleTrendMock(vehicleId, range: range)
        : repo.getVehicleTrend(vehicleId, range: range);
  }
}

// ═══════════════════════════════════════════════
// STRESS INSIGHTS PROVIDER
// ═══════════════════════════════════════════════

final vehicleStressProvider = AsyncNotifierProvider.family<
    VehicleStressNotifier,
    List<StressInsightModel>,
    String>(VehicleStressNotifier.new);

class VehicleStressNotifier
    extends FamilyAsyncNotifier<List<StressInsightModel>, String> {
  @override
  Future<List<StressInsightModel>> build(String arg) async {
    final repo = ref.read(vehicleDetailRepositoryProvider);
    return EnvConfig.useMock 
        ? repo.getVehicleStressMock(arg)
        : repo.getVehicleStress(arg);
  }
}

// ═══════════════════════════════════════════════
// REGEN DATA PROVIDER
// ═══════════════════════════════════════════════

final vehicleRegenProvider = AsyncNotifierProvider.family<
    VehicleRegenNotifier,
    RegenDataModel,
    String>(VehicleRegenNotifier.new);

class VehicleRegenNotifier
    extends FamilyAsyncNotifier<RegenDataModel, String> {
  @override
  Future<RegenDataModel> build(String arg) async {
    final repo = ref.read(vehicleDetailRepositoryProvider);
    return EnvConfig.useMock 
        ? repo.getVehicleRegenMock(arg)
        : repo.getVehicleRegen(arg);
  }
}
