import 'package:freezed_annotation/freezed_annotation.dart';

part 'fleet_summary_model.freezed.dart';
part 'fleet_summary_model.g.dart';

// ═══════════════════════════════════════════════
// FLEET SUMMARY MODEL
// Maps to: GET /fleet/summary
// Spring Boot response shape:
// {
//   "healthy":   12,
//   "attention": 4,
//   "critical":  2,
//   "total":     18
// }
// ═══════════════════════════════════════════════

@freezed
class FleetSummaryModel with _$FleetSummaryModel {
  const factory FleetSummaryModel({
    @Default(0) int healthy,
    @Default(0) int attention,
    @Default(0) int critical,
    @Default(0) int total,
  }) = _FleetSummaryModel;

  // ── JSON ────────────────────────────────────
  factory FleetSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$FleetSummaryModelFromJson(json);

  // ── Empty state ─────────────────────────────
  factory FleetSummaryModel.empty() => const FleetSummaryModel(
        healthy:   0,
        attention: 0,
        critical:  0,
        total:     0,
      );

  // ── Mock — used for UI testing without backend
  factory FleetSummaryModel.mock() => const FleetSummaryModel(
        healthy:   12,
        attention: 4,
        critical:  2,
        total:     18,
      );
}

// ═══════════════════════════════════════════════
// EXTENSION — computed helpers used in UI
// ═══════════════════════════════════════════════

extension FleetSummaryExtension on FleetSummaryModel {
  /// True if any vehicle needs immediate attention
  bool get hasIssues => attention > 0 || critical > 0;

  /// True if any vehicle is critical
  bool get hasCritical => critical > 0;

  /// Fleet health percentage — healthy / total
  double get healthPercentage =>
      total == 0 ? 0.0 : (healthy / total * 100);

  /// Human-readable fleet status string
  String get fleetStatus {
    if (critical > 0) return 'Critical Issues Detected';
    if (attention > 0) return 'Some Vehicles Need Attention';
    return 'All Vehicles Healthy';
  }
}
