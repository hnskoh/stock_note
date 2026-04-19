// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DashboardSummary {
  double get totalBuyAmount => throw _privateConstructorUsedError;
  double get totalSellAmount => throw _privateConstructorUsedError;
  List<TradeModel> get recentTrades => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;

  /// Create a copy of DashboardSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardSummaryCopyWith<DashboardSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardSummaryCopyWith<$Res> {
  factory $DashboardSummaryCopyWith(
          DashboardSummary value, $Res Function(DashboardSummary) then) =
      _$DashboardSummaryCopyWithImpl<$Res, DashboardSummary>;
  @useResult
  $Res call(
      {double totalBuyAmount,
      double totalSellAmount,
      List<TradeModel> recentTrades,
      DateTime startDate,
      DateTime endDate});
}

/// @nodoc
class _$DashboardSummaryCopyWithImpl<$Res, $Val extends DashboardSummary>
    implements $DashboardSummaryCopyWith<$Res> {
  _$DashboardSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalBuyAmount = null,
    Object? totalSellAmount = null,
    Object? recentTrades = null,
    Object? startDate = null,
    Object? endDate = null,
  }) {
    return _then(_value.copyWith(
      totalBuyAmount: null == totalBuyAmount
          ? _value.totalBuyAmount
          : totalBuyAmount // ignore: cast_nullable_to_non_nullable
              as double,
      totalSellAmount: null == totalSellAmount
          ? _value.totalSellAmount
          : totalSellAmount // ignore: cast_nullable_to_non_nullable
              as double,
      recentTrades: null == recentTrades
          ? _value.recentTrades
          : recentTrades // ignore: cast_nullable_to_non_nullable
              as List<TradeModel>,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DashboardSummaryImplCopyWith<$Res>
    implements $DashboardSummaryCopyWith<$Res> {
  factory _$$DashboardSummaryImplCopyWith(_$DashboardSummaryImpl value,
          $Res Function(_$DashboardSummaryImpl) then) =
      __$$DashboardSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double totalBuyAmount,
      double totalSellAmount,
      List<TradeModel> recentTrades,
      DateTime startDate,
      DateTime endDate});
}

/// @nodoc
class __$$DashboardSummaryImplCopyWithImpl<$Res>
    extends _$DashboardSummaryCopyWithImpl<$Res, _$DashboardSummaryImpl>
    implements _$$DashboardSummaryImplCopyWith<$Res> {
  __$$DashboardSummaryImplCopyWithImpl(_$DashboardSummaryImpl _value,
      $Res Function(_$DashboardSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of DashboardSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalBuyAmount = null,
    Object? totalSellAmount = null,
    Object? recentTrades = null,
    Object? startDate = null,
    Object? endDate = null,
  }) {
    return _then(_$DashboardSummaryImpl(
      totalBuyAmount: null == totalBuyAmount
          ? _value.totalBuyAmount
          : totalBuyAmount // ignore: cast_nullable_to_non_nullable
              as double,
      totalSellAmount: null == totalSellAmount
          ? _value.totalSellAmount
          : totalSellAmount // ignore: cast_nullable_to_non_nullable
              as double,
      recentTrades: null == recentTrades
          ? _value._recentTrades
          : recentTrades // ignore: cast_nullable_to_non_nullable
              as List<TradeModel>,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$DashboardSummaryImpl extends _DashboardSummary {
  const _$DashboardSummaryImpl(
      {required this.totalBuyAmount,
      required this.totalSellAmount,
      required final List<TradeModel> recentTrades,
      required this.startDate,
      required this.endDate})
      : _recentTrades = recentTrades,
        super._();

  @override
  final double totalBuyAmount;
  @override
  final double totalSellAmount;
  final List<TradeModel> _recentTrades;
  @override
  List<TradeModel> get recentTrades {
    if (_recentTrades is EqualUnmodifiableListView) return _recentTrades;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentTrades);
  }

  @override
  final DateTime startDate;
  @override
  final DateTime endDate;

  @override
  String toString() {
    return 'DashboardSummary(totalBuyAmount: $totalBuyAmount, totalSellAmount: $totalSellAmount, recentTrades: $recentTrades, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardSummaryImpl &&
            (identical(other.totalBuyAmount, totalBuyAmount) ||
                other.totalBuyAmount == totalBuyAmount) &&
            (identical(other.totalSellAmount, totalSellAmount) ||
                other.totalSellAmount == totalSellAmount) &&
            const DeepCollectionEquality()
                .equals(other._recentTrades, _recentTrades) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, totalBuyAmount, totalSellAmount,
      const DeepCollectionEquality().hash(_recentTrades), startDate, endDate);

  /// Create a copy of DashboardSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardSummaryImplCopyWith<_$DashboardSummaryImpl> get copyWith =>
      __$$DashboardSummaryImplCopyWithImpl<_$DashboardSummaryImpl>(
          this, _$identity);
}

abstract class _DashboardSummary extends DashboardSummary {
  const factory _DashboardSummary(
      {required final double totalBuyAmount,
      required final double totalSellAmount,
      required final List<TradeModel> recentTrades,
      required final DateTime startDate,
      required final DateTime endDate}) = _$DashboardSummaryImpl;
  const _DashboardSummary._() : super._();

  @override
  double get totalBuyAmount;
  @override
  double get totalSellAmount;
  @override
  List<TradeModel> get recentTrades;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;

  /// Create a copy of DashboardSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardSummaryImplCopyWith<_$DashboardSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
