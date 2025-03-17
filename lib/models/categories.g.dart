// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CategoryImpl _$$CategoryImplFromJson(Map<String, dynamic> json) =>
    _$CategoryImpl(
      name: json['name'] as String,
      id: json['id'] as int?,
      todoFileId: json['todoFileId'] as int?,
      userId: json['user_id'] as String?,
      lastUpdated: json['last_updated'] == null
          ? null
          : DateTime.parse(json['last_updated'] as String),
    );

Map<String, dynamic> _$$CategoryImplToJson(_$CategoryImpl instance) {
  final val = <String, dynamic>{
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('todoFileId', instance.todoFileId);
  writeNotNull('user_id', instance.userId);
  writeNotNull('last_updated', instance.lastUpdated?.toIso8601String());
  return val;
}
