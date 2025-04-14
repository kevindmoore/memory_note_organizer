import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:supa_manager/supa_manager.dart';

import '../models/models.dart';
import '../todos/todo_manager.dart';
import 'category_table_handler.dart';
import 'current_state_table_handler.dart';
import 'model_table_entries.dart';

class TodoFileTableHandler {
  final Ref? ref;
  final SupaDatabaseManager databaseRepository;
  // final LocalRepo localRepo;
  final TodoManager? todoManager;
  final CategoryTableHandler categoryTableHandler;
  final CurrentStateTableHandler currentStateTableHandler;
  final loadRemoteFilesFirst = true;
  var remoteTodoFiles = TodoFiles(<TodoFile>[]);

  TodoFile? get currentTodoFile => todoManager?.currentTodoFile;

  set currentTodoFile(TodoFile? todoFile) =>
      todoManager?.currentTodoFile = todoFile;


  final TodoFileTableData todoFileTableData = TodoFileTableData();

  TodoFileTableHandler(
      this.ref, this.databaseRepository,
      // this.localRepo,
      this.todoManager, this.categoryTableHandler, this.currentStateTableHandler);

  Future<TodoFile> addNewTodoFile(TodoFile todoFile) async {
    final result = await databaseRepository.addEntry(
        todoFileTableData, TodoFileTableEntry(todoFile));

    switch (result) {
      case Success(data: final data):
        if (data == null) {
          logError( 'addNewTodoFile: TodoFile is null');
          return todoFile;
        }
        final updatedCategories = await addCategories(data.id!, data.categories);
        final updateTodoFile = data.copyWith(
            categories: updatedCategories, lastUpdated: DateTime.now());
        todoManager?.addTodoFile(updateTodoFile);
        currentTodoFile = updateTodoFile;
        currentStateTableHandler.updateCurrentFiles();
        // localRepo.addLocalTodoFile(updateTodoFile);
        return updateTodoFile;
      case Failure(error: final error):
        logError( error.toString());
      case ErrorMessage(message: final message, code: _):
        logError( message!);
    }
    return todoFile;
  }

  Future<List<Category>> addCategories(
      int todoFileId, List<Category> categories) async {
    final updatedCategories = <Category>[];
    await Future.forEach(categories, (Category category) async {
      final updatedCategory = await categoryTableHandler.addNewCategory(todoFileId, category);
      if (updatedCategory != null) {
        updatedCategories.add(updatedCategory);
      }
    });
    return updatedCategories;
  }

  Future<TodoFile?> loadTodoFileCategoriesAndTodos(int todoFileId) async {
    final result =
        await databaseRepository.readEntry(todoFileTableData, todoFileId);
    switch (result) {
      case Success(data: TodoFile? todoFile):
        if (todoFile == null) {
          logError( 'loadTodoFileCategoriesAndTodos: TodoFile not found for $todoFileId');
          return null;
        }
        final categories = await categoryTableHandler.getCategoriesAndTodosWithFileId(todoFile.id!);
        if (categories.isNotEmpty) {
          todoFile =
              todoFile.copyWith(categories: categories);
        }
        if (loadRemoteFilesFirst) {
          todoManager?.addTodoFileNow(todoFile);
        } else {
          remoteTodoFiles.addTodoFile(todoFile);
        }
        return todoFile;
      case Failure(error: final error):
        logError( error.toString());
      case ErrorMessage(message: final message, code: _):
        logError( message!);
    }
    return null;
  }

  Future<TodoFile?> loadTodoFile(int todoFileId) async {
    final result =
        await databaseRepository.readEntry(todoFileTableData, todoFileId);
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

  Future<List<TodoFile>?> getTodoFiles() async {
    final result = await databaseRepository.readEntries(todoFileTableData);
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

  Future<TodoFile?> getTodoFile(int todoDocId) async {
    final result =
        await databaseRepository.readEntry(todoFileTableData, todoDocId);
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

  Future<TodoFile?> getTodoFileByName(String name) async {
    final result =
        await databaseRepository.readEntriesWhere(todoFileTableData, nameField, name);
    switch (result) {
      case Success(data: final data):
        return data.firstOrNull;
      case Failure(error: final error):
        logError( error.toString());
      case ErrorMessage(message: final message, code: _):
        logError( message!);
    }
    return null;
  }

  Future<TodoFile?> saveTodoFile(TodoFile todoFile) async {
    final result = await databaseRepository.addEntry(
        todoFileTableData, TodoFileTableEntry(todoFile));
    switch (result) {
      case Success(data: final data):
        todoManager?.addTodoFile(data!);
        currentTodoFile = data;
        currentStateTableHandler.updateCurrentFiles();
        return data;
      case Failure(error: final error):
        logError( error.toString());
      case ErrorMessage(message: final message, code: _):
        logError( message!);
    }
    return null;
  }

  Future<Result<TodoFile?>> deleteTodoFile(TodoFile todoFile) async {
    todoManager?.removeTodoFile(todoFile);
    final result = await databaseRepository.deleteTableEntry(
        todoFileTableData, TodoFileTableEntry(todoFile));
    // localRepo.deleteLocalTodoFile(todoFile);
    currentStateTableHandler.updateCurrentFiles();
    return result;
  }

  Future<TodoFile?> updateTodoFile(TodoFile todoFile) async {
    todoFile = todoFile.copyWith(lastUpdated: DateTime.now());
    todoManager?.updateTodoFile(todoFile);
    final result = await databaseRepository.updateTableEntry(
        todoFileTableData, TodoFileTableEntry(todoFile));
    // localRepo.updateLocalTodoFile(todoFile);
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
