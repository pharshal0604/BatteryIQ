// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fleet_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FleetSummaryModelImpl _$$FleetSummaryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$FleetSummaryModelImpl(
      healthy: (json['healthy'] as num?)?.toInt() ?? 0,
      attention: (json['attention'] as num?)?.toInt() ?? 0,
      critical: (json['critical'] as num?)?.toInt() ?? 0,
      total: (json['total'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$FleetSummaryModelImplToJson(
        _$FleetSummaryModelImpl instance) =>
    <String, dynamic>{
      'healthy': instance.healthy,
      'attention': instance.attention,
      'critical': instance.critical,
      'total': instance.total,
    };
