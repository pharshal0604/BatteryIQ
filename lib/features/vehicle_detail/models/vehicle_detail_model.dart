import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle_detail_model.freezed.dart';
part 'vehicle_detail_model.g.dart';

// ═══════════════════════════════════════════════
// VEHICLE DETAIL MODEL
// Maps to: GET /vehicle/{id}/detail
// Spring Boot response shape:
// {
//   "vehicleId":       "VH-001",
//   "soh":              87.4,
//   "rulMonths":        14,
//   "rulCycles":        420,
//   "status":          "HEALTHY",
//   "stressLevel":     "LOW",
//   "totalCycles":      1240,
//   "avgTemperature":   28.5,
//   "lastChargeLevel":  95.0,
//   "lastUpdated":     "2026-03-17T10:30:00"
// }
// ═══════════════════════════════════════════════

@freezed
class VehicleDetailModel with _$VehicleDetailModel {
  const factory VehicleDetailModel({
    @Default('') String vehicleId,
    @Default(0.0) double soh,
    @Default(0) int rulMonths,
    @Default(0) int rulCycles,
    @Default('HEALTHY') String status,
    @Default('LOW') String stressLevel,
    @Default(0) int totalCycles,
    @Default(0.0) double avgTemperature,
    @Default(0.0) double lastChargeLevel,
    @Default('') String lastUpdated,
  }) = _VehicleDetailModel;

  factory VehicleDetailModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleDetailModelFromJson(json);

  factory VehicleDetailModel.empty() => const VehicleDetailModel();

  factory VehicleDetailModel.mock() => const VehicleDetailModel(
        vehicleId:       'VH-001',
        soh:              87.4,
        rulMonths:        14,
        rulCycles:        420,
        status:          'HEALTHY',
        stressLevel:     'LOW',
        totalCycles:      1240,
        avgTemperature:   28.5,
        lastChargeLevel:  95.0,
        lastUpdated:     '2026-03-17T10:30:00',
      );
}

// ═══════════════════════════════════════════════
// EXTENSION — computed helpers used in UI
// ═══════════════════════════════════════════════

extension VehicleDetailExtension on VehicleDetailModel {
  bool get isCritical    => status == 'CRITICAL';
  bool get needsAttention => status == 'ATTENTION';
  bool get isHealthy     => status == 'HEALTHY';

  String get sohDisplay  => '${soh.toStringAsFixed(1)}%';
  String get rulDisplay  => '$rulMonths mo · $rulCycles cycles';

  String get tempDisplay =>
      '${avgTemperature.toStringAsFixed(1)}°C';

  String get lastChargeDisplay =>
      '${lastChargeLevel.toStringAsFixed(0)}%';

  /// Status label used in Health section
  String get statusLabel => switch (status) {
        'HEALTHY'   => 'Good',
        'ATTENTION' => 'Monitor',
        'CRITICAL'  => 'Critical',
        _           => 'Unknown',
      };
}
