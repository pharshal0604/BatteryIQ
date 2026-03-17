// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VehicleDetailModelImpl _$$VehicleDetailModelImplFromJson(
        Map<String, dynamic> json) =>
    _$VehicleDetailModelImpl(
      vehicleId: json['vehicleId'] as String? ?? '',
      soh: (json['soh'] as num?)?.toDouble() ?? 0.0,
      rulMonths: (json['rulMonths'] as num?)?.toInt() ?? 0,
      rulCycles: (json['rulCycles'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? 'HEALTHY',
      stressLevel: json['stressLevel'] as String? ?? 'LOW',
      totalCycles: (json['totalCycles'] as num?)?.toInt() ?? 0,
      avgTemperature: (json['avgTemperature'] as num?)?.toDouble() ?? 0.0,
      lastChargeLevel: (json['lastChargeLevel'] as num?)?.toDouble() ?? 0.0,
      lastUpdated: json['lastUpdated'] as String? ?? '',
    );

Map<String, dynamic> _$$VehicleDetailModelImplToJson(
        _$VehicleDetailModelImpl instance) =>
    <String, dynamic>{
      'vehicleId': instance.vehicleId,
      'soh': instance.soh,
      'rulMonths': instance.rulMonths,
      'rulCycles': instance.rulCycles,
      'status': instance.status,
      'stressLevel': instance.stressLevel,
      'totalCycles': instance.totalCycles,
      'avgTemperature': instance.avgTemperature,
      'lastChargeLevel': instance.lastChargeLevel,
      'lastUpdated': instance.lastUpdated,
    };
