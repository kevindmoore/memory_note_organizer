// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TodoUser _$TodoUserFromJson(Map<String, dynamic> json) {
  return _TodoUser.fromJson(json);
}

/// @nodoc
mixin _$TodoUser {
  String? get sessionId => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TodoUserCopyWith<TodoUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoUserCopyWith<$Res> {
  factory $TodoUserCopyWith(TodoUser value, $Res Function(TodoUser) then) =
      _$TodoUserCopyWithImpl<$Res, TodoUser>;
  @useResult
  $Res call(
      {String? sessionId,
      String email,
      String? password,
      String? name,
      String? userId});
}

/// @nodoc
class _$TodoUserCopyWithImpl<$Res, $Val extends TodoUser>
    implements $TodoUserCopyWith<$Res> {
  _$TodoUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = freezed,
    Object? email = null,
    Object? password = freezed,
    Object? name = freezed,
    Object? userId = freezed,
  }) {
    return _then(_value.copyWith(
      sessionId: freezed == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String?,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TodoUserImplCopyWith<$Res>
    implements $TodoUserCopyWith<$Res> {
  factory _$$TodoUserImplCopyWith(
          _$TodoUserImpl value, $Res Function(_$TodoUserImpl) then) =
      __$$TodoUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? sessionId,
      String email,
      String? password,
      String? name,
      String? userId});
}

/// @nodoc
class __$$TodoUserImplCopyWithImpl<$Res>
    extends _$TodoUserCopyWithImpl<$Res, _$TodoUserImpl>
    implements _$$TodoUserImplCopyWith<$Res> {
  __$$TodoUserImplCopyWithImpl(
      _$TodoUserImpl _value, $Res Function(_$TodoUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = freezed,
    Object? email = null,
    Object? password = freezed,
    Object? name = freezed,
    Object? userId = freezed,
  }) {
    return _then(_$TodoUserImpl(
      sessionId: freezed == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String?,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TodoUserImpl implements _TodoUser {
  const _$TodoUserImpl(
      {this.sessionId,
      required this.email,
      this.password,
      this.name,
      this.userId});

  factory _$TodoUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$TodoUserImplFromJson(json);

  @override
  final String? sessionId;
  @override
  final String email;
  @override
  final String? password;
  @override
  final String? name;
  @override
  final String? userId;

  @override
  String toString() {
    return 'TodoUser(sessionId: $sessionId, email: $email, password: $password, name: $name, userId: $userId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodoUserImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, sessionId, email, password, name, userId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoUserImplCopyWith<_$TodoUserImpl> get copyWith =>
      __$$TodoUserImplCopyWithImpl<_$TodoUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TodoUserImplToJson(
      this,
    );
  }
}

abstract class _TodoUser implements TodoUser {
  const factory _TodoUser(
      {final String? sessionId,
      required final String email,
      final String? password,
      final String? name,
      final String? userId}) = _$TodoUserImpl;

  factory _TodoUser.fromJson(Map<String, dynamic> json) =
      _$TodoUserImpl.fromJson;

  @override
  String? get sessionId;
  @override
  String get email;
  @override
  String? get password;
  @override
  String? get name;
  @override
  String? get userId;
  @override
  @JsonKey(ignore: true)
  _$$TodoUserImplCopyWith<_$TodoUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
