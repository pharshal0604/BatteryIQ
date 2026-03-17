// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regen_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RegenDataModelImpl _$$RegenDataModelImplFromJson(Map<String, dynamic> json) =>
    _$RegenDataModelImpl(
      usedKwh: (json['usedKwh'] as num?)?.toDouble() ?? 0.0,
      regenKwh: (json['regenKwh'] as num?)?.toDouble() ?? 0.0,
      regenRatio: (json['regenRatio'] as num?)?.toDouble() ?? 0.0,
      periodDays: (json['periodDays'] as num?)?.toInt() ?? 7,
    );

Map<String, dynamic> _$$RegenDataModelImplToJson(
        _$RegenDataModelImpl instance) =>
    <String, dynamic>{
      'usedKwh': instance.usedKwh,
      'regenKwh': instance.regenKwh,
      'regenRatio': instance.regenRatio,
      'periodDays': instance.periodDays,
    };
