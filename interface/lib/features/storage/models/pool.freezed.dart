// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pool.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Pool _$PoolFromJson(Map<String, dynamic> json) {
  return _Pool.fromJson(json);
}

/// @nodoc
mixin _$Pool {
  String get name => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  bool get isDecrypted => throw _privateConstructorUsedError;

  /// Serializes this Pool to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Pool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PoolCopyWith<Pool> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PoolCopyWith<$Res> {
  factory $PoolCopyWith(Pool value, $Res Function(Pool) then) =
      _$PoolCopyWithImpl<$Res, Pool>;
  @useResult
  $Res call({String name, String status, bool isDecrypted});
}

/// @nodoc
class _$PoolCopyWithImpl<$Res, $Val extends Pool>
    implements $PoolCopyWith<$Res> {
  _$PoolCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Pool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? status = null,
    Object? isDecrypted = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      isDecrypted: null == isDecrypted
          ? _value.isDecrypted
          : isDecrypted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PoolImplCopyWith<$Res> implements $PoolCopyWith<$Res> {
  factory _$$PoolImplCopyWith(
          _$PoolImpl value, $Res Function(_$PoolImpl) then) =
      __$$PoolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String status, bool isDecrypted});
}

/// @nodoc
class __$$PoolImplCopyWithImpl<$Res>
    extends _$PoolCopyWithImpl<$Res, _$PoolImpl>
    implements _$$PoolImplCopyWith<$Res> {
  __$$PoolImplCopyWithImpl(_$PoolImpl _value, $Res Function(_$PoolImpl) _then)
      : super(_value, _then);

  /// Create a copy of Pool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? status = null,
    Object? isDecrypted = null,
  }) {
    return _then(_$PoolImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      isDecrypted: null == isDecrypted
          ? _value.isDecrypted
          : isDecrypted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PoolImpl implements _Pool {
  const _$PoolImpl(
      {required this.name, required this.status, required this.isDecrypted});

  factory _$PoolImpl.fromJson(Map<String, dynamic> json) =>
      _$$PoolImplFromJson(json);

  @override
  final String name;
  @override
  final String status;
  @override
  final bool isDecrypted;

  @override
  String toString() {
    return 'Pool(name: $name, status: $status, isDecrypted: $isDecrypted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PoolImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isDecrypted, isDecrypted) ||
                other.isDecrypted == isDecrypted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, status, isDecrypted);

  /// Create a copy of Pool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PoolImplCopyWith<_$PoolImpl> get copyWith =>
      __$$PoolImplCopyWithImpl<_$PoolImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PoolImplToJson(
      this,
    );
  }
}

abstract class _Pool implements Pool {
  const factory _Pool(
      {required final String name,
      required final String status,
      required final bool isDecrypted}) = _$PoolImpl;

  factory _Pool.fromJson(Map<String, dynamic> json) = _$PoolImpl.fromJson;

  @override
  String get name;
  @override
  String get status;
  @override
  bool get isDecrypted;

  /// Create a copy of Pool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PoolImplCopyWith<_$PoolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
