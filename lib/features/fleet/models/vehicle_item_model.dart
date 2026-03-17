import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle_item_model.freezed.dart';
part 'vehicle_item_model.g.dart';

// ═══════════════════════════════════════════════
// VEHICLE ITEM MODEL
// Maps to: GET /fleet/vehicles (list item)
// Spring Boot response shape:
// {
//   "vehicleId":   "VH-001",
//   "soh":          87.4,
//   "rulMonths":    14,
//   "rulCycles":    420,
//   "status":      "HEALTHY",
//   "stressLevel": "LOW",
//   "lastUpdated": "2026-03-17T10:30:00"
// }
// ═══════════════════════════════════════════════

@freezed
class VehicleItemModel with _$VehicleItemModel {
  const factory VehicleItemModel({
    @Default('') String vehicleId,
    @Default(0.0) double soh,
    @Default(0) int rulMonths,
    @Default(0) int rulCycles,
    @Default('HEALTHY') String status,       // HEALTHY | ATTENTION | CRITICAL
    @Default('LOW') String stressLevel,      // LOW | MEDIUM | HIGH
    @Default('') String lastUpdated,
  }) = _VehicleItemModel;

  // ── JSON ────────────────────────────────────
  factory VehicleItemModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleItemModelFromJson(json);

  // ── Empty ────────────────────────────────────
  factory VehicleItemModel.empty() => const VehicleItemModel();

  // ── Mock list — UI testing without backend ───
  static List<VehicleItemModel> mockList() => [
        const VehicleItemModel(
          vehicleId:   'VH-001',
          soh:          87.4,
          rulMonths:    14,
          rulCycles:    420,
          status:      'HEALTHY',
          stressLevel: 'LOW',
          lastUpdated: '2026-03-17T10:30:00',
        ),
        const VehicleItemModel(
          vehicleId:   'VH-002',
          soh:          76.2,
          rulMonths:    8,
          rulCycles:    240,
          status:      'ATTENTION',
          stressLevel: 'MEDIUM',
          lastUpdated: '2026-03-17T09:15:00',
        ),
        const VehicleItemModel(
          vehicleId:   'VH-003',
          soh:          65.8,
          rulMonths:    3,
          rulCycles:    90,
          status:      'CRITICAL',
          stressLevel: 'HIGH',
          lastUpdated: '2026-03-17T08:00:00',
        ),
        const VehicleItemModel(
          vehicleId:   'VH-004',
          soh:          91.0,
          rulMonths:    22,
          rulCycles:    660,
          status:      'HEALTHY',
          stressLevel: 'LOW',
          lastUpdated: '2026-03-17T11:00:00',
        ),
        const VehicleItemModel(
          vehicleId:   'VH-005',
          soh:          79.5,
          rulMonths:    10,
          rulCycles:    300,
          status:      'ATTENTION',
          stressLevel: 'HIGH',
          lastUpdated: '2026-03-17T07:45:00',
        ),
      ];
}

// ═══════════════════════════════════════════════
// EXTENSION — computed helpers used in UI
// ═══════════════════════════════════════════════

extension VehicleItemExtension on VehicleItemModel {
  /// True if vehicle needs immediate action
  bool get isCritical => status == 'CRITICAL';

  /// True if vehicle needs monitoring
  bool get needsAttention => status == 'ATTENTION';

  /// True if vehicle is healthy
  bool get isHealthy => status == 'HEALTHY';

  /// RUL display string — shows months + cycles
  String get rulDisplay => '$rulMonths mo · $rulCycles cycles';

  /// SoH display string — rounded to 1 decimal
  String get sohDisplay => '${soh.toStringAsFixed(1)}%';

  /// Stress level display — capitalised
  String get stressDisplay =>
      stressLevel.isNotEmpty
          ? stressLevel[0].toUpperCase() +
            stressLevel.substring(1).toLowerCase()
          : 'Unknown';

  /// Last updated formatted — time only e.g. "10:30 AM"
  String get lastUpdatedTime {
    try {
      final dt = DateTime.parse(lastUpdated);
      final hour   = dt.hour > 12 ? dt.hour - 12 : dt.hour == 0 ? 12 : dt.hour;
      final minute = dt.minute.toString().padLeft(2, '0');
      final period = dt.hour >= 12 ? 'PM' : 'AM';
      return '$hour:$minute $period';
    } catch (_) {
      return '';
    }
  }
}
