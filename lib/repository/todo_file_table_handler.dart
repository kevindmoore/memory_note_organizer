import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supa_manager/supa_manager.dart';

import '../bloc/blocs/other_bloc.dart';
import '../models/models.dart';
import '../todos/todo_manager.dart';
import '../ui/providers.dart';
import '../utils/utils.dart';
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

  Future<TodoFile?> addNewTodoFile(TodoFile todoFile) async {
    ref?.read(otherBlocProvider).add(const OtherEvent.startLoadingFileEvent());
    final result = await databaseRepository.addEntry(
        todoFileTableData, TodoFileTableEntry(todoFile));

    return await result.when(success: (data) async {
      final updatedCategories = await addCategories(data.id!, data.categories);
      final updateTodoFile = data.copyWith(
          categories: updatedCategories, lastUpdated: DateTime.now());
      todoManager?.addTodoFile(updateTodoFile);
      currentTodoFile = updateTodoFile;
      currentStateTableHandler.updateCurrentFiles();
      // localRepo.addLocalTodoFile(updateTodoFile);
      ref
          ?.read(otherBlocProvider)
          .add(const OtherEvent.finishLoadingFileEvent());
      return updateTodoFile;
    }, failure: (Exception error) {
      logAndShowError(ref, error.toString());
      ref
          ?.read(otherBlocProvider)
          .add(const OtherEvent.finishLoadingFileEvent());
      return null;
    }, errorMessage: (int code, String? message) {
      logAndShowError(ref, message!);
      ref
          ?.read(otherBlocProvider)
          .add(const OtherEvent.finishLoadingFileEvent());
      return null;
    });
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
    final todoFile = await result.when(success: (data) async {
      final categories = await categoryTableHandler.getCategoriesWithFileId(data.id);
      if (categories.isNotEmpty) {
        data =
            data.copyWith(categories: categories, lastUpdated: DateTime.now());
      }
      if (loadRemoteFilesFirst) {
        todoManager?.addTodoFileNow(data);
      } else {
        remoteTodoFiles.addTodoFile(data);
      }
      return data;
    }, failure: (Exception error) {
      logAndShowError(ref, error.toString());
    }, errorMessage: (int code, String? message) {
      logAndShowError(ref, message!);
    });
    return todoFile;
  }

  Future<TodoFile?> loadTodoFile(int todoFileId) async {
    final result =
        await databaseRepository.readEntry(todoFileTableData, todoFileId);
    return result.when(success: (data) {
      return data;
    }, failure: (Exception error) {
      logAndShowError(ref, error.toString());
      return null;
    }, errorMessage: (int code, String? message) {
      logAndShowError(ref, message!);
      return null;
    });
  }

  Future<List<TodoFile>?> getTodoFiles() async {
    final result = await databaseRepository.readEntries(todoFileTableData);
    return await result.when(success: (data) async {
      return data;
    }, failure: (Exception error) {
      logAndShowError(ref, error.toString());
      return null;
    }, errorMessage: (int code, String? message) {
      logAndShowError(ref, message!);
      return null;
    });
  }

  Future<TodoFile?> getTodoFile(int todoDocId) async {
    final result =
        await databaseRepository.readEntry(todoFileTableData, todoDocId);
    return await result.when(success: (data) async {
      return data;
    }, failure: (Exception error) {
      logAndShowError(ref, error.toString());
      return null;
    }, errorMessage: (int code, String? message) {
      logAndShowError(ref, message!);
      return null;
    });
  }

  Future<TodoFile?> getTodoFileByName(String name) async {
    final result =
        await databaseRepository.readEntriesWhere(todoFileTableData, nameField, name);
    return await result.when(success: (data) async {
      return (data as List<TodoFile>).firstOrNull;
    }, failure: (Exception error) {
      logAndShowError(ref, error.toString());
      return null;
    }, errorMessage: (int code, String? message) {
      logAndShowError(ref, message!);
      return null;
    });
  }

  Future<TodoFile?> saveTodoFile(TodoFile todoFile) async {
    final result = await databaseRepository.addEntry(
        todoFileTableData, TodoFileTableEntry(todoFile));
    return await result.when(success: (data) async {
      todoManager?.addTodoFile(data);
      currentTodoFile = data;
      currentStateTableHandler.updateCurrentFiles();
      return data;
    }, failure: (Exception error) {
      logAndShowError(ref, error.toString());
      return null;
    }, errorMessage: (int code, String? message) {
      logAndShowError(ref, message!);
      return null;
    });
  }

  Future<Result<TodoFile?>> deleteTodoFile(TodoFile todoFile) async {
    todoManager?.removeTodoFile(todoFile);
    final result = await databaseRepository.deleteTableEntry(
        todoFileTableData, TodoFileTableEntry(todoFile));
    // localRepo.deleteLocalTodoFile(todoFile);
    currentStateTableHandler.updateCurrentFiles();
    return result;
  }

  Future updateTodoFile(TodoFile todoFile) async {
    todoFile = todoFile.copyWith(lastUpdated: DateTime.now());
    todoManager?.updateTodoFile(todoFile);
    final result = await databaseRepository.updateTableEntry(
        todoFileTableData, TodoFileTableEntry(todoFile));
    // localRepo.updateLocalTodoFile(todoFile);
    return result.when(success: (data) async {
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
