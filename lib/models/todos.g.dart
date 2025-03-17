// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoFileImpl _$$TodoFileImplFromJson(Map<String, dynamic> json) =>
    _$TodoFileImpl(
      name: json['name'] as String,
      id: json['id'] as int?,
      userId: json['userId'] as String?,
      lastUpdated: json['last_updated'] == null
          ? null
          : DateTime.parse(json['last_updated'] as String),
    );

Map<String, dynamic> _$$TodoFileImplToJson(_$TodoFileImpl instance) {
  final val = <String, dynamic>{
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('userId', instance.userId);
  writeNotNull('last_updated', instance.lastUpdated?.toIso8601String());
  return val;
}

_$TodoImpl _$$TodoImplFromJson(Map<String, dynamic> json) => _$TodoImpl(
      done: json['done'] as bool? ?? false,
      visible: json['visible'] as bool? ?? true,
      expanded: json['expanded'] as bool? ?? false,
      order: json['order'] as int? ?? 0,
      name: json['name'] as String,
      id: json['id'] as int?,
      userId: json['userId'] as String?,
      todoFileId: json['todoFileId'] as int?,
      categoryId: json['categoryId'] as int?,
      parentTodoId: json['parentTodoId'] as int?,
      notes: json['notes'] as String? ?? '',
      lastUpdated: json['last_updated'] == null
          ? null
          : DateTime.parse(json['last_updated'] as String),
    );

Map<String, dynamic> _$$TodoImplToJson(_$TodoImpl instance) {
  final val = <String, dynamic>{
    'done': instance.done,
    'visible': instance.visible,
    'expanded': instance.expanded,
    'order': instance.order,
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('userId', instance.userId);
  writeNotNull('todoFileId', instance.todoFileId);
  writeNotNull('categoryId', instance.categoryId);
  writeNotNull('parentTodoId', instance.parentTodoId);
  val['notes'] = instance.notes;
  writeNotNull('last_updated', instance.lastUpdated?.toIso8601String());
  return val;
}
