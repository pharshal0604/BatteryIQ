// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AlertModelImpl _$$AlertModelImplFromJson(Map<String, dynamic> json) =>
    _$AlertModelImpl(
      alertId: json['alertId'] as String? ?? '',
      vehicleId: json['vehicleId'] as String? ?? '',
      severity: json['severity'] as String? ?? 'WARNING',
      type: json['type'] as String? ?? 'SOH',
      message: json['message'] as String? ?? '',
      timestamp: json['timestamp'] as String? ?? '',
    );

Map<String, dynamic> _$$AlertModelImplToJson(_$AlertModelImpl instance) =>
    <String, dynamic>{
      'alertId': instance.alertId,
      'vehicleId': instance.vehicleId,
      'severity': instance.severity,
      'type': instance.type,
      'message': instance.message,
      'timestamp': instance.timestamp,
    };
