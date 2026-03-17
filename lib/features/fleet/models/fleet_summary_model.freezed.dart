// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fleet_summary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FleetSummaryModel _$FleetSummaryModelFromJson(Map<String, dynamic> json) {
  return _FleetSummaryModel.fromJson(json);
}

/// @nodoc
mixin _$FleetSummaryModel {
  int get healthy => throw _privateConstructorUsedError;
  int get attention => throw _privateConstructorUsedError;
  int get critical => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;

  /// Serializes this FleetSummaryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FleetSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FleetSummaryModelCopyWith<FleetSummaryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FleetSummaryModelCopyWith<$Res> {
  factory $FleetSummaryModelCopyWith(
          FleetSummaryModel value, $Res Function(FleetSummaryModel) then) =
      _$FleetSummaryModelCopyWithImpl<$Res, FleetSummaryModel>;
  @useResult
  $Res call({int healthy, int attention, int critical, int total});
}

/// @nodoc
class _$FleetSummaryModelCopyWithImpl<$Res, $Val extends FleetSummaryModel>
    implements $FleetSummaryModelCopyWith<$Res> {
  _$FleetSummaryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FleetSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? healthy = null,
    Object? attention = null,
    Object? critical = null,
    Object? total = null,
  }) {
    return _then(_value.copyWith(
      healthy: null == healthy
          ? _value.healthy
          : healthy // ignore: cast_nullable_to_non_nullable
              as int,
      attention: null == attention
          ? _value.attention
          : attention // ignore: cast_nullable_to_non_nullable
              as int,
      critical: null == critical
          ? _value.critical
          : critical // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FleetSummaryModelImplCopyWith<$Res>
    implements $FleetSummaryModelCopyWith<$Res> {
  factory _$$FleetSummaryModelImplCopyWith(_$FleetSummaryModelImpl value,
          $Res Function(_$FleetSummaryModelImpl) then) =
      __$$FleetSummaryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int healthy, int attention, int critical, int total});
}

/// @nodoc
class __$$FleetSummaryModelImplCopyWithImpl<$Res>
    extends _$FleetSummaryModelCopyWithImpl<$Res, _$FleetSummaryModelImpl>
    implements _$$FleetSummaryModelImplCopyWith<$Res> {
  __$$FleetSummaryModelImplCopyWithImpl(_$FleetSummaryModelImpl _value,
      $Res Function(_$FleetSummaryModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of FleetSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? healthy = null,
    Object? attention = null,
    Object? critical = null,
    Object? total = null,
  }) {
    return _then(_$FleetSummaryModelImpl(
      healthy: null == healthy
          ? _value.healthy
          : healthy // ignore: cast_nullable_to_non_nullable
              as int,
      attention: null == attention
          ? _value.attention
          : attention // ignore: cast_nullable_to_non_nullable
              as int,
      critical: null == critical
          ? _value.critical
          : critical // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FleetSummaryModelImpl implements _FleetSummaryModel {
  const _$FleetSummaryModelImpl(
      {this.healthy = 0,
      this.attention = 0,
      this.critical = 0,
      this.total = 0});

  factory _$FleetSummaryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FleetSummaryModelImplFromJson(json);

  @override
  @JsonKey()
  final int healthy;
  @override
  @JsonKey()
  final int attention;
  @override
  @JsonKey()
  final int critical;
  @override
  @JsonKey()
  final int total;

  @override
  String toString() {
    return 'FleetSummaryModel(healthy: $healthy, attention: $attention, critical: $critical, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FleetSummaryModelImpl &&
            (identical(other.healthy, healthy) || other.healthy == healthy) &&
            (identical(other.attention, attention) ||
                other.attention == attention) &&
            (identical(other.critical, critical) ||
                other.critical == critical) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, healthy, attention, critical, total);

  /// Create a copy of FleetSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FleetSummaryModelImplCopyWith<_$FleetSummaryModelImpl> get copyWith =>
      __$$FleetSummaryModelImplCopyWithImpl<_$FleetSummaryModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FleetSummaryModelImplToJson(
      this,
    );
  }
}

abstract class _FleetSummaryModel implements FleetSummaryModel {
  const factory _FleetSummaryModel(
      {final int healthy,
      final int attention,
      final int critical,
      final int total}) = _$FleetSummaryModelImpl;

  factory _FleetSummaryModel.fromJson(Map<String, dynamic> json) =
      _$FleetSummaryModelImpl.fromJson;

  @override
  int get healthy;
  @override
  int get attention;
  @override
  int get critical;
  @override
  int get total;

  /// Create a copy of FleetSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FleetSummaryModelImplCopyWith<_$FleetSummaryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
