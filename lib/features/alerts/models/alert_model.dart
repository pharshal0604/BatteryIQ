import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'alert_model.freezed.dart';
part 'alert_model.g.dart';

// ═══════════════════════════════════════════════
// ALERT MODEL
// Maps to: GET /fleet/alerts  &  GET /vehicle/{id}/alerts
// Spring Boot response shape:
// {
//   "alertId":   "ALT-001",
//   "vehicleId": "VH-003",
//   "severity":  "CRITICAL",
//   "type":      "SOH",
//   "message":   "SoH dropped below 70% threshold",
//   "timestamp": "2026-03-18T08:30:00"
// }
// ═══════════════════════════════════════════════

@freezed
class AlertModel with _$AlertModel {
  const factory AlertModel({
    @Default('') String alertId,
    @Default('') String vehicleId,
    @Default('WARNING') String severity, // WARNING | CRITICAL
    @Default('SOH') String type, // SOH | TEMPERATURE | CYCLES | STRESS | REGEN
    @Default('') String message,
    @Default('') String timestamp,
  }) = _AlertModel;

  factory AlertModel.fromJson(Map<String, dynamic> json) =>
      _$AlertModelFromJson(json);

  factory AlertModel.empty() => const AlertModel();

  static List<AlertModel> mockList() => [
        const AlertModel(
          alertId: 'ALT-001',
          vehicleId: 'VH-003',
          severity: 'CRITICAL',
          type: 'SOH',
          message: 'SoH dropped below 70% — immediate inspection required.',
          timestamp: '2026-03-18T06:15:00',
        ),
        const AlertModel(
          alertId: 'ALT-002',
          vehicleId: 'VH-007',
          severity: 'CRITICAL',
          type: 'TEMPERATURE',
          message:
              'Battery temperature exceeded 45°C during last charge cycle.',
          timestamp: '2026-03-18T05:40:00',
        ),
        const AlertModel(
          alertId: 'ALT-003',
          vehicleId: 'VH-005',
          severity: 'WARNING',
          type: 'SOH',
          message: 'SoH at 76% — approaching critical threshold.',
          timestamp: '2026-03-17T22:10:00',
        ),
        const AlertModel(
          alertId: 'ALT-004',
          vehicleId: 'VH-002',
          severity: 'WARNING',
          type: 'CYCLES',
          message: 'Charge cycle count high — consider battery inspection.',
          timestamp: '2026-03-17T18:30:00',
        ),
        const AlertModel(
          alertId: 'ALT-005',
          vehicleId: 'VH-009',
          severity: 'WARNING',
          type: 'STRESS',
          message: 'Driving stress consistently HIGH over last 7 days.',
          timestamp: '2026-03-17T14:00:00',
        ),
        const AlertModel(
          alertId: 'ALT-006',
          vehicleId: 'VH-011',
          severity: 'WARNING',
          type: 'REGEN',
          message: 'Regeneration efficiency dropped by 20% vs fleet average.',
          timestamp: '2026-03-17T09:45:00',
        ),
      ];
}

// ═══════════════════════════════════════════════
// EXTENSION — computed helpers used in UI
// ═══════════════════════════════════════════════

extension AlertModelExtension on AlertModel {
  bool get isCritical => severity == 'CRITICAL';
  bool get isWarning => severity == 'WARNING';

  /// Relative timestamp — "2 hours ago", "yesterday", etc.
  String get timeAgo {
    try {
      final dt = DateTime.parse(timestamp);
      final now = DateTime.now();
      final diff = now.difference(dt);

      if (diff.inMinutes < 1) return 'Just now';
      if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
      if (diff.inHours < 24) return '${diff.inHours}h ago';
      if (diff.inDays == 1) return 'Yesterday';
      return '${diff.inDays}d ago';
    } catch (_) {
      return '';
    }
  }

  /// Icon for alert type
  IconData get typeIcon {
    switch (type) {
      case 'SOH':
        return Icons.battery_alert_rounded;
      case 'TEMPERATURE':
        return Icons.thermostat_rounded;
      case 'CYCLES':
        return Icons.loop_rounded;
      case 'STRESS':
        return Icons.speed_rounded;
      case 'REGEN':
        return Icons.replay_rounded;
      default:
        return Icons.notifications_rounded;
    }
  }

  /// Human-readable type label
  String get typeLabel {
    switch (type) {
      case 'SOH':
        return 'Battery Health';
      case 'TEMPERATURE':
        return 'Temperature';
      case 'CYCLES':
        return 'Charge Cycles';
      case 'STRESS':
        return 'Driving Stress';
      case 'REGEN':
        return 'Regeneration';
      default:
        return 'Alert';
    }
  }
}
