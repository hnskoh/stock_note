// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_type_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AccountType {
  int? get id => throw _privateConstructorUsedError;
  String get typeCode => throw _privateConstructorUsedError;
  String get typeLabel => throw _privateConstructorUsedError;
  bool get isSystem => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Create a copy of AccountType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccountTypeCopyWith<AccountType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountTypeCopyWith<$Res> {
  factory $AccountTypeCopyWith(
          AccountType value, $Res Function(AccountType) then) =
      _$AccountTypeCopyWithImpl<$Res, AccountType>;
  @useResult
  $Res call(
      {int? id,
      String typeCode,
      String typeLabel,
      bool isSystem,
      DateTime createdAt});
}

/// @nodoc
class _$AccountTypeCopyWithImpl<$Res, $Val extends AccountType>
    implements $AccountTypeCopyWith<$Res> {
  _$AccountTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? typeCode = null,
    Object? typeLabel = null,
    Object? isSystem = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      typeCode: null == typeCode
          ? _value.typeCode
          : typeCode // ignore: cast_nullable_to_non_nullable
              as String,
      typeLabel: null == typeLabel
          ? _value.typeLabel
          : typeLabel // ignore: cast_nullable_to_non_nullable
              as String,
      isSystem: null == isSystem
          ? _value.isSystem
          : isSystem // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AccountTypeImplCopyWith<$Res>
    implements $AccountTypeCopyWith<$Res> {
  factory _$$AccountTypeImplCopyWith(
          _$AccountTypeImpl value, $Res Function(_$AccountTypeImpl) then) =
      __$$AccountTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String typeCode,
      String typeLabel,
      bool isSystem,
      DateTime createdAt});
}

/// @nodoc
class __$$AccountTypeImplCopyWithImpl<$Res>
    extends _$AccountTypeCopyWithImpl<$Res, _$AccountTypeImpl>
    implements _$$AccountTypeImplCopyWith<$Res> {
  __$$AccountTypeImplCopyWithImpl(
      _$AccountTypeImpl _value, $Res Function(_$AccountTypeImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccountType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? typeCode = null,
    Object? typeLabel = null,
    Object? isSystem = null,
    Object? createdAt = null,
  }) {
    return _then(_$AccountTypeImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      typeCode: null == typeCode
          ? _value.typeCode
          : typeCode // ignore: cast_nullable_to_non_nullable
              as String,
      typeLabel: null == typeLabel
          ? _value.typeLabel
          : typeLabel // ignore: cast_nullable_to_non_nullable
              as String,
      isSystem: null == isSystem
          ? _value.isSystem
          : isSystem // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$AccountTypeImpl extends _AccountType {
  const _$AccountTypeImpl(
      {this.id,
      required this.typeCode,
      required this.typeLabel,
      required this.isSystem,
      required this.createdAt})
      : super._();

  @override
  final int? id;
  @override
  final String typeCode;
  @override
  final String typeLabel;
  @override
  final bool isSystem;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'AccountType(id: $id, typeCode: $typeCode, typeLabel: $typeLabel, isSystem: $isSystem, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountTypeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.typeCode, typeCode) ||
                other.typeCode == typeCode) &&
            (identical(other.typeLabel, typeLabel) ||
                other.typeLabel == typeLabel) &&
            (identical(other.isSystem, isSystem) ||
                other.isSystem == isSystem) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, typeCode, typeLabel, isSystem, createdAt);

  /// Create a copy of AccountType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountTypeImplCopyWith<_$AccountTypeImpl> get copyWith =>
      __$$AccountTypeImplCopyWithImpl<_$AccountTypeImpl>(this, _$identity);
}

abstract class _AccountType extends AccountType {
  const factory _AccountType(
      {final int? id,
      required final String typeCode,
      required final String typeLabel,
      required final bool isSystem,
      required final DateTime createdAt}) = _$AccountTypeImpl;
  const _AccountType._() : super._();

  @override
  int? get id;
  @override
  String get typeCode;
  @override
  String get typeLabel;
  @override
  bool get isSystem;
  @override
  DateTime get createdAt;

  /// Create a copy of AccountType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountTypeImplCopyWith<_$AccountTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
