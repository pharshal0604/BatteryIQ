import 'package:ev_fleet_app/core/network/api_client.dart';
import 'package:ev_fleet_app/core/network/api_service.dart';
import 'package:ev_fleet_app/features/vehicle_detail/models/regen_data_model.dart';
import 'package:ev_fleet_app/features/vehicle_detail/models/stress_insight_model.dart';
import 'package:ev_fleet_app/features/vehicle_detail/models/vehicle_detail_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ═══════════════════════════════════════════════
// VEHICLE DETAIL REPOSITORY PROVIDER
// ═══════════════════════════════════════════════

final vehicleDetailRepositoryProvider =
    Provider<VehicleDetailRepository>((ref) {
  return VehicleDetailRepository(ref.watch(apiServiceProvider));
});

// ═══════════════════════════════════════════════
// SOH TREND POINT — lightweight model
// No freezed needed — simple data class
// ═══════════════════════════════════════════════

class SoHTrendPoint {
  final String date;    // "2026-01-01"
  final double soh;     // 0.0 – 100.0

  const SoHTrendPoint({required this.date, required this.soh});

  factory SoHTrendPoint.fromJson(Map<String, dynamic> json) => SoHTrendPoint(
        date: json['date'] as String? ?? '',
        soh:  (json['soh'] as num?)?.toDouble() ?? 0.0,
      );

  static List<SoHTrendPoint> mockList() => [
        const SoHTrendPoint(date: '2025-09-01', soh: 93.2),
        const SoHTrendPoint(date: '2025-10-01', soh: 92.0),
        const SoHTrendPoint(date: '2025-11-01', soh: 91.1),
        const SoHTrendPoint(date: '2025-12-01', soh: 90.0),
        const SoHTrendPoint(date: '2026-01-01', soh: 89.4),
        const SoHTrendPoint(date: '2026-02-01', soh: 88.5),
        const SoHTrendPoint(date: '2026-03-01', soh: 87.4),
      ];
}

// ═══════════════════════════════════════════════
// VEHICLE DETAIL REPOSITORY
// ═══════════════════════════════════════════════

class VehicleDetailRepository {
  final ApiService _apiService;

  VehicleDetailRepository(this._apiService);

  // ==========================================================================
  // Vehicle Detail
  // ==========================================================================

  Future<VehicleDetailModel> getVehicleDetail(String vehicleId) async {
    try {
      final data = await _apiService.getVehicleDetail(vehicleId);
      return VehicleDetailModel.fromJson(data);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        code:    0,
        message: 'Failed to parse vehicle detail: $e',
      );
    }
  }

  // ==========================================================================
  // SoH Trend
  // ==========================================================================

  Future<List<SoHTrendPoint>> getVehicleTrend(
    String vehicleId, {
    String range = '30D',
  }) async {
    try {
      final data = await _apiService.getVehicleTrend(
        vehicleId,
        range: range,
      );
      return data
          .map((e) => SoHTrendPoint.fromJson(e as Map<String, dynamic>))
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        code:    0,
        message: 'Failed to parse trend data: $e',
      );
    }
  }

  // ==========================================================================
  // Stress Insights
  // ==========================================================================

  Future<List<StressInsightModel>> getVehicleStress(
      String vehicleId) async {
    try {
      final data = await _apiService.getVehicleStress(vehicleId);
      return data
          .map((e) => StressInsightModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        code:    0,
        message: 'Failed to parse stress data: $e',
      );
    }
  }

  // ==========================================================================
  // Regen Data
  // ==========================================================================

  Future<RegenDataModel> getVehicleRegen(String vehicleId) async {
    try {
      final data = await _apiService.getVehicleRegen(vehicleId);
      return RegenDataModel.fromJson(data);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        code:    0,
        message: 'Failed to parse regen data: $e',
      );
    }
  }

  // ==========================================================================
  // Mock methods — toggle in provider
  // ==========================================================================

  Future<VehicleDetailModel> getVehicleDetailMock(String vehicleId) async {
    await Future.delayed(const Duration(milliseconds: 700));
    return VehicleDetailModel.mock();
  }

  Future<List<SoHTrendPoint>> getVehicleTrendMock(
    String vehicleId, {
    String range = '30D',
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return SoHTrendPoint.mockList();
  }

  Future<List<StressInsightModel>> getVehicleStressMock(
      String vehicleId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return StressInsightModel.mockList();
  }

  Future<RegenDataModel> getVehicleRegenMock(String vehicleId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return RegenDataModel.mock();
  }
}
