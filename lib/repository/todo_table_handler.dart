import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:supa_manager/supa_manager.dart';
import 'package:memory_notes_organizer/providers.dart';

import '../models/models.dart';
import '../todos/todo_manager.dart';
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
      logError( 'addNewTodoToCategory: todoFileId is null');
      return null;
    }
    if (categoryId == null) {
      logError( 'addNewTodoToCategory: categoryId is null');
      return null;
    }
    final todoFile = todoManager?.findTodoFile(todoFileId);
    if (todoFile == null) {
      logError(
          'addNewTodoToCategory: TodoFile not found for $todoFileId');
      return null;
    }
    final category = todoManager?.findFileCategory(todoFileId, categoryId);
    if (category == null) {
      logError( 'addNewTodoToCategory: category is null');
      return null;
    }
    final updatedTodo = todo.copyWith(
        todoFileId: todoFileId,
        categoryId: categoryId,
        lastUpdated: DateTime.now());
    final result = await databaseRepository.addEntry(
        todoTableData, TodoTableEntry(updatedTodo, todoFileId, categoryId));
    switch (result) {
      case Success(data: final data):
        todoManager?.addTodoToCategory(todoFileId, categoryId, data!);
        // localRepo.addLocalTodo(data);
        return data;
      case Failure(error: final error):
        if (error is SignedOutException) {
          ref?.read(configurationProvider).loginStateNotifier.loggedIn(false);
        }
        logError( error.toString());
      case ErrorMessage(message: final message, code: _):
        logError( message!);
    }
    return null;
  }

  Future<Todo?> addNewTodo(Todo todo, int todoFileId, int categoryId) async {
    final updatedTodo = todo.copyWith(
        todoFileId: todoFileId,
        categoryId: categoryId,
        lastUpdated: DateTime.now());
    final result = await databaseRepository.addEntry(
        todoTableData, TodoTableEntry(updatedTodo, todoFileId, categoryId));

    switch (result) {
      case Success(data: final data):
        todoManager?.addTodo(data!);
        // localRepo.addLocalTodo(data);
        return data;
      case Failure(error: final error):
        if (error is SignedOutException) {
          ref?.read(configurationProvider).loginStateNotifier.loggedIn(false);
        }
        logError( error.toString());
      case ErrorMessage(message: final message, code: _):
        logError( message!);
    }
    return null;
  }

  Future<Todo?> addNewTodoToParent(
      int? todoFileId, int? categoryId, int parentId, Todo todo) async {
    if (todoFileId == null) {
      logError( 'addNewTodoToParent: todoFileId is null');
      return null;
    }
    if (categoryId == null) {
      logError( 'addNewTodoToParent: categoryId is null');
      return null;
    }
    final updatedTodo = todo.copyWith(
        todoFileId: todoFileId,
        categoryId: categoryId,
        parentTodoId: parentId,
        lastUpdated: DateTime.now());
    final result = await databaseRepository.addEntry(
        todoTableData, TodoTableEntry(updatedTodo, todoFileId, categoryId));
    switch (result) {
      case Success(data: final data):
        todoManager?.addTodo(data!);
        // localRepo.addLocalTodo(data);
        return data;
      case Failure(error: final error):
        if (error is SignedOutException) {
          ref?.read(configurationProvider).loginStateNotifier.loggedIn(false);
        }
        logError( error.toString());
      case ErrorMessage(message: final message, code: _):
        logError( message!);
    }
    return null;
  }

  Future<List<Todo>> getTodosWithFileAndCategory(
      int todoFileId, int categoryId) async {
    final result = await databaseRepository.selectEntriesWhere(todoTableData, [
      SelectEntry.and(todoFileIdName, todoFileId.toString()),
      SelectEntry.and(categoryIdName, categoryId.toString()),
    ]);
    switch (result) {
      case Success(data: final data):
        return data;
      case Failure(error: final error):
        if (error is SignedOutException) {
          ref?.read(configurationProvider).loginStateNotifier.loggedIn(false);
        }
        logError( error.toString());
      case ErrorMessage(message: final message, code: _):
        logError( message!);
    }
    return <Todo>[];
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
          parentTodo.children.removeAt(childIndex);
          final updatedParentTodo = parentTodo.copyWith(
              children: parentTodo.children, lastUpdated: DateTime.now());
          todoManager?.updateTodo(updatedParentTodo);
          // parentTodo.children.removeAt(childIndex);
        } else {
          logError(
              'deleteTodo: Could not find child index in parent todo. ${todo.name}');
        }
        final result = await databaseRepository.updateTableEntry(
            todoTableData,
            TodoTableEntry(
                parentTodo, parentTodo.todoFileId!, parentTodo.categoryId!));
        switch (result) {
          case Success(data: final data):
            return data;
          case Failure(error: final error):
            if (error is SignedOutException) {
              ref?.read(configurationProvider).loginStateNotifier.loggedIn(false);
            }
            logError( error.toString());
          case ErrorMessage(message: final message, code: _):
            logError( message!);
        }
        return null;
      } else {
        logError(
            'deleteTodo: Could not find parent todo. ${todo.name}');
        return Future.value(null);
      }
    } else if (todo.id == null) {
      logError(
          'deleteTodo: Could not update todo. document id or parent id is null ${todo.name}');
      return Future.value(null);
    }
    final result = await databaseRepository.deleteTableEntry(todoTableData,
        TodoTableEntry(todo, todo.todoFileId!, todo.categoryId!));
    // localRepo.deleteLocalTodo(todo);
    return result;
  }

  Future<Todo?> updateTodo(Todo todo) async {
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
        switch (result) {
          case Success(data: final data):
            return data;
          case Failure(error: final error):
            if (error is SignedOutException) {
              ref?.read(configurationProvider).loginStateNotifier.loggedIn(false);
            }
            logError( error.toString());
          case ErrorMessage(message: final message, code: _):
            logError( message!);
        }
        return null;
      } else {
        logError(
            'updateTodo: Could not find parent todo. ${todo.name}');
        return Future.value(null);
      }
    } else if (todo.id == null) {
      logError(
          'updateTodo: Could not update todo. document id or parent id is null ${todo.name}');
      return Future.value(null);
    }
    final result = await databaseRepository.updateTableEntry(todoTableData,
        TodoTableEntry(todo, todo.todoFileId!, todo.categoryId!));
    switch (result) {
      case Success(data: final data):
        return data;
      case Failure(error: final error):
        logError( error.toString());
      case ErrorMessage(message: final message, code: _):
        logError( message!);
    }
    return null;
  }

}
