// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trade_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TradeModel {
  int? get id => throw _privateConstructorUsedError;
  int get accountId => throw _privateConstructorUsedError;
  DateTime get tradeDate => throw _privateConstructorUsedError;
  String get tickerName => throw _privateConstructorUsedError;
  TradeAction get action => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  double get fee => throw _privateConstructorUsedError;
  double get totalAmount => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError; // 조인용
  String? get accountName => throw _privateConstructorUsedError;

  /// Create a copy of TradeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TradeModelCopyWith<TradeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TradeModelCopyWith<$Res> {
  factory $TradeModelCopyWith(
          TradeModel value, $Res Function(TradeModel) then) =
      _$TradeModelCopyWithImpl<$Res, TradeModel>;
  @useResult
  $Res call(
      {int? id,
      int accountId,
      DateTime tradeDate,
      String tickerName,
      TradeAction action,
      double quantity,
      double price,
      double fee,
      double totalAmount,
      String? note,
      DateTime createdAt,
      DateTime updatedAt,
      String? accountName});
}

/// @nodoc
class _$TradeModelCopyWithImpl<$Res, $Val extends TradeModel>
    implements $TradeModelCopyWith<$Res> {
  _$TradeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TradeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? accountId = null,
    Object? tradeDate = null,
    Object? tickerName = null,
    Object? action = null,
    Object? quantity = null,
    Object? price = null,
    Object? fee = null,
    Object? totalAmount = null,
    Object? note = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? accountName = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
      tradeDate: null == tradeDate
          ? _value.tradeDate
          : tradeDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      tickerName: null == tickerName
          ? _value.tickerName
          : tickerName // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as TradeAction,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as double,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      accountName: freezed == accountName
          ? _value.accountName
          : accountName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TradeModelImplCopyWith<$Res>
    implements $TradeModelCopyWith<$Res> {
  factory _$$TradeModelImplCopyWith(
          _$TradeModelImpl value, $Res Function(_$TradeModelImpl) then) =
      __$$TradeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      int accountId,
      DateTime tradeDate,
      String tickerName,
      TradeAction action,
      double quantity,
      double price,
      double fee,
      double totalAmount,
      String? note,
      DateTime createdAt,
      DateTime updatedAt,
      String? accountName});
}

/// @nodoc
class __$$TradeModelImplCopyWithImpl<$Res>
    extends _$TradeModelCopyWithImpl<$Res, _$TradeModelImpl>
    implements _$$TradeModelImplCopyWith<$Res> {
  __$$TradeModelImplCopyWithImpl(
      _$TradeModelImpl _value, $Res Function(_$TradeModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TradeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? accountId = null,
    Object? tradeDate = null,
    Object? tickerName = null,
    Object? action = null,
    Object? quantity = null,
    Object? price = null,
    Object? fee = null,
    Object? totalAmount = null,
    Object? note = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? accountName = freezed,
  }) {
    return _then(_$TradeModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
      tradeDate: null == tradeDate
          ? _value.tradeDate
          : tradeDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      tickerName: null == tickerName
          ? _value.tickerName
          : tickerName // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as TradeAction,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as double,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      accountName: freezed == accountName
          ? _value.accountName
          : accountName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$TradeModelImpl extends _TradeModel {
  const _$TradeModelImpl(
      {this.id,
      required this.accountId,
      required this.tradeDate,
      required this.tickerName,
      required this.action,
      required this.quantity,
      required this.price,
      this.fee = 0.0,
      required this.totalAmount,
      this.note,
      required this.createdAt,
      required this.updatedAt,
      this.accountName})
      : super._();

  @override
  final int? id;
  @override
  final int accountId;
  @override
  final DateTime tradeDate;
  @override
  final String tickerName;
  @override
  final TradeAction action;
  @override
  final double quantity;
  @override
  final double price;
  @override
  @JsonKey()
  final double fee;
  @override
  final double totalAmount;
  @override
  final String? note;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
// 조인용
  @override
  final String? accountName;

  @override
  String toString() {
    return 'TradeModel(id: $id, accountId: $accountId, tradeDate: $tradeDate, tickerName: $tickerName, action: $action, quantity: $quantity, price: $price, fee: $fee, totalAmount: $totalAmount, note: $note, createdAt: $createdAt, updatedAt: $updatedAt, accountName: $accountName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.tradeDate, tradeDate) ||
                other.tradeDate == tradeDate) &&
            (identical(other.tickerName, tickerName) ||
                other.tickerName == tickerName) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.accountName, accountName) ||
                other.accountName == accountName));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      accountId,
      tradeDate,
      tickerName,
      action,
      quantity,
      price,
      fee,
      totalAmount,
      note,
      createdAt,
      updatedAt,
      accountName);

  /// Create a copy of TradeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeModelImplCopyWith<_$TradeModelImpl> get copyWith =>
      __$$TradeModelImplCopyWithImpl<_$TradeModelImpl>(this, _$identity);
}

abstract class _TradeModel extends TradeModel {
  const factory _TradeModel(
      {final int? id,
      required final int accountId,
      required final DateTime tradeDate,
      required final String tickerName,
      required final TradeAction action,
      required final double quantity,
      required final double price,
      final double fee,
      required final double totalAmount,
      final String? note,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final String? accountName}) = _$TradeModelImpl;
  const _TradeModel._() : super._();

  @override
  int? get id;
  @override
  int get accountId;
  @override
  DateTime get tradeDate;
  @override
  String get tickerName;
  @override
  TradeAction get action;
  @override
  double get quantity;
  @override
  double get price;
  @override
  double get fee;
  @override
  double get totalAmount;
  @override
  String? get note;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt; // 조인용
  @override
  String? get accountName;

  /// Create a copy of TradeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TradeModelImplCopyWith<_$TradeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
