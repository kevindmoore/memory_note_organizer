import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supa_manager/supa_manager.dart';

import '../models/models.dart';
import '../todos/todo_manager.dart';
import '../utils/utils.dart';
import 'local_repo.dart';
import 'model_table_entries.dart';

class TodoTableHandler {
  final Ref? ref;
  final SupaDatabaseManager databaseRepository;
  // final LocalRepo localRepo;
  final TodoManager? todoManager;
  final TodoTableData todoTableData = TodoTableData();

  TodoTableHandler(
      this.ref, this.databaseRepository,
      // this.localRepo,
      this.todoManager);

  Future<Todo?> addNewTodoToCategory(
      int? todoFileId, int? categoryId, Todo todo) async {
    if (todoFileId == null) {
      logAndShowError(ref, 'addNewTodoToCategory: todoFileId is null');
      return null;
    }
    if (categoryId == null) {
      logAndShowError(ref, 'addNewTodoToCategory: categoryId is null');
      return null;
    }
    final todoFile = todoManager?.findTodoFile(todoFileId);
    if (todoFile == null) {
      logAndShowError(
          ref, 'addNewTodoToCategory: TodoFile not found for $todoFileId');
      return null;
    }
    final category = todoManager?.findFileCategory(todoFileId, categoryId);
    if (category == null) {
      logAndShowError(ref, 'addNewTodoToCategory: category is null');
      return null;
    }
    final updatedTodo = todo.copyWith(
        todoFileId: todoFileId,
        categoryId: categoryId,
        lastUpdated: DateTime.now());
    final result = await databaseRepository.addEntry(
        todoTableData, TodoTableEntry(updatedTodo, todoFileId, categoryId));
    return result.when(success: (data) {
      todoManager?.addTodoToCategory(todoFileId, categoryId, data);
      // localRepo.addLocalTodo(data);
      return data;
    }, failure: (Exception error) {
      logAndShowError(ref, error.toString());
      return null;
    }, errorMessage: (int code, String? message) {
      logAndShowError(ref, message!);
      return null;
    });
  }

  Future<Todo?> addNewTodo(Todo todo, int todoFileId, int categoryId) async {
    final updatedTodo = todo.copyWith(
        todoFileId: todoFileId,
        categoryId: categoryId,
        lastUpdated: DateTime.now());
    final result = await databaseRepository.addEntry(
        todoTableData, TodoTableEntry(updatedTodo, todoFileId, categoryId));

    return result.when(success: (data) {
      todoManager?.addTodo(data);
      // localRepo.addLocalTodo(data);
      return data;
    }, failure: (Exception error) {
      logAndShowError(ref, error.toString());
      return null;
    }, errorMessage: (int code, String? message) {
      logAndShowError(ref, message!);
      return null;
    });
  }

  Future<Todo?> addNewTodoToParent(
      int? todoFileId, int? categoryId, int parentId, Todo todo) async {
    if (todoFileId == null) {
      logAndShowError(ref, 'addNewTodoToParent: todoFileId is null');
      return null;
    }
    if (categoryId == null) {
      logAndShowError(ref, 'addNewTodoToParent: categoryId is null');
      return null;
    }
    final updatedTodo = todo.copyWith(
        todoFileId: todoFileId,
        categoryId: categoryId,
        parentTodoId: parentId,
        lastUpdated: DateTime.now());
    final result = await databaseRepository.addEntry(
        todoTableData, TodoTableEntry(updatedTodo, todoFileId, categoryId));
    return result.when(success: (data) {
      todoManager?.addTodo(data);
      // localRepo.addLocalTodo(data);
      return data;
    }, failure: (Exception error) {
      logAndShowError(ref, error.toString());
      return null;
    }, errorMessage: (int code, String? message) {
      logAndShowError(ref, message!);
      return null;
    });
  }

  Future<List<Todo>> getTodosWithFileAndCategory(
      int todoFileId, int categoryId) async {
    final result = await databaseRepository.selectEntriesWhere(todoTableData, [
      SelectEntry.and(todoFileIdName, todoFileId.toString()),
      SelectEntry.and(categoryIdName, categoryId.toString()),
    ]);
    return result.when(success: (data) {
      return data;
    }, failure: (Exception error) {
      logAndShowError(ref, error.toString());
      return <Todo>[];
    }, errorMessage: (int code, String? message) {
      logAndShowError(ref, message!);
      return <Todo>[];
    });
  }

  Future deleteTodo(Todo todo, bool removeFromList) async {
    // Fast remove
    if (removeFromList) {
      todoManager?.deleteTodo(todo);
    }
    if (todo.id == null && todo.parentTodoId != null) {
      // Find Parent todo
      final parentTodo = todoManager?.findParentTodo(todo);
      if (parentTodo != null) {
        final childIndex = todoManager?.childTodoIndexInParent(parentTodo, todo);
        if (childIndex != null && childIndex != -1) {
          final childBuilder = parentTodo.children.toIList();
          childBuilder.removeAt(childIndex);
          final updatedParentTodo = parentTodo.copyWith(
              children: childBuilder.unlock, lastUpdated: DateTime.now());
          todoManager?.updateTodo(updatedParentTodo);
          // parentTodo.children.removeAt(childIndex);
        } else {
          logAndShowError(ref,
              'deleteTodo: Could not find child index in parent todo. ${todo.name}');
        }
        final result = await databaseRepository.updateTableEntry(
            todoTableData,
            TodoTableEntry(
                parentTodo, parentTodo.todoFileId!, parentTodo.categoryId!));
        return result.when(success: (data) async {
          return data;
        }, failure: (Exception error) {
          logAndShowError(ref, error.toString());
          return null;
        }, errorMessage: (int code, String? message) {
          logAndShowError(ref, message!);
          return null;
        });
      } else {
        logAndShowError(
            ref, 'deleteTodo: Could not find parent todo. ${todo.name}');
        return Future.value(null);
      }
    } else if (todo.id == null) {
      logAndShowError(ref,
          'deleteTodo: Could not update todo. document id or parent id is null ${todo.name}');
      return Future.value(null);
    }
    final result = await databaseRepository.deleteTableEntry(todoTableData,
        TodoTableEntry(todo, todo.todoFileId!, todo.categoryId!));
    // localRepo.deleteLocalTodo(todo);
    return result;
  }

  Future updateTodo(Todo todo) async {
    todo = todo.copyWith(lastUpdated: DateTime.now());
    todoManager?.updateTodo(todo);
    if (todo.id == null && todo.parentTodoId != null) {
      // Find Parent todo
      final parentTodo = todoManager?.findParentTodo(todo);
      if (parentTodo != null) {
        todoManager?.updateTodoInParent(parentTodo, todo);
        final result = await databaseRepository.updateTableEntry(
            todoTableData,
            TodoTableEntry(
                parentTodo, parentTodo.todoFileId!, parentTodo.categoryId!));
        return result.when(success: (data) async {
          return data;
        }, failure: (Exception error) {
          logAndShowError(ref, error.toString());
          return null;
        }, errorMessage: (int code, String? message) {
          logAndShowError(ref, message!);
          return null;
        });
      } else {
        logAndShowError(
            ref, 'updateTodo: Could not find parent todo. ${todo.name}');
        return Future.value(null);
      }
    } else if (todo.id == null) {
      logAndShowError(ref,
          'updateTodo: Could not update todo. document id or parent id is null ${todo.name}');
      return Future.value(null);
    }
    final result = await databaseRepository.updateTableEntry(todoTableData,
        TodoTableEntry(todo, todo.todoFileId!, todo.categoryId!));
    return result.when(success: (data) async {
      // localRepo.updateLocalTodo(data);
      return data;
    }, failure: (Exception error) {
      logAndShowError(ref, error.toString());
      return null;
    }, errorMessage: (int code, String? message) {
      logAndShowError(ref, message!);
      return null;
    });
  }
}
