// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CurrentStateImpl _$$CurrentStateImplFromJson(Map<String, dynamic> json) =>
    _$CurrentStateImpl(
      currentFiles: json['currentFiles'] as String,
      id: json['id'] as int?,
      userId: json['user_id'] as String?,
      lastUpdated: json['last_updated'] == null
          ? null
          : DateTime.parse(json['last_updated'] as String),
    );

Map<String, dynamic> _$$CurrentStateImplToJson(_$CurrentStateImpl instance) {
  final val = <String, dynamic>{
    'currentFiles': instance.currentFiles,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('user_id', instance.userId);
  writeNotNull('last_updated', instance.lastUpdated?.toIso8601String());
  return val;
}
