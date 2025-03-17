// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'current_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CurrentState _$CurrentStateFromJson(Map<String, dynamic> json) {
  return _CurrentState.fromJson(json);
}

/// @nodoc
mixin _$CurrentState {
  String get currentFiles => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id', includeIfNull: false)
  String? get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_updated', includeIfNull: false)
  DateTime? get lastUpdated => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CurrentStateCopyWith<CurrentState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrentStateCopyWith<$Res> {
  factory $CurrentStateCopyWith(
          CurrentState value, $Res Function(CurrentState) then) =
      _$CurrentStateCopyWithImpl<$Res, CurrentState>;
  @useResult
  $Res call(
      {String currentFiles,
      @JsonKey(includeIfNull: false) int? id,
      @JsonKey(name: 'user_id', includeIfNull: false) String? userId,
      @JsonKey(name: 'last_updated', includeIfNull: false)
      DateTime? lastUpdated});
}

/// @nodoc
class _$CurrentStateCopyWithImpl<$Res, $Val extends CurrentState>
    implements $CurrentStateCopyWith<$Res> {
  _$CurrentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentFiles = null,
    Object? id = freezed,
    Object? userId = freezed,
    Object? lastUpdated = freezed,
  }) {
    return _then(_value.copyWith(
      currentFiles: null == currentFiles
          ? _value.currentFiles
          : currentFiles // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CurrentStateImplCopyWith<$Res>
    implements $CurrentStateCopyWith<$Res> {
  factory _$$CurrentStateImplCopyWith(
          _$CurrentStateImpl value, $Res Function(_$CurrentStateImpl) then) =
      __$$CurrentStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String currentFiles,
      @JsonKey(includeIfNull: false) int? id,
      @JsonKey(name: 'user_id', includeIfNull: false) String? userId,
      @JsonKey(name: 'last_updated', includeIfNull: false)
      DateTime? lastUpdated});
}

/// @nodoc
class __$$CurrentStateImplCopyWithImpl<$Res>
    extends _$CurrentStateCopyWithImpl<$Res, _$CurrentStateImpl>
    implements _$$CurrentStateImplCopyWith<$Res> {
  __$$CurrentStateImplCopyWithImpl(
      _$CurrentStateImpl _value, $Res Function(_$CurrentStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentFiles = null,
    Object? id = freezed,
    Object? userId = freezed,
    Object? lastUpdated = freezed,
  }) {
    return _then(_$CurrentStateImpl(
      currentFiles: null == currentFiles
          ? _value.currentFiles
          : currentFiles // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$CurrentStateImpl implements _CurrentState {
  const _$CurrentStateImpl(
      {required this.currentFiles,
      @JsonKey(includeIfNull: false) this.id,
      @JsonKey(name: 'user_id', includeIfNull: false) this.userId,
      @JsonKey(name: 'last_updated', includeIfNull: false) this.lastUpdated});

  factory _$CurrentStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$CurrentStateImplFromJson(json);

  @override
  final String currentFiles;
  @override
  @JsonKey(includeIfNull: false)
  final int? id;
  @override
  @JsonKey(name: 'user_id', includeIfNull: false)
  final String? userId;
  @override
  @JsonKey(name: 'last_updated', includeIfNull: false)
  final DateTime? lastUpdated;

  @override
  String toString() {
    return 'CurrentState(currentFiles: $currentFiles, id: $id, userId: $userId, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CurrentStateImpl &&
            (identical(other.currentFiles, currentFiles) ||
                other.currentFiles == currentFiles) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, currentFiles, id, userId, lastUpdated);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CurrentStateImplCopyWith<_$CurrentStateImpl> get copyWith =>
      __$$CurrentStateImplCopyWithImpl<_$CurrentStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CurrentStateImplToJson(
      this,
    );
  }
}

abstract class _CurrentState implements CurrentState {
  const factory _CurrentState(
      {required final String currentFiles,
      @JsonKey(includeIfNull: false) final int? id,
      @JsonKey(name: 'user_id', includeIfNull: false) final String? userId,
      @JsonKey(name: 'last_updated', includeIfNull: false)
      final DateTime? lastUpdated}) = _$CurrentStateImpl;

  factory _CurrentState.fromJson(Map<String, dynamic> json) =
      _$CurrentStateImpl.fromJson;

  @override
  String get currentFiles;
  @override
  @JsonKey(includeIfNull: false)
  int? get id;
  @override
  @JsonKey(name: 'user_id', includeIfNull: false)
  String? get userId;
  @override
  @JsonKey(name: 'last_updated', includeIfNull: false)
  DateTime? get lastUpdated;
  @override
  @JsonKey(ignore: true)
  _$$CurrentStateImplCopyWith<_$CurrentStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
