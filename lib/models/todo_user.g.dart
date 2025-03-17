// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoUserImpl _$$TodoUserImplFromJson(Map<String, dynamic> json) =>
    _$TodoUserImpl(
      sessionId: json['sessionId'] as String?,
      email: json['email'] as String,
      password: json['password'] as String?,
      name: json['name'] as String?,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$$TodoUserImplToJson(_$TodoUserImpl instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
      'userId': instance.userId,
    };
