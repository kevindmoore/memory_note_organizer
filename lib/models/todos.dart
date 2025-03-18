import 'package:freezed_annotation/freezed_annotation.dart';

import 'categories.dart';

part 'todos.freezed.dart';

part 'todos.g.dart';

List<Map<String, dynamic>> todoFileToDatabaseJson(TodoFile todoFile, String userId) {
  final todoFiles = <Map<String, dynamic>>[];
  final updatedTodoFile = todoFile.copyWith(userId: userId);
  todoFiles.add(updatedTodoFile.toJson());
  return todoFiles;
}

Todo updateTodoWithId(
    Todo todo, int categoryId, int todoFileId, String userId) {
  return todo.copyWith(categoryId: categoryId, todoFileId: todoFileId, userId: userId);
}

Todo updateTodoWithParentId(
    Todo todo, int parentId) {
  return todo.copyWith(parentTodoId: parentId);
}

List<Map<String, dynamic>> todoToDatabaseJson(
    Todo todo, int categoryId, int todoFileId, String userId) {
  final updatedTodo = todo.copyWith(categoryId: categoryId, todoFileId: todoFileId, userId: userId);
  return [updatedTodo.toJson()];
}

List<Map<String, dynamic>> todoListToDatabaseJson(List<Todo> todos) {
  final todoList = <Map<String, dynamic>>[];
  for (final todo in todos) {
    todoList.add(todo.toJson());
  }
  return todoList;

}

// @JsonSerializable(explicitToJson: true)
@Freezed(makeCollectionsUnmodifiable: false)
abstract class TodoFile with _$TodoFile {
  // // must be above factory method
  const factory TodoFile({
    required String name,
    @JsonKey(includeIfNull: false)
    int? id,
    @JsonKey(name: 'user_id', includeIfNull: false) String? userId,
    @JsonKey(name: 'last_updated', includeIfNull: false) DateTime? lastUpdated,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(<Category>[]) List<Category> categories,
  }) = _TodoFile;

  factory TodoFile.fromJson(Map<String, dynamic> json) =>
      _$TodoFileFromJson(json);

  @override
  String toString() {
    return 'TodoFile(name: $name id: $id Num categories: ${categories.length}';
  }
}

// @JsonSerializable(explicitToJson: true)
@Freezed(makeCollectionsUnmodifiable: false)
abstract class Todo with _$Todo {
  // must be above factory method
  const factory Todo({

    @Default(false) bool done,
    @Default(true) bool visible,
    @Default(false) bool expanded,
    @Default(0) int order,

    required String name,
    //  ids
    @JsonKey(includeIfNull: false)
    int? id,
    // TODO: Check to makes sure this is generated as 'user_id' and not userId
    @JsonKey(name: 'user_id', includeIfNull: false)
    String? userId,
    @JsonKey(includeIfNull: false)
    int? todoFileId,
    @JsonKey(includeIfNull: false)
    int? categoryId,
    @JsonKey(includeIfNull: false)
    int? parentTodoId,
    @Default('') String notes,
    @JsonKey(name: 'last_updated', includeIfNull: false) DateTime? lastUpdated,

    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(<Todo>[]) List<Todo> children,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  @override
  String toString() {
    return 'Todo(name: $name id: $id Num children: ${children.length}';
  }
}
