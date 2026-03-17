// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'regen_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RegenDataModel _$RegenDataModelFromJson(Map<String, dynamic> json) {
  return _RegenDataModel.fromJson(json);
}

/// @nodoc
mixin _$RegenDataModel {
  double get usedKwh => throw _privateConstructorUsedError;
  double get regenKwh => throw _privateConstructorUsedError;
  double get regenRatio => throw _privateConstructorUsedError; // 0.0 – 1.0
  int get periodDays => throw _privateConstructorUsedError;

  /// Serializes this RegenDataModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RegenDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegenDataModelCopyWith<RegenDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegenDataModelCopyWith<$Res> {
  factory $RegenDataModelCopyWith(
          RegenDataModel value, $Res Function(RegenDataModel) then) =
      _$RegenDataModelCopyWithImpl<$Res, RegenDataModel>;
  @useResult
  $Res call(
      {double usedKwh, double regenKwh, double regenRatio, int periodDays});
}

/// @nodoc
class _$RegenDataModelCopyWithImpl<$Res, $Val extends RegenDataModel>
    implements $RegenDataModelCopyWith<$Res> {
  _$RegenDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegenDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? usedKwh = null,
    Object? regenKwh = null,
    Object? regenRatio = null,
    Object? periodDays = null,
  }) {
    return _then(_value.copyWith(
      usedKwh: null == usedKwh
          ? _value.usedKwh
          : usedKwh // ignore: cast_nullable_to_non_nullable
              as double,
      regenKwh: null == regenKwh
          ? _value.regenKwh
          : regenKwh // ignore: cast_nullable_to_non_nullable
              as double,
      regenRatio: null == regenRatio
          ? _value.regenRatio
          : regenRatio // ignore: cast_nullable_to_non_nullable
              as double,
      periodDays: null == periodDays
          ? _value.periodDays
          : periodDays // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegenDataModelImplCopyWith<$Res>
    implements $RegenDataModelCopyWith<$Res> {
  factory _$$RegenDataModelImplCopyWith(_$RegenDataModelImpl value,
          $Res Function(_$RegenDataModelImpl) then) =
      __$$RegenDataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double usedKwh, double regenKwh, double regenRatio, int periodDays});
}

/// @nodoc
class __$$RegenDataModelImplCopyWithImpl<$Res>
    extends _$RegenDataModelCopyWithImpl<$Res, _$RegenDataModelImpl>
    implements _$$RegenDataModelImplCopyWith<$Res> {
  __$$RegenDataModelImplCopyWithImpl(
      _$RegenDataModelImpl _value, $Res Function(_$RegenDataModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegenDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? usedKwh = null,
    Object? regenKwh = null,
    Object? regenRatio = null,
    Object? periodDays = null,
  }) {
    return _then(_$RegenDataModelImpl(
      usedKwh: null == usedKwh
          ? _value.usedKwh
          : usedKwh // ignore: cast_nullable_to_non_nullable
              as double,
      regenKwh: null == regenKwh
          ? _value.regenKwh
          : regenKwh // ignore: cast_nullable_to_non_nullable
              as double,
      regenRatio: null == regenRatio
          ? _value.regenRatio
          : regenRatio // ignore: cast_nullable_to_non_nullable
              as double,
      periodDays: null == periodDays
          ? _value.periodDays
          : periodDays // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RegenDataModelImpl implements _RegenDataModel {
  const _$RegenDataModelImpl(
      {this.usedKwh = 0.0,
      this.regenKwh = 0.0,
      this.regenRatio = 0.0,
      this.periodDays = 7});

  factory _$RegenDataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegenDataModelImplFromJson(json);

  @override
  @JsonKey()
  final double usedKwh;
  @override
  @JsonKey()
  final double regenKwh;
  @override
  @JsonKey()
  final double regenRatio;
// 0.0 – 1.0
  @override
  @JsonKey()
  final int periodDays;

  @override
  String toString() {
    return 'RegenDataModel(usedKwh: $usedKwh, regenKwh: $regenKwh, regenRatio: $regenRatio, periodDays: $periodDays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegenDataModelImpl &&
            (identical(other.usedKwh, usedKwh) || other.usedKwh == usedKwh) &&
            (identical(other.regenKwh, regenKwh) ||
                other.regenKwh == regenKwh) &&
            (identical(other.regenRatio, regenRatio) ||
                other.regenRatio == regenRatio) &&
            (identical(other.periodDays, periodDays) ||
                other.periodDays == periodDays));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, usedKwh, regenKwh, regenRatio, periodDays);

  /// Create a copy of RegenDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegenDataModelImplCopyWith<_$RegenDataModelImpl> get copyWith =>
      __$$RegenDataModelImplCopyWithImpl<_$RegenDataModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegenDataModelImplToJson(
      this,
    );
  }
}

abstract class _RegenDataModel implements RegenDataModel {
  const factory _RegenDataModel(
      {final double usedKwh,
      final double regenKwh,
      final double regenRatio,
      final int periodDays}) = _$RegenDataModelImpl;

  factory _RegenDataModel.fromJson(Map<String, dynamic> json) =
      _$RegenDataModelImpl.fromJson;

  @override
  double get usedKwh;
  @override
  double get regenKwh;
  @override
  double get regenRatio; // 0.0 – 1.0
  @override
  int get periodDays;

  /// Create a copy of RegenDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegenDataModelImplCopyWith<_$RegenDataModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
