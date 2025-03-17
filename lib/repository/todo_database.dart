
import 'dart:async';

import 'package:supa_manager/supa_manager.dart';

import '../logging/log_client.dart';
import '../models/models.dart';
import 'model_table_entries.dart';

class TodoDatabase {
  final SupaDatabaseManager databaseRepository;
  var remoteTodoFiles = TodoFiles(<TodoFile>[]);
  final TodoFileTableData todoFileTableData = TodoFileTableData();
  final CategoryTableData categoryTableData = CategoryTableData();
  final TodoTableData todoTableData = TodoTableData();
  final CurrentStateTableData currentStateTableData = CurrentStateTableData();


  TodoDatabase(this.databaseRepository);

  FutureOr<TodoFiles> loadRemoteFiles(String filesString) async {
      final documentIds = filesString.split(',');
      await Future.forEach(documentIds, (String id) async {
        await loadTodoFileCategoriesAndTodos(int.parse(id));
      });

    return remoteTodoFiles;
    // Sync Database
    // final currentState = await getCurrentState();
    // await syncDatabases(currentState);
  }

  Future<String?> getCurrentFilesString() async {
    final result = await databaseRepository.readEntries(currentStateTableData);
    return result.when(success: (data) {
      if (data is List<CurrentState>) {
        if (data.isNotEmpty) {
          return data[0].currentFiles;
        }
      }
      return null;
    }, failure: (Exception error) {
      logSystemError(error.toString());
      return null;
    }, errorMessage: (int code, String? message) {
      logSystemError(message);
      return null;
    });
  }

  Future loadTodoFileCategoriesAndTodos(int todoFileId) async {
    final result =
    await databaseRepository.readEntry(todoFileTableData, todoFileId);
    await result.when(success: (data) async {
      final categories = await getCategoriesWithFileId(data.id);
      if (categories.isNotEmpty) {
        data = data.copyWith(categories: categories);
      }
      remoteTodoFiles.addTodoFile(data);
    }, failure: (Exception error) {
      logSystemError(error.toString());
    }, errorMessage: (int code, String? message) {
      logSystemError(message!);
    });
  }

  Future<List<Category>> getCategoriesWithFileId(int todoFileId) async {
    final result = await databaseRepository.readEntriesWhere(
        categoryTableData, todoFileIdName, todoFileId);
    return await result.when(success: (data) async {
      final categories = <Category>[];
      await Future.forEach(data, (Category category) async {
        final todos = await getTodosWithFileAndCategory(todoFileId, category.id!);
        category = category.copyWith(todos: _reorderTodos(todos));
        categories.add(category);
      });
      return categories;
    }, failure: (Exception error) {
      logSystemError(error.toString());
      return <Category>[];
    }, errorMessage: (int code, String? message) {
      logSystemError(message!);
      return <Category>[];
    });
  }

  Future<List<Todo>> getTodosWithFileAndCategory(int todoFileId, int categoryId) async {
    final result = await databaseRepository.selectEntriesWhere(todoTableData, [
      SelectEntry.and(todoFileIdName, todoFileId.toString()),
      SelectEntry.and(categoryIdName, categoryId.toString()),
    ]);
    return result.when(success: (data) {
      return data;
    }, failure: (Exception error) {
      logSystemError(error.toString());
      return <Todo>[];
    }, errorMessage: (int code, String? message) {
      logSystemError(message!);
      return <Todo>[];
    });
  }

  List<Todo> _reorderTodos(List<Todo> todos) {
    final reorderedTodos = <Todo>[];
    // Get all top level todos
    final todosWithParentId = todos.where((todo) => todo.parentTodoId == null);
    for (var parentIdTodo in todosWithParentId) {
      final childTodos =
      todos.where((todo) => parentIdTodo.id == todo.parentTodoId).toList();
      if (childTodos.isNotEmpty) {
        parentIdTodo = _findChildTodos(todos, parentIdTodo, childTodos);
      }
      reorderedTodos.add(parentIdTodo);
    }
    return reorderedTodos;
  }

  Todo _findChildTodos(
      List<Todo> allCategoryTodos, Todo parentTodo, List<Todo> childTodos) {
    final parentChildTodos = <Todo>[];
    for (var childTodo in childTodos) {
      final childrenOfChildrenTodos = allCategoryTodos
          .where((todo) => childTodo.id == todo.parentTodoId)
          .toList();
      if (childrenOfChildrenTodos.isNotEmpty) {
        childrenOfChildrenTodos
            .sort((todo1, todo2) => todo1.order.compareTo(todo2.order));
        childTodo = childTodo.copyWith(children: childrenOfChildrenTodos);
        _findChildTodos(allCategoryTodos, childTodo, childrenOfChildrenTodos);
      }
      parentChildTodos.add(childTodo);
    }
    parentTodo = parentTodo.copyWith(children: parentChildTodos);
    return parentTodo;
  }

  Future<Result<Todo?>> addNewTodoToCategory(
      int? todoFileId, int? categoryId, Todo todo) async {
    if (todoFileId == null) {
      return const Result.errorMessage(99, 'addNewTodoToCategory: todoFileId is null');
    }
    if (categoryId == null) {
      return const Result.errorMessage(99,  'addNewTodoToCategory: categoryId is null');
    }
    final todoFile = remoteTodoFiles.findTodoFile(todoFileId);
    if (todoFile == null) {
      return Result.errorMessage(99,  'addNewTodoToCategory: TodoFile not found for $todoFileId');
    }
    final category = remoteTodoFiles.findFileCategory(todoFileId, categoryId);
    if (category == null) {
      return const Result.errorMessage(99,  'addNewTodoToCategory: category is null');
    }
    final updatedTodo =
    todo.copyWith(todoFileId: todoFileId, categoryId: categoryId);
    final result = await databaseRepository.addEntry(
        todoTableData, TodoTableEntry(updatedTodo, todoFileId, categoryId));
    return result.when(success: (data) {
      return Result.success(data);
    }, failure: (Exception error) {
      return Result.errorMessage(99,  error.toString());
    }, errorMessage: (int code, String? message) {
      return Result.errorMessage(99,  message!);
    });
  }

  Future<Result<Todo?>> addNewTodo(Todo todo, int todoFileId, int categoryId) async {
    final updatedTodo =
    todo.copyWith(todoFileId: todoFileId, categoryId: categoryId);
    final result = await databaseRepository.addEntry(
        todoTableData, TodoTableEntry(updatedTodo, todoFileId, categoryId));

    return result.when(success: (data) {
      return Result.success(data);
    }, failure: (Exception error) {
      return Result.errorMessage(99,  error.toString());
    }, errorMessage: (int code, String? message) {
      return Result.errorMessage(99,  message!);
    });
  }

  Future<Result<Todo?>> addNewTodoToParent(
      int? todoFileId, int? categoryId, int parentId, Todo todo) async {
    if (todoFileId == null) {
      return const Result.errorMessage(99,  'addNewTodoToParent: todoFileId is null');
    }
    if (categoryId == null) {
      return const Result.errorMessage(99,  'addNewTodoToParent: categoryId is null');
    }
    final updatedTodo = todo.copyWith(
        todoFileId: todoFileId, categoryId: categoryId, parentTodoId: parentId);
    final result = await databaseRepository.addEntry(
        todoTableData, TodoTableEntry(updatedTodo, todoFileId, categoryId));
    return result.when(success: (data) {
      return Result.success(data);
    }, failure: (Exception error) {
      return Result.errorMessage(99,  error.toString());
    }, errorMessage: (int code, String? message) {
      return Result.errorMessage(99,  message!);
    });
  }

}