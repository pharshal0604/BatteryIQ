import 'package:ev_fleet_app/core/config/env.dart';
import 'package:ev_fleet_app/core/network/api_client.dart';
import 'package:ev_fleet_app/core/network/api_service.dart';
import 'package:ev_fleet_app/features/alerts/models/alert_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ═══════════════════════════════════════════════
// ALERTS REPOSITORY PROVIDER
// ═══════════════════════════════════════════════

final alertsRepositoryProvider = Provider<AlertsRepository>((ref) {
  return AlertsRepository(ref.watch(apiServiceProvider));
});

// ═══════════════════════════════════════════════
// ALERTS REPOSITORY
// ═══════════════════════════════════════════════

class AlertsRepository {
  final ApiService _apiService;

  AlertsRepository(this._apiService);

  // ==========================================================================
  // Fleet Alerts — real API
  // ==========================================================================

  Future<List<AlertModel>> getFleetAlerts({String severity = 'ALL'}) async {
    try {
      final data = await _apiService.getFleetAlerts(
        severity: severity == 'ALL' ? null : severity,
      );
      return data
          .map((e) => AlertModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        code:    0,
        message: 'Failed to parse alerts: $e',
      );
    }
  }

  // ==========================================================================
  // Mock
  // ==========================================================================

  Future<List<AlertModel>> getFleetAlertsMock({
    String severity = 'ALL',
  }) async {
    await Future.delayed(const Duration(milliseconds: 700));
    var list = AlertModel.mockList();

    if (severity != 'ALL') {
      list = list.where((a) => a.severity == severity).toList();
    }

    // Critical first, then Warning — newest first within each group
    list.sort((a, b) {
      if (a.severity != b.severity) return a.isCritical ? -1 : 1;
      return b.timestamp.compareTo(a.timestamp);
    });

    return list;
  }
}