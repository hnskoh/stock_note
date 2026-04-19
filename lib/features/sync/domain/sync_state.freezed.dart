// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SyncState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime? lastSyncedAt) idle,
    required TResult Function() checkingOut,
    required TResult Function() uploading,
    required TResult Function(DateTime syncedAt) success,
    required TResult Function() offline,
    required TResult Function(String message) error,
    required TResult Function(DateTime lockCreatedAt) locked,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime? lastSyncedAt)? idle,
    TResult? Function()? checkingOut,
    TResult? Function()? uploading,
    TResult? Function(DateTime syncedAt)? success,
    TResult? Function()? offline,
    TResult? Function(String message)? error,
    TResult? Function(DateTime lockCreatedAt)? locked,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime? lastSyncedAt)? idle,
    TResult Function()? checkingOut,
    TResult Function()? uploading,
    TResult Function(DateTime syncedAt)? success,
    TResult Function()? offline,
    TResult Function(String message)? error,
    TResult Function(DateTime lockCreatedAt)? locked,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SyncIdle value) idle,
    required TResult Function(SyncCheckingOut value) checkingOut,
    required TResult Function(SyncUploading value) uploading,
    required TResult Function(SyncSuccess value) success,
    required TResult Function(SyncOffline value) offline,
    required TResult Function(SyncError value) error,
    required TResult Function(SyncLocked value) locked,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SyncIdle value)? idle,
    TResult? Function(SyncCheckingOut value)? checkingOut,
    TResult? Function(SyncUploading value)? uploading,
    TResult? Function(SyncSuccess value)? success,
    TResult? Function(SyncOffline value)? offline,
    TResult? Function(SyncError value)? error,
    TResult? Function(SyncLocked value)? locked,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SyncIdle value)? idle,
    TResult Function(SyncCheckingOut value)? checkingOut,
    TResult Function(SyncUploading value)? uploading,
    TResult Function(SyncSuccess value)? success,
    TResult Function(SyncOffline value)? offline,
    TResult Function(SyncError value)? error,
    TResult Function(SyncLocked value)? locked,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncStateCopyWith<$Res> {
  factory $SyncStateCopyWith(SyncState value, $Res Function(SyncState) then) =
      _$SyncStateCopyWithImpl<$Res, SyncState>;
}

/// @nodoc
class _$SyncStateCopyWithImpl<$Res, $Val extends SyncState>
    implements $SyncStateCopyWith<$Res> {
  _$SyncStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SyncIdleImplCopyWith<$Res> {
  factory _$$SyncIdleImplCopyWith(
          _$SyncIdleImpl value, $Res Function(_$SyncIdleImpl) then) =
      __$$SyncIdleImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime? lastSyncedAt});
}

/// @nodoc
class __$$SyncIdleImplCopyWithImpl<$Res>
    extends _$SyncStateCopyWithImpl<$Res, _$SyncIdleImpl>
    implements _$$SyncIdleImplCopyWith<$Res> {
  __$$SyncIdleImplCopyWithImpl(
      _$SyncIdleImpl _value, $Res Function(_$SyncIdleImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastSyncedAt = freezed,
  }) {
    return _then(_$SyncIdleImpl(
      lastSyncedAt: freezed == lastSyncedAt
          ? _value.lastSyncedAt
          : lastSyncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$SyncIdleImpl implements SyncIdle {
  const _$SyncIdleImpl({this.lastSyncedAt});

  @override
  final DateTime? lastSyncedAt;

  @override
  String toString() {
    return 'SyncState.idle(lastSyncedAt: $lastSyncedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncIdleImpl &&
            (identical(other.lastSyncedAt, lastSyncedAt) ||
                other.lastSyncedAt == lastSyncedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lastSyncedAt);

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncIdleImplCopyWith<_$SyncIdleImpl> get copyWith =>
      __$$SyncIdleImplCopyWithImpl<_$SyncIdleImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime? lastSyncedAt) idle,
    required TResult Function() checkingOut,
    required TResult Function() uploading,
    required TResult Function(DateTime syncedAt) success,
    required TResult Function() offline,
    required TResult Function(String message) error,
    required TResult Function(DateTime lockCreatedAt) locked,
  }) {
    return idle(lastSyncedAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime? lastSyncedAt)? idle,
    TResult? Function()? checkingOut,
    TResult? Function()? uploading,
    TResult? Function(DateTime syncedAt)? success,
    TResult? Function()? offline,
    TResult? Function(String message)? error,
    TResult? Function(DateTime lockCreatedAt)? locked,
  }) {
    return idle?.call(lastSyncedAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime? lastSyncedAt)? idle,
    TResult Function()? checkingOut,
    TResult Function()? uploading,
    TResult Function(DateTime syncedAt)? success,
    TResult Function()? offline,
    TResult Function(String message)? error,
    TResult Function(DateTime lockCreatedAt)? locked,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(lastSyncedAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SyncIdle value) idle,
    required TResult Function(SyncCheckingOut value) checkingOut,
    required TResult Function(SyncUploading value) uploading,
    required TResult Function(SyncSuccess value) success,
    required TResult Function(SyncOffline value) offline,
    required TResult Function(SyncError value) error,
    required TResult Function(SyncLocked value) locked,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SyncIdle value)? idle,
    TResult? Function(SyncCheckingOut value)? checkingOut,
    TResult? Function(SyncUploading value)? uploading,
    TResult? Function(SyncSuccess value)? success,
    TResult? Function(SyncOffline value)? offline,
    TResult? Function(SyncError value)? error,
    TResult? Function(SyncLocked value)? locked,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SyncIdle value)? idle,
    TResult Function(SyncCheckingOut value)? checkingOut,
    TResult Function(SyncUploading value)? uploading,
    TResult Function(SyncSuccess value)? success,
    TResult Function(SyncOffline value)? offline,
    TResult Function(SyncError value)? error,
    TResult Function(SyncLocked value)? locked,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class SyncIdle implements SyncState {
  const factory SyncIdle({final DateTime? lastSyncedAt}) = _$SyncIdleImpl;

  DateTime? get lastSyncedAt;

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncIdleImplCopyWith<_$SyncIdleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SyncCheckingOutImplCopyWith<$Res> {
  factory _$$SyncCheckingOutImplCopyWith(_$SyncCheckingOutImpl value,
          $Res Function(_$SyncCheckingOutImpl) then) =
      __$$SyncCheckingOutImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SyncCheckingOutImplCopyWithImpl<$Res>
    extends _$SyncStateCopyWithImpl<$Res, _$SyncCheckingOutImpl>
    implements _$$SyncCheckingOutImplCopyWith<$Res> {
  __$$SyncCheckingOutImplCopyWithImpl(
      _$SyncCheckingOutImpl _value, $Res Function(_$SyncCheckingOutImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SyncCheckingOutImpl implements SyncCheckingOut {
  const _$SyncCheckingOutImpl();

  @override
  String toString() {
    return 'SyncState.checkingOut()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SyncCheckingOutImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime? lastSyncedAt) idle,
    required TResult Function() checkingOut,
    required TResult Function() uploading,
    required TResult Function(DateTime syncedAt) success,
    required TResult Function() offline,
    required TResult Function(String message) error,
    required TResult Function(DateTime lockCreatedAt) locked,
  }) {
    return checkingOut();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime? lastSyncedAt)? idle,
    TResult? Function()? checkingOut,
    TResult? Function()? uploading,
    TResult? Function(DateTime syncedAt)? success,
    TResult? Function()? offline,
    TResult? Function(String message)? error,
    TResult? Function(DateTime lockCreatedAt)? locked,
  }) {
    return checkingOut?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime? lastSyncedAt)? idle,
    TResult Function()? checkingOut,
    TResult Function()? uploading,
    TResult Function(DateTime syncedAt)? success,
    TResult Function()? offline,
    TResult Function(String message)? error,
    TResult Function(DateTime lockCreatedAt)? locked,
    required TResult orElse(),
  }) {
    if (checkingOut != null) {
      return checkingOut();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SyncIdle value) idle,
    required TResult Function(SyncCheckingOut value) checkingOut,
    required TResult Function(SyncUploading value) uploading,
    required TResult Function(SyncSuccess value) success,
    required TResult Function(SyncOffline value) offline,
    required TResult Function(SyncError value) error,
    required TResult Function(SyncLocked value) locked,
  }) {
    return checkingOut(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SyncIdle value)? idle,
    TResult? Function(SyncCheckingOut value)? checkingOut,
    TResult? Function(SyncUploading value)? uploading,
    TResult? Function(SyncSuccess value)? success,
    TResult? Function(SyncOffline value)? offline,
    TResult? Function(SyncError value)? error,
    TResult? Function(SyncLocked value)? locked,
  }) {
    return checkingOut?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SyncIdle value)? idle,
    TResult Function(SyncCheckingOut value)? checkingOut,
    TResult Function(SyncUploading value)? uploading,
    TResult Function(SyncSuccess value)? success,
    TResult Function(SyncOffline value)? offline,
    TResult Function(SyncError value)? error,
    TResult Function(SyncLocked value)? locked,
    required TResult orElse(),
  }) {
    if (checkingOut != null) {
      return checkingOut(this);
    }
    return orElse();
  }
}

abstract class SyncCheckingOut implements SyncState {
  const factory SyncCheckingOut() = _$SyncCheckingOutImpl;
}

/// @nodoc
abstract class _$$SyncUploadingImplCopyWith<$Res> {
  factory _$$SyncUploadingImplCopyWith(
          _$SyncUploadingImpl value, $Res Function(_$SyncUploadingImpl) then) =
      __$$SyncUploadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SyncUploadingImplCopyWithImpl<$Res>
    extends _$SyncStateCopyWithImpl<$Res, _$SyncUploadingImpl>
    implements _$$SyncUploadingImplCopyWith<$Res> {
  __$$SyncUploadingImplCopyWithImpl(
      _$SyncUploadingImpl _value, $Res Function(_$SyncUploadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SyncUploadingImpl implements SyncUploading {
  const _$SyncUploadingImpl();

  @override
  String toString() {
    return 'SyncState.uploading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SyncUploadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime? lastSyncedAt) idle,
    required TResult Function() checkingOut,
    required TResult Function() uploading,
    required TResult Function(DateTime syncedAt) success,
    required TResult Function() offline,
    required TResult Function(String message) error,
    required TResult Function(DateTime lockCreatedAt) locked,
  }) {
    return uploading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime? lastSyncedAt)? idle,
    TResult? Function()? checkingOut,
    TResult? Function()? uploading,
    TResult? Function(DateTime syncedAt)? success,
    TResult? Function()? offline,
    TResult? Function(String message)? error,
    TResult? Function(DateTime lockCreatedAt)? locked,
  }) {
    return uploading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime? lastSyncedAt)? idle,
    TResult Function()? checkingOut,
    TResult Function()? uploading,
    TResult Function(DateTime syncedAt)? success,
    TResult Function()? offline,
    TResult Function(String message)? error,
    TResult Function(DateTime lockCreatedAt)? locked,
    required TResult orElse(),
  }) {
    if (uploading != null) {
      return uploading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SyncIdle value) idle,
    required TResult Function(SyncCheckingOut value) checkingOut,
    required TResult Function(SyncUploading value) uploading,
    required TResult Function(SyncSuccess value) success,
    required TResult Function(SyncOffline value) offline,
    required TResult Function(SyncError value) error,
    required TResult Function(SyncLocked value) locked,
  }) {
    return uploading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SyncIdle value)? idle,
    TResult? Function(SyncCheckingOut value)? checkingOut,
    TResult? Function(SyncUploading value)? uploading,
    TResult? Function(SyncSuccess value)? success,
    TResult? Function(SyncOffline value)? offline,
    TResult? Function(SyncError value)? error,
    TResult? Function(SyncLocked value)? locked,
  }) {
    return uploading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SyncIdle value)? idle,
    TResult Function(SyncCheckingOut value)? checkingOut,
    TResult Function(SyncUploading value)? uploading,
    TResult Function(SyncSuccess value)? success,
    TResult Function(SyncOffline value)? offline,
    TResult Function(SyncError value)? error,
    TResult Function(SyncLocked value)? locked,
    required TResult orElse(),
  }) {
    if (uploading != null) {
      return uploading(this);
    }
    return orElse();
  }
}

abstract class SyncUploading implements SyncState {
  const factory SyncUploading() = _$SyncUploadingImpl;
}

/// @nodoc
abstract class _$$SyncSuccessImplCopyWith<$Res> {
  factory _$$SyncSuccessImplCopyWith(
          _$SyncSuccessImpl value, $Res Function(_$SyncSuccessImpl) then) =
      __$$SyncSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime syncedAt});
}

/// @nodoc
class __$$SyncSuccessImplCopyWithImpl<$Res>
    extends _$SyncStateCopyWithImpl<$Res, _$SyncSuccessImpl>
    implements _$$SyncSuccessImplCopyWith<$Res> {
  __$$SyncSuccessImplCopyWithImpl(
      _$SyncSuccessImpl _value, $Res Function(_$SyncSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? syncedAt = null,
  }) {
    return _then(_$SyncSuccessImpl(
      syncedAt: null == syncedAt
          ? _value.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$SyncSuccessImpl implements SyncSuccess {
  const _$SyncSuccessImpl({required this.syncedAt});

  @override
  final DateTime syncedAt;

  @override
  String toString() {
    return 'SyncState.success(syncedAt: $syncedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncSuccessImpl &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, syncedAt);

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncSuccessImplCopyWith<_$SyncSuccessImpl> get copyWith =>
      __$$SyncSuccessImplCopyWithImpl<_$SyncSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime? lastSyncedAt) idle,
    required TResult Function() checkingOut,
    required TResult Function() uploading,
    required TResult Function(DateTime syncedAt) success,
    required TResult Function() offline,
    required TResult Function(String message) error,
    required TResult Function(DateTime lockCreatedAt) locked,
  }) {
    return success(syncedAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime? lastSyncedAt)? idle,
    TResult? Function()? checkingOut,
    TResult? Function()? uploading,
    TResult? Function(DateTime syncedAt)? success,
    TResult? Function()? offline,
    TResult? Function(String message)? error,
    TResult? Function(DateTime lockCreatedAt)? locked,
  }) {
    return success?.call(syncedAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime? lastSyncedAt)? idle,
    TResult Function()? checkingOut,
    TResult Function()? uploading,
    TResult Function(DateTime syncedAt)? success,
    TResult Function()? offline,
    TResult Function(String message)? error,
    TResult Function(DateTime lockCreatedAt)? locked,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(syncedAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SyncIdle value) idle,
    required TResult Function(SyncCheckingOut value) checkingOut,
    required TResult Function(SyncUploading value) uploading,
    required TResult Function(SyncSuccess value) success,
    required TResult Function(SyncOffline value) offline,
    required TResult Function(SyncError value) error,
    required TResult Function(SyncLocked value) locked,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SyncIdle value)? idle,
    TResult? Function(SyncCheckingOut value)? checkingOut,
    TResult? Function(SyncUploading value)? uploading,
    TResult? Function(SyncSuccess value)? success,
    TResult? Function(SyncOffline value)? offline,
    TResult? Function(SyncError value)? error,
    TResult? Function(SyncLocked value)? locked,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SyncIdle value)? idle,
    TResult Function(SyncCheckingOut value)? checkingOut,
    TResult Function(SyncUploading value)? uploading,
    TResult Function(SyncSuccess value)? success,
    TResult Function(SyncOffline value)? offline,
    TResult Function(SyncError value)? error,
    TResult Function(SyncLocked value)? locked,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class SyncSuccess implements SyncState {
  const factory SyncSuccess({required final DateTime syncedAt}) =
      _$SyncSuccessImpl;

  DateTime get syncedAt;

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncSuccessImplCopyWith<_$SyncSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SyncOfflineImplCopyWith<$Res> {
  factory _$$SyncOfflineImplCopyWith(
          _$SyncOfflineImpl value, $Res Function(_$SyncOfflineImpl) then) =
      __$$SyncOfflineImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SyncOfflineImplCopyWithImpl<$Res>
    extends _$SyncStateCopyWithImpl<$Res, _$SyncOfflineImpl>
    implements _$$SyncOfflineImplCopyWith<$Res> {
  __$$SyncOfflineImplCopyWithImpl(
      _$SyncOfflineImpl _value, $Res Function(_$SyncOfflineImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SyncOfflineImpl implements SyncOffline {
  const _$SyncOfflineImpl();

  @override
  String toString() {
    return 'SyncState.offline()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SyncOfflineImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime? lastSyncedAt) idle,
    required TResult Function() checkingOut,
    required TResult Function() uploading,
    required TResult Function(DateTime syncedAt) success,
    required TResult Function() offline,
    required TResult Function(String message) error,
    required TResult Function(DateTime lockCreatedAt) locked,
  }) {
    return offline();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime? lastSyncedAt)? idle,
    TResult? Function()? checkingOut,
    TResult? Function()? uploading,
    TResult? Function(DateTime syncedAt)? success,
    TResult? Function()? offline,
    TResult? Function(String message)? error,
    TResult? Function(DateTime lockCreatedAt)? locked,
  }) {
    return offline?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime? lastSyncedAt)? idle,
    TResult Function()? checkingOut,
    TResult Function()? uploading,
    TResult Function(DateTime syncedAt)? success,
    TResult Function()? offline,
    TResult Function(String message)? error,
    TResult Function(DateTime lockCreatedAt)? locked,
    required TResult orElse(),
  }) {
    if (offline != null) {
      return offline();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SyncIdle value) idle,
    required TResult Function(SyncCheckingOut value) checkingOut,
    required TResult Function(SyncUploading value) uploading,
    required TResult Function(SyncSuccess value) success,
    required TResult Function(SyncOffline value) offline,
    required TResult Function(SyncError value) error,
    required TResult Function(SyncLocked value) locked,
  }) {
    return offline(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SyncIdle value)? idle,
    TResult? Function(SyncCheckingOut value)? checkingOut,
    TResult? Function(SyncUploading value)? uploading,
    TResult? Function(SyncSuccess value)? success,
    TResult? Function(SyncOffline value)? offline,
    TResult? Function(SyncError value)? error,
    TResult? Function(SyncLocked value)? locked,
  }) {
    return offline?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SyncIdle value)? idle,
    TResult Function(SyncCheckingOut value)? checkingOut,
    TResult Function(SyncUploading value)? uploading,
    TResult Function(SyncSuccess value)? success,
    TResult Function(SyncOffline value)? offline,
    TResult Function(SyncError value)? error,
    TResult Function(SyncLocked value)? locked,
    required TResult orElse(),
  }) {
    if (offline != null) {
      return offline(this);
    }
    return orElse();
  }
}

abstract class SyncOffline implements SyncState {
  const factory SyncOffline() = _$SyncOfflineImpl;
}

/// @nodoc
abstract class _$$SyncErrorImplCopyWith<$Res> {
  factory _$$SyncErrorImplCopyWith(
          _$SyncErrorImpl value, $Res Function(_$SyncErrorImpl) then) =
      __$$SyncErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$SyncErrorImplCopyWithImpl<$Res>
    extends _$SyncStateCopyWithImpl<$Res, _$SyncErrorImpl>
    implements _$$SyncErrorImplCopyWith<$Res> {
  __$$SyncErrorImplCopyWithImpl(
      _$SyncErrorImpl _value, $Res Function(_$SyncErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$SyncErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SyncErrorImpl implements SyncError {
  const _$SyncErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'SyncState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncErrorImplCopyWith<_$SyncErrorImpl> get copyWith =>
      __$$SyncErrorImplCopyWithImpl<_$SyncErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime? lastSyncedAt) idle,
    required TResult Function() checkingOut,
    required TResult Function() uploading,
    required TResult Function(DateTime syncedAt) success,
    required TResult Function() offline,
    required TResult Function(String message) error,
    required TResult Function(DateTime lockCreatedAt) locked,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime? lastSyncedAt)? idle,
    TResult? Function()? checkingOut,
    TResult? Function()? uploading,
    TResult? Function(DateTime syncedAt)? success,
    TResult? Function()? offline,
    TResult? Function(String message)? error,
    TResult? Function(DateTime lockCreatedAt)? locked,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime? lastSyncedAt)? idle,
    TResult Function()? checkingOut,
    TResult Function()? uploading,
    TResult Function(DateTime syncedAt)? success,
    TResult Function()? offline,
    TResult Function(String message)? error,
    TResult Function(DateTime lockCreatedAt)? locked,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SyncIdle value) idle,
    required TResult Function(SyncCheckingOut value) checkingOut,
    required TResult Function(SyncUploading value) uploading,
    required TResult Function(SyncSuccess value) success,
    required TResult Function(SyncOffline value) offline,
    required TResult Function(SyncError value) error,
    required TResult Function(SyncLocked value) locked,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SyncIdle value)? idle,
    TResult? Function(SyncCheckingOut value)? checkingOut,
    TResult? Function(SyncUploading value)? uploading,
    TResult? Function(SyncSuccess value)? success,
    TResult? Function(SyncOffline value)? offline,
    TResult? Function(SyncError value)? error,
    TResult? Function(SyncLocked value)? locked,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SyncIdle value)? idle,
    TResult Function(SyncCheckingOut value)? checkingOut,
    TResult Function(SyncUploading value)? uploading,
    TResult Function(SyncSuccess value)? success,
    TResult Function(SyncOffline value)? offline,
    TResult Function(SyncError value)? error,
    TResult Function(SyncLocked value)? locked,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class SyncError implements SyncState {
  const factory SyncError({required final String message}) = _$SyncErrorImpl;

  String get message;

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncErrorImplCopyWith<_$SyncErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SyncLockedImplCopyWith<$Res> {
  factory _$$SyncLockedImplCopyWith(
          _$SyncLockedImpl value, $Res Function(_$SyncLockedImpl) then) =
      __$$SyncLockedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime lockCreatedAt});
}

/// @nodoc
class __$$SyncLockedImplCopyWithImpl<$Res>
    extends _$SyncStateCopyWithImpl<$Res, _$SyncLockedImpl>
    implements _$$SyncLockedImplCopyWith<$Res> {
  __$$SyncLockedImplCopyWithImpl(
      _$SyncLockedImpl _value, $Res Function(_$SyncLockedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lockCreatedAt = null,
  }) {
    return _then(_$SyncLockedImpl(
      lockCreatedAt: null == lockCreatedAt
          ? _value.lockCreatedAt
          : lockCreatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$SyncLockedImpl implements SyncLocked {
  const _$SyncLockedImpl({required this.lockCreatedAt});

  @override
  final DateTime lockCreatedAt;

  @override
  String toString() {
    return 'SyncState.locked(lockCreatedAt: $lockCreatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncLockedImpl &&
            (identical(other.lockCreatedAt, lockCreatedAt) ||
                other.lockCreatedAt == lockCreatedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lockCreatedAt);

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncLockedImplCopyWith<_$SyncLockedImpl> get copyWith =>
      __$$SyncLockedImplCopyWithImpl<_$SyncLockedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime? lastSyncedAt) idle,
    required TResult Function() checkingOut,
    required TResult Function() uploading,
    required TResult Function(DateTime syncedAt) success,
    required TResult Function() offline,
    required TResult Function(String message) error,
    required TResult Function(DateTime lockCreatedAt) locked,
  }) {
    return locked(lockCreatedAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime? lastSyncedAt)? idle,
    TResult? Function()? checkingOut,
    TResult? Function()? uploading,
    TResult? Function(DateTime syncedAt)? success,
    TResult? Function()? offline,
    TResult? Function(String message)? error,
    TResult? Function(DateTime lockCreatedAt)? locked,
  }) {
    return locked?.call(lockCreatedAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime? lastSyncedAt)? idle,
    TResult Function()? checkingOut,
    TResult Function()? uploading,
    TResult Function(DateTime syncedAt)? success,
    TResult Function()? offline,
    TResult Function(String message)? error,
    TResult Function(DateTime lockCreatedAt)? locked,
    required TResult orElse(),
  }) {
    if (locked != null) {
      return locked(lockCreatedAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SyncIdle value) idle,
    required TResult Function(SyncCheckingOut value) checkingOut,
    required TResult Function(SyncUploading value) uploading,
    required TResult Function(SyncSuccess value) success,
    required TResult Function(SyncOffline value) offline,
    required TResult Function(SyncError value) error,
    required TResult Function(SyncLocked value) locked,
  }) {
    return locked(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SyncIdle value)? idle,
    TResult? Function(SyncCheckingOut value)? checkingOut,
    TResult? Function(SyncUploading value)? uploading,
    TResult? Function(SyncSuccess value)? success,
    TResult? Function(SyncOffline value)? offline,
    TResult? Function(SyncError value)? error,
    TResult? Function(SyncLocked value)? locked,
  }) {
    return locked?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SyncIdle value)? idle,
    TResult Function(SyncCheckingOut value)? checkingOut,
    TResult Function(SyncUploading value)? uploading,
    TResult Function(SyncSuccess value)? success,
    TResult Function(SyncOffline value)? offline,
    TResult Function(SyncError value)? error,
    TResult Function(SyncLocked value)? locked,
    required TResult orElse(),
  }) {
    if (locked != null) {
      return locked(this);
    }
    return orElse();
  }
}

abstract class SyncLocked implements SyncState {
  const factory SyncLocked({required final DateTime lockCreatedAt}) =
      _$SyncLockedImpl;

  DateTime get lockCreatedAt;

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncLockedImplCopyWith<_$SyncLockedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
