// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'current_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CurrentState {

 String get currentFiles;@JsonKey(includeIfNull: false) int? get id;@JsonKey(name: 'user_id', includeIfNull: false) String? get userId;@JsonKey(name: 'last_updated', includeIfNull: false) DateTime? get lastUpdated;
/// Create a copy of CurrentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrentStateCopyWith<CurrentState> get copyWith => _$CurrentStateCopyWithImpl<CurrentState>(this as CurrentState, _$identity);

  /// Serializes this CurrentState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrentState&&(identical(other.currentFiles, currentFiles) || other.currentFiles == currentFiles)&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentFiles,id,userId,lastUpdated);

@override
String toString() {
  return 'CurrentState(currentFiles: $currentFiles, id: $id, userId: $userId, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class $CurrentStateCopyWith<$Res>  {
  factory $CurrentStateCopyWith(CurrentState value, $Res Function(CurrentState) _then) = _$CurrentStateCopyWithImpl;
@useResult
$Res call({
 String currentFiles,@JsonKey(includeIfNull: false) int? id,@JsonKey(name: 'user_id', includeIfNull: false) String? userId,@JsonKey(name: 'last_updated', includeIfNull: false) DateTime? lastUpdated
});




}
/// @nodoc
class _$CurrentStateCopyWithImpl<$Res>
    implements $CurrentStateCopyWith<$Res> {
  _$CurrentStateCopyWithImpl(this._self, this._then);

  final CurrentState _self;
  final $Res Function(CurrentState) _then;

/// Create a copy of CurrentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentFiles = null,Object? id = freezed,Object? userId = freezed,Object? lastUpdated = freezed,}) {
  return _then(_self.copyWith(
currentFiles: null == currentFiles ? _self.currentFiles : currentFiles // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// @nodoc

@JsonSerializable(explicitToJson: true)
class _CurrentState implements CurrentState {
  const _CurrentState({required this.currentFiles, @JsonKey(includeIfNull: false) this.id, @JsonKey(name: 'user_id', includeIfNull: false) this.userId, @JsonKey(name: 'last_updated', includeIfNull: false) this.lastUpdated});
  factory _CurrentState.fromJson(Map<String, dynamic> json) => _$CurrentStateFromJson(json);

@override final  String currentFiles;
@override@JsonKey(includeIfNull: false) final  int? id;
@override@JsonKey(name: 'user_id', includeIfNull: false) final  String? userId;
@override@JsonKey(name: 'last_updated', includeIfNull: false) final  DateTime? lastUpdated;

/// Create a copy of CurrentState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrentStateCopyWith<_CurrentState> get copyWith => __$CurrentStateCopyWithImpl<_CurrentState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CurrentStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrentState&&(identical(other.currentFiles, currentFiles) || other.currentFiles == currentFiles)&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentFiles,id,userId,lastUpdated);

@override
String toString() {
  return 'CurrentState(currentFiles: $currentFiles, id: $id, userId: $userId, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class _$CurrentStateCopyWith<$Res> implements $CurrentStateCopyWith<$Res> {
  factory _$CurrentStateCopyWith(_CurrentState value, $Res Function(_CurrentState) _then) = __$CurrentStateCopyWithImpl;
@override @useResult
$Res call({
 String currentFiles,@JsonKey(includeIfNull: false) int? id,@JsonKey(name: 'user_id', includeIfNull: false) String? userId,@JsonKey(name: 'last_updated', includeIfNull: false) DateTime? lastUpdated
});




}
/// @nodoc
class __$CurrentStateCopyWithImpl<$Res>
    implements _$CurrentStateCopyWith<$Res> {
  __$CurrentStateCopyWithImpl(this._self, this._then);

  final _CurrentState _self;
  final $Res Function(_CurrentState) _then;

/// Create a copy of CurrentState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentFiles = null,Object? id = freezed,Object? userId = freezed,Object? lastUpdated = freezed,}) {
  return _then(_CurrentState(
currentFiles: null == currentFiles ? _self.currentFiles : currentFiles // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
