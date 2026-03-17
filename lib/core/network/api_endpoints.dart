class ApiEndpoints {
  ApiEndpoints._();

  // ==========================================================================
  // Fleet Summary
  // ==========================================================================

  /// GET — returns { healthy, attention, critical, total } counts
  static const String fleetSummary = '/fleet/summary';

  // ==========================================================================
  // Vehicle List
  // ==========================================================================

  /// GET — returns List<VehicleItem>
  /// Query params:
  ///   ?status=ALL|HEALTHY|ATTENTION|CRITICAL
  ///   ?stress=ALL|LOW|MEDIUM|HIGH
  ///   ?search=VH-001
  static const String vehicleList = '/fleet/vehicles';

  // ==========================================================================
  // Vehicle Detail
  // ==========================================================================

  /// GET — returns VehicleDetail object
  /// Path param: vehicleId
  static String vehicleDetail(String vehicleId) =>
      '/vehicle/$vehicleId/detail';

  /// GET — returns List<SoHTrendPoint> (capacity vs time)
  /// Path param: vehicleId
  /// Query params:
  ///   ?range=7D|30D|90D|1Y
  static String vehicleTrend(String vehicleId) =>
      '/vehicle/$vehicleId/trend';

  /// GET — returns List<StressInsight> bullets
  /// Path param: vehicleId
  static String vehicleStress(String vehicleId) =>
      '/vehicle/$vehicleId/stress';

  /// GET — returns RegenData { usedKwh, regenKwh, regenRatio, periodDays }
  /// Path param: vehicleId
  static String vehicleRegen(String vehicleId) =>
      '/vehicle/$vehicleId/regen';

  /// GET — returns List<VehicleAlert>
  /// Path param: vehicleId
  static String vehicleAlerts(String vehicleId) =>
      '/vehicle/$vehicleId/alerts';

  // ==========================================================================
  // Fleet-wide Alerts
  // ==========================================================================

  /// GET — returns List<VehicleAlert> across all vehicles
  /// Query params:
  ///   ?severity=ALL|WARNING|CRITICAL
  static const String fleetAlerts = '/fleet/alerts';

  // ==========================================================================
  // Helpers
  // ==========================================================================

  /// Build query string from a map — use when params are dynamic
  /// Example: buildQuery({'status': 'HEALTHY', 'range': '30D'})
  /// Returns: '?status=HEALTHY&range=30D'
  static String buildQuery(Map<String, String?> params) {
    final filtered = params.entries
        .where((e) => e.value != null && e.value!.isNotEmpty)
        .map((e) => '${e.key}=${e.value}')
        .join('&');

    return filtered.isEmpty ? '' : '?$filtered';
  }
}
