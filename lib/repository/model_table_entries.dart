import 'package:note_master/models/models.dart';
import 'package:supa_manager/supa_manager.dart';

const todoFileTableName = 'TodoFiles';
const categoryTableName = 'Categories';
const todoTableName = 'Todos';
const currentStateTableName = 'CurrentState';
const todoFileIdName = 'todoFileId';
const categoryIdName = 'categoryId';
const nameField = 'name';

class TodoFileTableData extends TableData<TodoFile> {
  TodoFileTableData() {
    tableName = todoFileTableName;
  }

  @override
  TodoFile fromJson(Map<String, dynamic> json) {
    return TodoFile.fromJson(json);
  }
}

class TodoFileTableEntry with TableEntry<TodoFile> {
  final TodoFile todoFile;

  TodoFileTableEntry(this.todoFile);

  @override
  TodoFileTableEntry addUserId(String userId) {
    return TodoFileTableEntry(todoFile.copyWith(userId: userId));
  }

  @override
  Map<String, dynamic> toJson() {
    return todoFile.toJson();
  }

  @override
  int? get id => todoFile.id;

  @override
  set id(int? id) {}
}

class CategoryTableData extends TableData<Category> {
  CategoryTableData() {
    tableName = categoryTableName;
  }

  @override
  Category fromJson(Map<String, dynamic> json) {
    return Category.fromJson(json);
  }
}

class CategoryTableEntry with TableEntry<Category> {
  final Category category;
  final int todoFileId;
  CategoryTableEntry(this.category, this.todoFileId);

  @override
  CategoryTableEntry addUserId(String userId) {
    return CategoryTableEntry(category.copyWith(todoFileId: todoFileId, userId: userId), todoFileId);
  }

  @override
  Map<String, dynamic> toJson() {
    return category.toJson();
  }

  @override
  int? get id => category.id;

  @override
  set id(int? id) {}
}

class TodoTableData extends TableData<Todo> {
  TodoTableData() {
    tableName = todoTableName;
  }

  @override
  Todo fromJson(Map<String, dynamic> json) {
    return Todo.fromJson(json);
  }
}

class TodoTableEntry with TableEntry<Todo> {
  final Todo todo;
  final int todoFileId;
  final int categoryId;
  TodoTableEntry(this.todo, this.todoFileId, this.categoryId);

  @override
  TodoTableEntry addUserId(String userId) {
    return TodoTableEntry(todo.copyWith(categoryId: categoryId, todoFileId: todoFileId, userId: userId), todoFileId, categoryId);
  }

  @override
  Map<String, dynamic> toJson() {
    return todo.toJson();
  }

  @override
  int? get id => todo.id;

  @override
  set id(int? id) {}
}
class CurrentStateTableData extends TableData<CurrentState> {
  CurrentStateTableData() {
    tableName = currentStateTableName;
  }

  @override
  CurrentState fromJson(Map<String, dynamic> json) {
    return CurrentState.fromJson(json);
  }
}

class CurrentStateTableEntry with TableEntry<CurrentState> {
  final CurrentState currentState;
  CurrentStateTableEntry(this.currentState);

  @override
  CurrentStateTableEntry addUserId(String userId) {
    return CurrentStateTableEntry(currentState.copyWith(userId: userId));
  }

  @override
  Map<String, dynamic> toJson() {
    return currentState.toJson();
  }

  @override
  int? get id => currentState.id;

  @override
  set id(int? id) {}
}
