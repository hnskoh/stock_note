// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trade_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TradeFilter {
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  String? get accountId => throw _privateConstructorUsedError;
  String? get tickerQuery => throw _privateConstructorUsedError;

  /// Create a copy of TradeFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TradeFilterCopyWith<TradeFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TradeFilterCopyWith<$Res> {
  factory $TradeFilterCopyWith(
          TradeFilter value, $Res Function(TradeFilter) then) =
      _$TradeFilterCopyWithImpl<$Res, TradeFilter>;
  @useResult
  $Res call(
      {DateTime? startDate,
      DateTime? endDate,
      String? accountId,
      String? tickerQuery});
}

/// @nodoc
class _$TradeFilterCopyWithImpl<$Res, $Val extends TradeFilter>
    implements $TradeFilterCopyWith<$Res> {
  _$TradeFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TradeFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? accountId = freezed,
    Object? tickerQuery = freezed,
  }) {
    return _then(_value.copyWith(
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      accountId: freezed == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as String?,
      tickerQuery: freezed == tickerQuery
          ? _value.tickerQuery
          : tickerQuery // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TradeFilterImplCopyWith<$Res>
    implements $TradeFilterCopyWith<$Res> {
  factory _$$TradeFilterImplCopyWith(
          _$TradeFilterImpl value, $Res Function(_$TradeFilterImpl) then) =
      __$$TradeFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime? startDate,
      DateTime? endDate,
      String? accountId,
      String? tickerQuery});
}

/// @nodoc
class __$$TradeFilterImplCopyWithImpl<$Res>
    extends _$TradeFilterCopyWithImpl<$Res, _$TradeFilterImpl>
    implements _$$TradeFilterImplCopyWith<$Res> {
  __$$TradeFilterImplCopyWithImpl(
      _$TradeFilterImpl _value, $Res Function(_$TradeFilterImpl) _then)
      : super(_value, _then);

  /// Create a copy of TradeFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? accountId = freezed,
    Object? tickerQuery = freezed,
  }) {
    return _then(_$TradeFilterImpl(
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      accountId: freezed == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as String?,
      tickerQuery: freezed == tickerQuery
          ? _value.tickerQuery
          : tickerQuery // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$TradeFilterImpl extends _TradeFilter {
  const _$TradeFilterImpl(
      {this.startDate, this.endDate, this.accountId, this.tickerQuery})
      : super._();

  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  final String? accountId;
  @override
  final String? tickerQuery;

  @override
  String toString() {
    return 'TradeFilter(startDate: $startDate, endDate: $endDate, accountId: $accountId, tickerQuery: $tickerQuery)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeFilterImpl &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.tickerQuery, tickerQuery) ||
                other.tickerQuery == tickerQuery));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, startDate, endDate, accountId, tickerQuery);

  /// Create a copy of TradeFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeFilterImplCopyWith<_$TradeFilterImpl> get copyWith =>
      __$$TradeFilterImplCopyWithImpl<_$TradeFilterImpl>(this, _$identity);
}

abstract class _TradeFilter extends TradeFilter {
  const factory _TradeFilter(
      {final DateTime? startDate,
      final DateTime? endDate,
      final String? accountId,
      final String? tickerQuery}) = _$TradeFilterImpl;
  const _TradeFilter._() : super._();

  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  String? get accountId;
  @override
  String? get tickerQuery;

  /// Create a copy of TradeFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TradeFilterImplCopyWith<_$TradeFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
