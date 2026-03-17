import 'package:freezed_annotation/freezed_annotation.dart';

part 'stress_insight_model.freezed.dart';
part 'stress_insight_model.g.dart';

// ═══════════════════════════════════════════════
// STRESS INSIGHT MODEL
// Maps to: GET /vehicle/{id}/stress (list item)
// Spring Boot response shape:
// [
//   {
//     "message":        "Hard acceleration events: above fleet average.",
//     "isAboveAverage": true
//   },
//   ...
// ]
// ═══════════════════════════════════════════════

@freezed
class StressInsightModel with _$StressInsightModel {
  const factory StressInsightModel({
    @Default('') String message,
    @Default(false) bool isAboveAverage,
  }) = _StressInsightModel;

  factory StressInsightModel.fromJson(Map<String, dynamic> json) =>
      _$StressInsightModelFromJson(json);

  factory StressInsightModel.empty() => const StressInsightModel();

  static List<StressInsightModel> mockList() => const [
        StressInsightModel(
          message:        'Hard acceleration events: above fleet average.',
          isAboveAverage: true,
        ),
        StressInsightModel(
          message:        'Deep discharges: high — consider charging above 10% SoC.',
          isAboveAverage: true,
        ),
        StressInsightModel(
          message:        'Temperature exposure: within safe range (28°C avg).',
          isAboveAverage: false,
        ),
      ];
}
