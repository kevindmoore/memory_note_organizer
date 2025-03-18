// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_todo_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CurrentTodoState _$CurrentTodoStateFromJson(
  Map<String, dynamic> json,
) => _CurrentTodoState(
  currentTodoFile:
      json['currentTodoFile'] == null
          ? null
          : TodoFile.fromJson(json['currentTodoFile'] as Map<String, dynamic>),
  currentTodo:
      json['currentTodo'] == null
          ? null
          : Todo.fromJson(json['currentTodo'] as Map<String, dynamic>),
  currentCategory:
      json['currentCategory'] == null
          ? null
          : Category.fromJson(json['currentCategory'] as Map<String, dynamic>),
  currentlySelectedIndex:
      (json['currentlySelectedIndex'] as num?)?.toInt() ?? -1,
);

Map<String, dynamic> _$CurrentTodoStateToJson(_CurrentTodoState instance) =>
    <String, dynamic>{
      'currentTodoFile': instance.currentTodoFile,
      'currentTodo': instance.currentTodo,
      'currentCategory': instance.currentCategory,
      'currentlySelectedIndex': instance.currentlySelectedIndex,
    };
