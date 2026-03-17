import 'package:ev_fleet_app/core/network/api_client.dart';
import 'package:ev_fleet_app/core/network/api_service.dart';
import 'package:ev_fleet_app/features/fleet/models/fleet_summary_model.dart';
import 'package:ev_fleet_app/features/fleet/models/vehicle_item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ═══════════════════════════════════════════════
// FLEET REPOSITORY PROVIDER
// Injected into fleet providers via Riverpod
// ═══════════════════════════════════════════════

final fleetRepositoryProvider = Provider<FleetRepository>((ref) {
  return FleetRepository(ref.watch(apiServiceProvider));
});

// ═══════════════════════════════════════════════
// FLEET REPOSITORY
// Single source of truth for all fleet data
// Converts raw API maps → typed models
// Throws ApiException on failure — caught in providers
// ═══════════════════════════════════════════════

class FleetRepository {
  final ApiService _apiService;

  FleetRepository(this._apiService);

  // ==========================================================================
  // Fleet Summary
  // ==========================================================================

  /// Fetches fleet summary — healthy / attention / critical counts
  /// Returns [FleetSummaryModel]
  Future<FleetSummaryModel> getFleetSummary() async {
    try {
      final data = await _apiService.getFleetSummary();
      return FleetSummaryModel.fromJson(data);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        code:    0,
        message: 'Failed to parse fleet summary: $e',
      );
    }
  }

  // ==========================================================================
  // Vehicle List
  // ==========================================================================

  /// Fetches list of all vehicles with optional filters
  /// [status]  → ALL | HEALTHY | ATTENTION | CRITICAL
  /// [stress]  → ALL | LOW | MEDIUM | HIGH
  /// [search]  → vehicle ID search string
  /// Returns [List<VehicleItemModel>]
  Future<List<VehicleItemModel>> getVehicleList({
    String? status,
    String? stress,
    String? search,
  }) async {
    try {
      final data = await _apiService.getVehicleList(
        status: status,
        stress: stress,
        search: search,
      );
      return data
          .map((e) => VehicleItemModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        code:    0,
        message: 'Failed to parse vehicle list: $e',
      );
    }
  }

  // ==========================================================================
  // Fleet Alerts
  // ==========================================================================

  /// Fetches all fleet-wide alerts
  /// [severity] → ALL | WARNING | CRITICAL
  /// Returns raw list — parsed in provider if needed
  Future<List<Map<String, dynamic>>> getFleetAlerts({
    String? severity,
  }) async {
    try {
      final data = await _apiService.getFleetAlerts(severity: severity);
      return data
          .map((e) => e as Map<String, dynamic>)
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        code:    0,
        message: 'Failed to parse fleet alerts: $e',
      );
    }
  }

  // ==========================================================================
  // Mock — use when backend is not ready
  // Toggle by setting useMock = true in provider
  // ==========================================================================

  Future<FleetSummaryModel> getFleetSummaryMock() async {
    await Future.delayed(const Duration(milliseconds: 800)); // simulate latency
    return FleetSummaryModel.mock();
  }

  Future<List<VehicleItemModel>> getVehicleListMock({
    String? status,
    String? stress,
    String? search,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    var list = VehicleItemModel.mockList();

    // Apply mock filters so UI filter chips work even without backend
    if (status != null && status != 'ALL') {
      list = list.where((v) => v.status == status).toList();
    }
    if (stress != null && stress != 'ALL') {
      list = list.where((v) => v.stressLevel == stress).toList();
    }
    if (search != null && search.isNotEmpty) {
      list = list
          .where((v) => v.vehicleId
              .toLowerCase()
              .contains(search.toLowerCase()))
          .toList();
    }
    return list;
  }
}
