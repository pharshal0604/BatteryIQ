// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VehicleItemModelImpl _$$VehicleItemModelImplFromJson(
        Map<String, dynamic> json) =>
    _$VehicleItemModelImpl(
      vehicleId: json['vehicleId'] as String? ?? '',
      soh: (json['soh'] as num?)?.toDouble() ?? 0.0,
      rulMonths: (json['rulMonths'] as num?)?.toInt() ?? 0,
      rulCycles: (json['rulCycles'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? 'HEALTHY',
      stressLevel: json['stressLevel'] as String? ?? 'LOW',
      lastUpdated: json['lastUpdated'] as String? ?? '',
    );

Map<String, dynamic> _$$VehicleItemModelImplToJson(
        _$VehicleItemModelImpl instance) =>
    <String, dynamic>{
      'vehicleId': instance.vehicleId,
      'soh': instance.soh,
      'rulMonths': instance.rulMonths,
      'rulCycles': instance.rulCycles,
      'status': instance.status,
      'stressLevel': instance.stressLevel,
      'lastUpdated': instance.lastUpdated,
    };
