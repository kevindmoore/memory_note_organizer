import 'dart:convert';

import '../logging/log_client.dart';
import 'models.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class TodoFiles extends ChangeNotifier {
  List<TodoFile> files;

  TodoFiles(this.files);

  void addTodoFile(TodoFile todoFile) {
    if (!files.contains(todoFile) && !containsFileId(todoFile.id!)) {
      files.add(todoFile);
    } else {
      final index = files.indexWhere((element) => element.id == todoFile.id);
      if (index != -1) {
        files[index] = todoFile;
      }
    }
  }

  bool containsFileId(int id) {
    return files.any((todoFile) => todoFile.id == id);
  }

  void removeTodoFile(TodoFile todoFile) {
    files.remove(todoFile);
    notifyListeners();
  }

  void addAll(List<TodoFile> newTodoFiles) {
    for (final todoFile in newTodoFiles) {
      if (!files.contains(todoFile) && !containsFileId(todoFile.id!)) {
        files.add(todoFile);
      }
    }
  }

  TodoFile? findTodoFile(int? id) {
    if (id == null) {
      return null;
    }
    return files.firstWhereOrNull((todoFile) => todoFile.id == id);
  }

  void replaceUpdatedTodoFile(TodoFile todoFile) {
    final index =
        files.indexWhere((existingFile) => todoFile.id == existingFile.id);
    if (index != -1) {
      files[index] = todoFile;
    }
  }

  String? findTodoFileName(int? id) {
    return findTodoFile(id)?.name;
  }

  String? findCategoryName(int? todoFileId, int? id) {
    return findCategory(findTodoFile(todoFileId)?.categories, id)?.name;
  }

  String? findTodoName(int? todoFileId, int? categoryId, int? id) {
    final category = findCategory(findTodoFile(todoFileId)?.categories, id);
    if (category == null) {
      return null;
    }
    return findTodoFromList(category.todos, id)?.name;
  }

  int getTodoChildCount(int? todoFileId, int? categoryId, int? id) {
    final category = findCategory(findTodoFile(todoFileId)?.categories, id);
    if (category == null) {
      return 0;
    }
    final todo = findTodoFromList(category.todos, id);
    if (todo == null) {
      return 0;
    }
    return todo.children.length;
  }

  Category? findCategory(List<Category>? categories, int? id) {
    if (categories == null) {
      return null;
    }
    if (id == null) {
      return null;
    }
    return categories.firstWhereOrNull((category) => category.id == id);
  }

  Category? findCategoryInTodoFile(TodoFile? todoFile, int? id) {
    if (todoFile == null || id == null) {
      return null;
    }
    return todoFile.categories
        .firstWhereOrNull((category) => category.id == id);
  }

  Category? findFileCategory(int? todoFileId, int? categoryId) {
    return findCategoryInTodoFile(findTodoFile(todoFileId), categoryId);
  }

  void replaceUpdatedCategory(TodoFile todoFile, Category category) {
    final index = todoFile.categories
        .indexWhere((existingCategory) => category.id == existingCategory.id);
    if (index != -1) {
      todoFile.categories[index] = category;
    }
  }

  Todo? findTodoFromCategory(Category category, int? id) {
    return category.todos.firstWhereOrNull((todo) => todo.id == id);
  }

  Todo? findTodoFromList(List<Todo>? todos, int? id) {
    if (todos == null || id == null) {
      return null;
    }
    return todos.firstWhereOrNull((todo) => todo.id == id);
  }

  Todo? findParentTodo(Todo todo) {
    return findDeepTodo(todo.todoFileId, todo.categoryId, todo.parentTodoId);
  }
  Todo? findDeepTodo(int? todoFileId, int? categoryId, int? id) {
    final todoFile = findTodoFile(todoFileId);
    if (todoFile == null) {
      logSystemError( 'findTodoInCategory:Could not find todo file id: $todoFileId');
      return null;
    }
    final category = findCategoryInTodoFile(todoFile, categoryId);
    if (category == null) {
      logSystemError( 'findTodoInCategory:Could not find category id: $categoryId');
      return null;
    }
    return findTodoInChildren(category.todos, id);
  }

  int? findTodoIndex(int? todoFileId, int? categoryId, int? id) {
    final todoFile = findTodoFile(todoFileId);
    if (todoFile == null) {
      logSystemError( 'findTodoInCategory:Could not find todo file id: $todoFileId');
      return null;
    }
    final category = findCategoryInTodoFile(todoFile, categoryId);
    if (category == null) {
      logSystemError( 'findTodoInCategory:Could not find category id: $categoryId');
      return null;
    }
    return findTodoIndexInChildren(category.todos, id);
  }

  int? findTodoIndexInChildren(List<Todo> children, int? id) {
    int? resultIndex;
    children.forEachIndexed((index, todo) {
      if (todo.id == id) {
        resultIndex = index;
        return;
      }
      final foundIndex = findTodoIndexInChildren(todo.children, id);
      if (foundIndex != null) {
        resultIndex = foundIndex;
        return;
      }
    });
    return resultIndex;
  }

  Todo? findTodoInParentTodo(
      int? todoFileId, int? categoryId, int? parentId, int? id) {
    final todoFile = findTodoFile(todoFileId);
    if (todoFile == null) {
      logSystemError( 'findTodoInCategory:Could not find todo file id: $todoFileId');
      return null;
    }
    final category = findCategoryInTodoFile(todoFile, categoryId);
    if (category == null) {
      logSystemError( 'findTodoInCategory:Could not find category id: $categoryId');
      return null;
    }
    if (parentId == null) {
      logSystemError( 'findTodoInParentTodo: parentId is null');
      return null;
    }
    if (id == null) {
      logSystemError(
           'findTodoInParentTodo: id is null');
      return null;
    }
    final parentTodo = findTodoInChildren(category.todos, parentId);
    if (parentTodo == null) {
      return null;
    }
    return findTodoInChildren(parentTodo.children, id);
  }

  Todo? findTodoInChildren(List<Todo> children, int? id) {
    if (id == null) {
      return null;
    }
    for (final todo in children) {
      if (todo.id == id) {
        return todo;
      }
      final foundTodo = findTodoInChildren(todo.children, id);
      if (foundTodo != null) {
        return foundTodo;
      }
    }
    return null;
  }

  int todoFileIndex(int id) {
    return files.indexWhere((todoFile) => todoFile.id == id);
  }

  int categoryIndex(List<Category> categories, int id) {
    return categories.indexWhere((category) => category.id == id);
  }

  int todoIndex(List<Todo> todos, int id) {
    return todos.indexWhere((todo) => todo.id == id);
  }

  int deepTodoIndex(List<Todo> todos, int id) {
    var index = 0;
    for (final todo in todos) {
      if (todo.id == id) {
        return index;
      }
      index++;
      if (todo.children.isNotEmpty) {
        final childIndex = deepTodoIndex(todo.children, id);
        if (childIndex != -1) {
          return childIndex;
        }
      }
    }
    return -1;
  }

  factory TodoFiles.fromJson(String json) {
    final todoFilesMap = jsonDecode(json) as List<dynamic>;
    final todoFiles = <TodoFile>[];
    for (final todoFileMap in todoFilesMap) {
      var todoFile = TodoFile.fromJson(todoFileMap);
      if (todoFileMap.containsKey('categories')) {
        final categoryList = <Category>[];
        for (final categoryMap in todoFileMap['categories']) {
          final category = Category.fromJson(categoryMap);
          if (categoryMap.containsKey('todos')) {
            final todoList = mapToTodo(categoryMap['todos']);
            // for (final todoMap in categoryMap['todos']) {
            //   final todo = Todo.fromJson(todoMap);
            //   if (todoMap.containsKey('children')) {
            //
            //   }
            //   todoList.add(todo);
            // }
            categoryList.add(category.copyWith(todos: todoList));
          }
        }
        todoFile = todoFile.copyWith(categories: categoryList);
      }
      todoFiles.add(todoFile);
    }
    return TodoFiles(todoFiles);
  }

  static List<Todo> mapToTodo(List<dynamic> todoListMap) {
    final todoList = <Todo>[];
    for (final todoMap in todoListMap) {
      var todo = Todo.fromJson(todoMap);
      if (todoMap.containsKey('children')) {
        final children = mapToTodo(todoMap['children']);
        todo = todo.copyWith(children: children);
      }
      todoList.add(todo);
    }
    return todoList;
  }

  String toJson() {
    return jsonEncode(files.map((todoFile) => todoFileToJson(todoFile)).toList());
  }

  Map<String, dynamic> todoFileToJson(TodoFile todoFile) {
    final todoFileMap = todoFile.toJson();
    final categoryList = <Map<String, dynamic>>[];
    for (final category in todoFile.categories) {
      final categoryMap = category.toJson();
      final todoList = <Map<String, dynamic>>[];
      for (final todo in category.todos) {
        // final todoMap = todo.toJson();
        todoList.add(todoToMap(todo));
      }
      categoryMap['todos'] = todoList;
      categoryList.add(categoryMap);
    }
    todoFileMap['categories'] = categoryList;
    return todoFileMap;
  }

  Map<String, dynamic> todoToMap(Todo todo) {
    final todoMap = todo.toJson();
    final children = <Map<String, dynamic>>[];
    for (final child in todo.children) {
      final childMap = todoToMap(child);
      children.add(childMap);
    }
    todoMap['children'] = children;
    return todoMap;
  }
}
