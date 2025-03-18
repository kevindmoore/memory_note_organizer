// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TodoUser {

 String? get sessionId; String get email; String? get password; String? get name; String? get userId;
/// Create a copy of TodoUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodoUserCopyWith<TodoUser> get copyWith => _$TodoUserCopyWithImpl<TodoUser>(this as TodoUser, _$identity);

  /// Serializes this TodoUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoUser&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.name, name) || other.name == name)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId,email,password,name,userId);

@override
String toString() {
  return 'TodoUser(sessionId: $sessionId, email: $email, password: $password, name: $name, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $TodoUserCopyWith<$Res>  {
  factory $TodoUserCopyWith(TodoUser value, $Res Function(TodoUser) _then) = _$TodoUserCopyWithImpl;
@useResult
$Res call({
 String? sessionId, String email, String? password, String? name, String? userId
});




}
/// @nodoc
class _$TodoUserCopyWithImpl<$Res>
    implements $TodoUserCopyWith<$Res> {
  _$TodoUserCopyWithImpl(this._self, this._then);

  final TodoUser _self;
  final $Res Function(TodoUser) _then;

/// Create a copy of TodoUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = freezed,Object? email = null,Object? password = freezed,Object? name = freezed,Object? userId = freezed,}) {
  return _then(_self.copyWith(
sessionId: freezed == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String?,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _TodoUser implements TodoUser {
  const _TodoUser({this.sessionId, required this.email, this.password, this.name, this.userId});
  factory _TodoUser.fromJson(Map<String, dynamic> json) => _$TodoUserFromJson(json);

@override final  String? sessionId;
@override final  String email;
@override final  String? password;
@override final  String? name;
@override final  String? userId;

/// Create a copy of TodoUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodoUserCopyWith<_TodoUser> get copyWith => __$TodoUserCopyWithImpl<_TodoUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TodoUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodoUser&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.name, name) || other.name == name)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId,email,password,name,userId);

@override
String toString() {
  return 'TodoUser(sessionId: $sessionId, email: $email, password: $password, name: $name, userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$TodoUserCopyWith<$Res> implements $TodoUserCopyWith<$Res> {
  factory _$TodoUserCopyWith(_TodoUser value, $Res Function(_TodoUser) _then) = __$TodoUserCopyWithImpl;
@override @useResult
$Res call({
 String? sessionId, String email, String? password, String? name, String? userId
});




}
/// @nodoc
class __$TodoUserCopyWithImpl<$Res>
    implements _$TodoUserCopyWith<$Res> {
  __$TodoUserCopyWithImpl(this._self, this._then);

  final _TodoUser _self;
  final $Res Function(_TodoUser) _then;

/// Create a copy of TodoUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = freezed,Object? email = null,Object? password = freezed,Object? name = freezed,Object? userId = freezed,}) {
  return _then(_TodoUser(
sessionId: freezed == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String?,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
