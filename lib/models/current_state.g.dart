// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CurrentState _$CurrentStateFromJson(Map<String, dynamic> json) =>
    _CurrentState(
      currentFiles: json['currentFiles'] as String,
      id: (json['id'] as num?)?.toInt(),
      userId: json['user_id'] as String?,
      lastUpdated:
          json['last_updated'] == null
              ? null
              : DateTime.parse(json['last_updated'] as String),
    );

Map<String, dynamic> _$CurrentStateToJson(_CurrentState instance) =>
    <String, dynamic>{
      'currentFiles': instance.currentFiles,
      if (instance.id case final value?) 'id': value,
      if (instance.userId case final value?) 'user_id': value,
      if (instance.lastUpdated?.toIso8601String() case final value?)
        'last_updated': value,
    };
