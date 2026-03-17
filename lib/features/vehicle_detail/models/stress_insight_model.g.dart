// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stress_insight_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StressInsightModelImpl _$$StressInsightModelImplFromJson(
        Map<String, dynamic> json) =>
    _$StressInsightModelImpl(
      message: json['message'] as String? ?? '',
      isAboveAverage: json['isAboveAverage'] as bool? ?? false,
    );

Map<String, dynamic> _$$StressInsightModelImplToJson(
        _$StressInsightModelImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'isAboveAverage': instance.isAboveAverage,
    };
