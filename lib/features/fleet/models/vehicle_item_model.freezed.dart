// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vehicle_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VehicleItemModel _$VehicleItemModelFromJson(Map<String, dynamic> json) {
  return _VehicleItemModel.fromJson(json);
}

/// @nodoc
mixin _$VehicleItemModel {
  String get vehicleId => throw _privateConstructorUsedError;
  double get soh => throw _privateConstructorUsedError;
  int get rulMonths => throw _privateConstructorUsedError;
  int get rulCycles => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // HEALTHY | ATTENTION | CRITICAL
  String get stressLevel =>
      throw _privateConstructorUsedError; // LOW | MEDIUM | HIGH
  String get lastUpdated => throw _privateConstructorUsedError;

  /// Serializes this VehicleItemModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VehicleItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VehicleItemModelCopyWith<VehicleItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VehicleItemModelCopyWith<$Res> {
  factory $VehicleItemModelCopyWith(
          VehicleItemModel value, $Res Function(VehicleItemModel) then) =
      _$VehicleItemModelCopyWithImpl<$Res, VehicleItemModel>;
  @useResult
  $Res call(
      {String vehicleId,
      double soh,
      int rulMonths,
      int rulCycles,
      String status,
      String stressLevel,
      String lastUpdated});
}

/// @nodoc
class _$VehicleItemModelCopyWithImpl<$Res, $Val extends VehicleItemModel>
    implements $VehicleItemModelCopyWith<$Res> {
  _$VehicleItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VehicleItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vehicleId = null,
    Object? soh = null,
    Object? rulMonths = null,
    Object? rulCycles = null,
    Object? status = null,
    Object? stressLevel = null,
    Object? lastUpdated = null,
  }) {
    return _then(_value.copyWith(
      vehicleId: null == vehicleId
          ? _value.vehicleId
          : vehicleId // ignore: cast_nullable_to_non_nullable
              as String,
      soh: null == soh
          ? _value.soh
          : soh // ignore: cast_nullable_to_non_nullable
              as double,
      rulMonths: null == rulMonths
          ? _value.rulMonths
          : rulMonths // ignore: cast_nullable_to_non_nullable
              as int,
      rulCycles: null == rulCycles
          ? _value.rulCycles
          : rulCycles // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      stressLevel: null == stressLevel
          ? _value.stressLevel
          : stressLevel // ignore: cast_nullable_to_non_nullable
              as String,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VehicleItemModelImplCopyWith<$Res>
    implements $VehicleItemModelCopyWith<$Res> {
  factory _$$VehicleItemModelImplCopyWith(_$VehicleItemModelImpl value,
          $Res Function(_$VehicleItemModelImpl) then) =
      __$$VehicleItemModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String vehicleId,
      double soh,
      int rulMonths,
      int rulCycles,
      String status,
      String stressLevel,
      String lastUpdated});
}

/// @nodoc
class __$$VehicleItemModelImplCopyWithImpl<$Res>
    extends _$VehicleItemModelCopyWithImpl<$Res, _$VehicleItemModelImpl>
    implements _$$VehicleItemModelImplCopyWith<$Res> {
  __$$VehicleItemModelImplCopyWithImpl(_$VehicleItemModelImpl _value,
      $Res Function(_$VehicleItemModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of VehicleItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vehicleId = null,
    Object? soh = null,
    Object? rulMonths = null,
    Object? rulCycles = null,
    Object? status = null,
    Object? stressLevel = null,
    Object? lastUpdated = null,
  }) {
    return _then(_$VehicleItemModelImpl(
      vehicleId: null == vehicleId
          ? _value.vehicleId
          : vehicleId // ignore: cast_nullable_to_non_nullable
              as String,
      soh: null == soh
          ? _value.soh
          : soh // ignore: cast_nullable_to_non_nullable
              as double,
      rulMonths: null == rulMonths
          ? _value.rulMonths
          : rulMonths // ignore: cast_nullable_to_non_nullable
              as int,
      rulCycles: null == rulCycles
          ? _value.rulCycles
          : rulCycles // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      stressLevel: null == stressLevel
          ? _value.stressLevel
          : stressLevel // ignore: cast_nullable_to_non_nullable
              as String,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VehicleItemModelImpl implements _VehicleItemModel {
  const _$VehicleItemModelImpl(
      {this.vehicleId = '',
      this.soh = 0.0,
      this.rulMonths = 0,
      this.rulCycles = 0,
      this.status = 'HEALTHY',
      this.stressLevel = 'LOW',
      this.lastUpdated = ''});

  factory _$VehicleItemModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VehicleItemModelImplFromJson(json);

  @override
  @JsonKey()
  final String vehicleId;
  @override
  @JsonKey()
  final double soh;
  @override
  @JsonKey()
  final int rulMonths;
  @override
  @JsonKey()
  final int rulCycles;
  @override
  @JsonKey()
  final String status;
// HEALTHY | ATTENTION | CRITICAL
  @override
  @JsonKey()
  final String stressLevel;
// LOW | MEDIUM | HIGH
  @override
  @JsonKey()
  final String lastUpdated;

  @override
  String toString() {
    return 'VehicleItemModel(vehicleId: $vehicleId, soh: $soh, rulMonths: $rulMonths, rulCycles: $rulCycles, status: $status, stressLevel: $stressLevel, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VehicleItemModelImpl &&
            (identical(other.vehicleId, vehicleId) ||
                other.vehicleId == vehicleId) &&
            (identical(other.soh, soh) || other.soh == soh) &&
            (identical(other.rulMonths, rulMonths) ||
                other.rulMonths == rulMonths) &&
            (identical(other.rulCycles, rulCycles) ||
                other.rulCycles == rulCycles) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.stressLevel, stressLevel) ||
                other.stressLevel == stressLevel) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, vehicleId, soh, rulMonths,
      rulCycles, status, stressLevel, lastUpdated);

  /// Create a copy of VehicleItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VehicleItemModelImplCopyWith<_$VehicleItemModelImpl> get copyWith =>
      __$$VehicleItemModelImplCopyWithImpl<_$VehicleItemModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VehicleItemModelImplToJson(
      this,
    );
  }
}

abstract class _VehicleItemModel implements VehicleItemModel {
  const factory _VehicleItemModel(
      {final String vehicleId,
      final double soh,
      final int rulMonths,
      final int rulCycles,
      final String status,
      final String stressLevel,
      final String lastUpdated}) = _$VehicleItemModelImpl;

  factory _VehicleItemModel.fromJson(Map<String, dynamic> json) =
      _$VehicleItemModelImpl.fromJson;

  @override
  String get vehicleId;
  @override
  double get soh;
  @override
  int get rulMonths;
  @override
  int get rulCycles;
  @override
  String get status; // HEALTHY | ATTENTION | CRITICAL
  @override
  String get stressLevel; // LOW | MEDIUM | HIGH
  @override
  String get lastUpdated;

  /// Create a copy of VehicleItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VehicleItemModelImplCopyWith<_$VehicleItemModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
