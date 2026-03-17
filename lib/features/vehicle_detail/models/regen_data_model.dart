import 'package:freezed_annotation/freezed_annotation.dart';

part 'regen_data_model.freezed.dart';
part 'regen_data_model.g.dart';

// ═══════════════════════════════════════════════
// REGEN DATA MODEL
// Maps to: GET /vehicle/{id}/regen
// Spring Boot response shape:
// {
//   "usedKwh":    38.4,
//   "regenKwh":    6.2,
//   "regenRatio":  0.161,
//   "periodDays":  7
// }
// ═══════════════════════════════════════════════

@freezed
class RegenDataModel with _$RegenDataModel {
  const factory RegenDataModel({
    @Default(0.0) double usedKwh,
    @Default(0.0) double regenKwh,
    @Default(0.0) double regenRatio,  // 0.0 – 1.0
    @Default(7)   int    periodDays,
  }) = _RegenDataModel;

  factory RegenDataModel.fromJson(Map<String, dynamic> json) =>
      _$RegenDataModelFromJson(json);

  factory RegenDataModel.empty() => const RegenDataModel();

  factory RegenDataModel.mock() => const RegenDataModel(
        usedKwh:    38.4,
        regenKwh:    6.2,
        regenRatio:  0.161,
        periodDays:  7,
      );
}

// ═══════════════════════════════════════════════
// EXTENSION — computed helpers used in UI
// ═══════════════════════════════════════════════

extension RegenDataExtension on RegenDataModel {
  /// Display string for used kWh
  String get usedDisplay => '${usedKwh.toStringAsFixed(1)} kWh';

  /// Display string for regen kWh
  String get regenDisplay => '${regenKwh.toStringAsFixed(1)} kWh';

  /// Regen ratio as percentage string e.g. "16.1%"
  String get regenRatioDisplay =>
      '${(regenRatio * 100).toStringAsFixed(1)}%';

  /// Period label e.g. "Last 7 days"
  String get periodLabel => 'Last $periodDays days';

  /// Summary sentence shown in detail screen
  /// "Last 7 days: used 38.4 kWh, regenerated 6.2 kWh."
  String get summaryText =>
      '$periodLabel: used $usedDisplay, regenerated $regenDisplay.';

  /// Progress value for regen bar (0.0 – 1.0)
  double get regenBarProgress =>
      usedKwh == 0 ? 0.0 : (regenKwh / usedKwh).clamp(0.0, 1.0);
}
