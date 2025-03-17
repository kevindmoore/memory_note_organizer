import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_master/bloc/blocs/other_bloc.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:supa_manager/supa_manager.dart';

import '../bloc/blocs/database_bloc.dart';
import '../models/models.dart';
import '../models/search_result.dart';
import '../todos/todo_manager.dart';
import '../ui/providers.dart';
import '../utils/todo_parser.dart';
import '../utils/utils.dart';
import 'category_table_handler.dart';
import 'current_state_table_handler.dart';
import 'todo_file_table_handler.dart';
import 'todo_table_handler.dart';

class TodoRepository extends ChangeNotifier {
  final Ref? ref;
  final TodoManager? todoManager;
  final SupaDatabaseManager databaseRepository;
  bool _disableNotifyNow = false;
  var remoteTodoFiles = TodoFiles(<TodoFile>[]);
  // final LocalRepo localRepo;
  final loadRemoteFilesFirst = true;
  late TodoTableHandler todoTableHandler;
  late CategoryTableHandler categoryTableHandler;
  late CurrentStateTableHandler currentStateTableHandler;
  late TodoFileTableHandler todoFileTableHandler;

  TodoFile? get currentTodoFile => todoManager?.currentTodoFile;

  set currentTodoFile(TodoFile? todoFile) =>
      todoManager?.currentTodoFile = todoFile;

  int size() => todoManager?.size() ?? 0;

  TodoRepository(
      {required this.ref,
      required this.todoManager,
      required this.databaseRepository,
      // required this.localRepo
      }) {
    ref?.listen(databaseBlocProvider,
        (DatabaseBloc? previous, DatabaseBloc bloc) {
      logMessage('Database changed state: ${bloc.state}');
      /*     bloc.state.maybeWhen(
          todoChangedState: (Todo todo) {
            replaceTodo(todo);
          },
          todoFileChangedState: (TodoFile todoFile) {
            replaceTodoFile(todoFile);
          },
          categoryChangedState: (Category category) {
            replaceCategory(category);
          },
          todoInsertedState: (Todo todo) {
            addTodo(todo);
          },
          todoFileInsertedState: (TodoFile todoFile) {
            addTodoFile(todoFile);
          },
          categoryInsertedState: (Category category) {
            addCategory(category);
          },
          todoDeletedState: (Todo todo) {
            removeTodo(todo);
          },
          todoFileDeletedState: (TodoFile todoFile) {
            removeTodoFile(todoFile);
          },
          categoryDeletedState: (Category category) {
            removeCategory(category);
          },
          orElse: () {});
*/
    });
    // New Way
    // Steps:
    // 1. Load local database
    // 2. Load remote database
    // 3. Sync databases

    // listenToLoginState();
    // Old Way - Load from remote database
    currentStateTableHandler = CurrentStateTableHandler(
        ref, databaseRepository,
        // localRepo,
        todoManager);
    todoTableHandler =
        TodoTableHandler(ref, databaseRepository,
            // localRepo,
            todoManager);
    categoryTableHandler = CategoryTableHandler(
        ref, databaseRepository,
        // localRepo,
        todoManager, todoTableHandler);
    todoFileTableHandler = TodoFileTableHandler(ref, databaseRepository,
        // localRepo,
        todoManager, categoryTableHandler, currentStateTableHandler);
    if (loadRemoteFilesFirst) {
      // TODO: This is temporary to rebuild the database
      // localRepo.eraseDatabase();
      loadRemoteFiles();
      listenToLoginState();
    }
  }

  @override
  void dispose() {
    // if (ref != null) {
    //   ref!.read(logInStateProvider).removeListener(_loginStateListener);
    // }
    super.dispose();
    if (true) {
      logMessage('dispose: TodoRepository');
    }
  }

  void loadLocal() async {
    // await localRepo.loadLocalDatabase();
    ref?.read(otherBlocProvider).add(const OtherEvent.finishLoadingFileEvent());
    _notify();
  }

  void listenToLoginState() {
    ref?.read(logInStateProvider).addListener(_loginStateListener);
  }

  void _loginStateListener() {}

  void disableOneTimeNotification() {
    _disableNotifyNow = true;
  }

  void _notify() {
    if (!_disableNotifyNow) {
      notifyListeners();
    } else {
      _disableNotifyNow = false;
    }
  }

  void addTodoFile(TodoFile todoFile) {
    todoManager?.addTodoFile(todoFile);
    _notify();
  }

  Future<Todo?> addNewTodoToCategory(
      int? todoFileId, int? categoryId, Todo todo) async {
    final result = todoTableHandler.addNewTodoToCategory(todoFileId, categoryId, todo);
    _notify();
    return result;
  }

  Future<Todo?> addNewTodo(Todo todo, int todoFileId, int categoryId) async {
    final result = todoTableHandler.addNewTodo(todo, todoFileId, categoryId);
    _notify();
    return result;
  }

  Future<Todo?> addNewTodoToParent(
      int? todoFileId, int? categoryId, int parentId, Todo todo) async {
    return todoTableHandler.addNewTodoToParent(
        todoFileId, categoryId, parentId, todo);
  }

  void addTodo(Todo todo) {
    todoManager?.addTodo(todo);
    _notify();
  }

  Future<TodoFile?> addNewTodoFile(TodoFile todoFile) async {
    if (await todoFileTableHandler.getTodoFileByName(todoFile.name) != null) {
      logAndShowError(ref, 'List with name ${todoFile.name} already exists');
      return null;
    }
    final result = await todoFileTableHandler.addNewTodoFile(todoFile);
    _notify();
    return result;
  }

  Future<List<Category>> addCategories(
      int todoFileId, List<Category> categories) async {
    final updatedCategories = <Category>[];
    await Future.forEach(categories, (Category category) async {
      final updatedCategory = await addNewCategory(todoFileId, category);
      if (updatedCategory != null) {
        updatedCategories.add(updatedCategory);
      }
    });
    return updatedCategories;
  }

  FutureOr<TodoFiles> loadRemoteFiles() async {
    if (loadRemoteFilesFirst) {
      sendStartLoadingEvent();
    }
    final filesString = await getCurrentFilesString();
    if (filesString != null) {
      final documentIds = filesString.split(',');
      if (loadRemoteFilesFirst) {
        sendStartLoadingFileEvent();
      }
      await Future.forEach(documentIds, (String id) async {
        if (id.isEmpty) {
          return;
        }
        final stopwatch = Stopwatch()..start();
        await loadTodoFileCategoriesAndTodos(int.parse(id));
        stopwatch.stop();
        if (loadRemoteFilesFirst) {
          // endStartLoadingFileEvent();
        }
      });
      if (loadRemoteFilesFirst) {
        endStartLoadingFileEvent();
        finishedLoadingEvent();
      }
    }

    _notify();

    return remoteTodoFiles;
  }

  void sendStartLoadingEvent() {
    ref?.read(otherBlocProvider).add(const OtherEvent.startLoadingEvent());
  }

  void sendStartLoadingFileEvent() {
    ref?.read(otherBlocProvider).add(const OtherEvent.startLoadingFileEvent());
  }

  void endStartLoadingFileEvent() {
    ref?.read(otherBlocProvider).add(const OtherEvent.finishLoadingFileEvent());
  }

  void finishedLoadingEvent() {
    ref?.read(otherBlocProvider).add(const OtherEvent.finishedLoadingEvent());
  }

  Future syncRemoteFiles(TodoFiles remoteFiles) async {
    // Sync Database
    remoteTodoFiles = remoteFiles;
    final currentState = await getCurrentState();
    // await localRepo.syncDatabases(currentState, remoteFiles);
    // This has to be done by the original instance of the repository
    // todoManager?.clearAndReset(remoteFiles);
    _notify();
  }

  void updateRemoteFiles(TodoFiles remoteFiles) {
    todoManager?.clearAndReset(remoteFiles);
    _notify();
  }

  Future<TodoFile?> loadTodoFileCategoriesAndTodos(int todoFileId) async {
    final todoFile = await todoFileTableHandler.loadTodoFileCategoriesAndTodos(todoFileId);
    _notify();
    return todoFile;
  }

  Future<TodoFile?> loadTodoFile(int todoFileId) async {
    return todoFileTableHandler.loadTodoFile(todoFileId);
  }

  Future<List<Category>?> loadCategoriesForFileId(int todoFileId) async {
    return categoryTableHandler.loadCategoriesForFileId(todoFileId);

  }

  Future<List<Category>> getCategoriesWithFileId(int todoFileId) async {
    return categoryTableHandler.getCategoriesWithFileId(todoFileId);
  }

  Future<List<Todo>> getTodosWithFileAndCategory(
      int todoFileId, int categoryId) async {
    return todoTableHandler.getTodosWithFileAndCategory(todoFileId, categoryId);
  }

  Future<String?> getCurrentFilesString() async {
    return currentStateTableHandler.getCurrentFilesString();
  }

  Future<CurrentState?> getCurrentState() async {
    return currentStateTableHandler.getCurrentState();

  }

  void updateCurrentFiles() async {
    currentStateTableHandler.updateCurrentFiles();
  }

  TodoFiles? getCurrentTodoFiles() {
    return todoManager?.todoFiles;
  }

  Future<List<TodoFile>?> getTodoFiles() async {
    return todoFileTableHandler.getTodoFiles();
  }

  Future<TodoFile?> getTodoFile(int todoDocId) async {
    return todoFileTableHandler.getTodoFile(todoDocId);

  }

  Future<TodoFile?> saveTodoFile(TodoFile todoFile) async {
    return todoFileTableHandler.saveTodoFile(todoFile);
  }

  Future deleteTodoFileById(int? todoFileId) async {
    if (todoFileId == null) {
      logAndShowError(ref, 'deleteTodoFileById: todoFileId is null');
      return null;
    }
    final todoFile = findTodoFile(todoFileId);
    if (todoFile == null) {
      logAndShowError(
          ref, 'deleteTodoFileById: TodoFile not found for $todoFileId');
      return null;
    }
    return deleteTodoFile(todoFile);
  }

  Future<Result<TodoFile?>> deleteTodoFile(TodoFile todoFile) async {
    final result = todoFileTableHandler.deleteTodoFile(todoFile);
    _notify();
    return result;
  }

  void removeTodoFile(TodoFile todoFile) {
    todoManager?.removeTodoFile(todoFile);
    _notify();
  }

  Future deleteCategoryById(
      int? todoFileId, int? categoryId, bool removeFromList) async {
    if (todoFileId == null) {
      logAndShowError(ref, 'deleteCategoryById: todoFileId is null');
      return null;
    }
    if (categoryId == null) {
      logAndShowError(ref, 'deleteCategoryById: categoryId is null');
      return null;
    }
    final category = findCategory(todoFileId, categoryId);
    if (category == null) {
      logAndShowError(ref, 'deleteCategoryById: category is null');
      return null;
    }
    return deleteCategory(category, removeFromList);
  }

  Future deleteCategory(Category category, bool removeFromList) async {
    final result = categoryTableHandler.deleteCategory(category, removeFromList);
    _notify();
    return result;
  }

  Future deleteTodoById(int? todoFileId, int? categoryId, int? todoId,
      bool removeFromList) async {
    if (todoFileId == null) {
      logAndShowError(ref, 'deleteTodoById: todoFileId is null');
      return null;
    }
    if (categoryId == null) {
      logAndShowError(ref, 'deleteTodoById: categoryId is null');
      return null;
    }
    final todo = findTodo(todoFileId, categoryId, todoId);
    if (todo == null) {
      logAndShowError(ref, 'deleteTodoById: todo is null');
      return null;
    }
    return deleteTodo(todo, removeFromList);
  }

  Future deleteTodo(Todo todo, bool removeFromList) async {
    final result = todoTableHandler.deleteTodo(todo, removeFromList);
    _notify();
    return result;
  }

  Future updateTodoFileById(int? todoFileId, String updatedFileName) async {
    if (todoFileId == null) {
      logAndShowError(ref, 'updateTodoFileById: todoFileId is null');
      return null;
    }
    var todoFile = todoManager?.findTodoFile(todoFileId);
    if (todoFile == null) {
      logAndShowError(
          ref, 'updateTodoFileById: Could not find TodoFile for $todoFileId');
      return null;
    }
    todoFile =
        todoFile.copyWith(name: updatedFileName, lastUpdated: DateTime.now());
    return updateTodoFile(todoFile);
  }

  Future updateTodoFile(TodoFile todoFile) async {
    final result = todoFileTableHandler.updateTodoFile(todoFile);
    _notify();
    return result;
  }

  Future updateTodo(Todo todo) async {
    final result = todoTableHandler.updateTodo(todo);
    _notify();
    return result;
  }

  Todo? findDeepTodo(int? todoFileId, int? categoryId, int? id) {
    return todoManager?.findDeepTodo(todoFileId, categoryId, id);
  }

  Future updateCategoryById(
      int? todoFileId, int? categoryId, String updatedCategoryName) async {
    if (categoryId == null || todoFileId == null) {
      logAndShowError(
          ref, 'updateCategoryById: categoryId or todoFileId is null');
      return null;
    }
    var category = todoManager?.findFileCategory(todoFileId, categoryId);
    if (category == null) {
      logAndShowError(ref, 'updateCategoryById: category is null');
      return null;
    }
    category = category.copyWith(
        name: updatedCategoryName, lastUpdated: DateTime.now());
    return updateCategory(category);
  }

  Future updateCategory(Category updatedCategory) async {
    final result = categoryTableHandler.updateCategory(updatedCategory);
    _notify();
    return result;
  }

  void replaceCategory(Category updatedCategory) {
    todoManager?.updateCategory(updatedCategory);
    _notify();
  }

  void showSearch(SearchResult searchResult) {
    todoManager?.goToResult(searchResult);
  }

  void clear() {
    todoManager?.clear();
  }

  Future<Category?> addNewCategory(int todoFileId, Category category) async {
    return categoryTableHandler.addNewCategory(todoFileId, category);

  }

  void addCategory(Category category) {
    if (category.todoFileId == null) {
      logAndShowError(
          ref, 'addCategory: Category ${category.name} todo file id is null');
      return;
    }
    todoManager?.addCategory(category.todoFileId!, category);
    _notify();
  }

  TodoFile? findTodoFile(int? id) {
    return todoManager?.findTodoFile(id);
  }

  Todo? findTodoFromCategory(int? todoFileId, int? categoryId, int? todoId) {
    return todoManager?.findDeepTodo(todoFileId, categoryId, todoId);
  }

  Todo? findTodoInCategory(int? todoId, Category category) {
    return todoManager?.findTodoFromCategory(category, todoId);
  }

  Todo? findTodo(int? todoFileId, int? categoryId, int? id) {
    return todoManager?.findDeepTodo(todoFileId, categoryId, id);
  }

  int? findTodoIndex(int? todoFileId, int? categoryId, int? id) {
    return todoManager?.findTodoIndex(todoFileId, categoryId, id);
  }

  Todo? findTodoInParentTodo(
      int? todoFileId, int? categoryId, int? parentId, int? id) {
    return todoManager?.findTodoInParentTodo(
        todoFileId, categoryId, parentId, id);
  }

  Category? findCategory(int? todoFileId, int? categoryId) {
    return todoManager?.findFileCategory(todoFileId, categoryId);
  }

  int getTodoChildCount(int? todoFileId, int? categoryId, int? id) {
    return todoManager?.getTodoChildCount(todoFileId, categoryId, id) ?? 0;
  }

  String? findTodoFileName(int? id) {
    return todoManager?.findTodoFileName(id);
  }

  String? findCategoryName(int? todoFileId, int? id) {
    return todoManager?.findCategoryName(todoFileId, id);
  }

  String? findTodoName(int? todoFileId, int? categoryId, int? id) {
    return todoManager?.findTodoName(todoFileId, categoryId, id);
  }

  void openTodoFile(int todoFileId) async {
    if (todoManager?.findTodoFile(todoFileId) != null) {
      logMessage('List already open');
      return;
    }
    ref?.read(otherBlocProvider).add(const OtherEvent.startLoadingFileEvent());
    final todoFile = await loadTodoFileCategoriesAndTodos(todoFileId);
    if (todoFile != null) {
      todoManager?.addTodoFile(todoFile);
    }
    updateCurrentFiles();
    ref?.read(otherBlocProvider).add(const OtherEvent.finishLoadingFileEvent());
    _notify();
  }

  Future reloadTodoFile(int todoFileId) async {
    ref?.read(otherBlocProvider).add(const OtherEvent.startLoadingFileEvent());
    final todoFile = await loadTodoFileCategoriesAndTodos(todoFileId);
    if (todoFile != null) {
      todoManager?.addTodoFile(todoFile);
    }
    ref?.read(otherBlocProvider).add(const OtherEvent.finishLoadingFileEvent());
  }

  void replaceTodoFile(TodoFile todoFile) async {
    ref?.read(otherBlocProvider).add(const OtherEvent.startLoadingFileEvent());
    todoManager?.replaceUpdatedTodoFile(todoFile);
    _notify();
    ref?.read(otherBlocProvider).add(const OtherEvent.finishLoadingFileEvent());
  }

  void setCurrentTodoFile(TodoFile todoFile) {
    todoManager?.setCurrentTodoFile(todoFile);
  }

  void removeCurrentTodoFile() {
    todoManager?.removeCurrentTodoFile();
    updateCurrentFiles();
    _notify();
  }

  void closeAllFiles() {
    todoManager?.closeAllFiles();
    updateCurrentFiles();
    _notify();
  }

  void reload() async {
    todoManager?.clearList();
    loadRemoteFiles();
  }

  void loadFile(File file, String name) async {
    if (await file.exists()) {
      ref
          ?.read(otherBlocProvider)
          .add(const OtherEvent.startLoadingFileEvent());
      file.readAsString().then((String contents) async {
        final todoParser = TodoParser();
        final todoFile = todoParser.parseFile(name, contents);
        await saveTodoFile(todoFile);
        ref
            ?.read(otherBlocProvider)
            .add(const OtherEvent.finishLoadingFileEvent());
        _notify();
      });
    }
  }

  Future<TodoFile?> duplicateTodoFile(int? todoFileId, String newName) async {
    if (todoFileId == null) {
      logAndShowError(ref, 'todoFileId is null');
      return null;
    }
    final todoFile = todoManager?.findTodoFile(todoFileId);
    if (todoFile == null) {
      logAndShowError(ref, 'todoFile not found');
      return null;
    }

    final copiedTodoFile =
        todoFile.copyWith(name: newName, id: null, lastUpdated: DateTime.now());
    return addNewTodoFile(copiedTodoFile);
  }

  Future<Category?> duplicateCategory(
      int? todoFileId, int? categoryId, String newName) async {
    if (todoFileId == null) {
      logAndShowError(ref, 'todoFileId is null');
      return null;
    }
    if (categoryId == null) {
      logAndShowError(ref, 'categoryId is null');
      return null;
    }
    final category = todoManager?.findFileCategory(todoFileId, categoryId);
    if (category == null) {
      logAndShowError(ref, 'category not found');
      return null;
    }

    final copiedCategory =
        category.copyWith(name: newName, id: null, lastUpdated: DateTime.now());
    return addNewCategory(todoFileId, copiedCategory);
  }

  Future<Todo?> duplicateTodo(
      int? todoFileId, int? categoryId, int? id, String newName) async {
    if (todoFileId == null) {
      logAndShowError(ref, 'todoFileId is null');
      return null;
    }
    if (categoryId == null) {
      logAndShowError(ref, 'categoryId is null');
      return null;
    }
    if (id == null) {
      logAndShowError(ref, 'id is null');
      return null;
    }
    final todo = todoManager?.findDeepTodo(todoFileId, categoryId, id);
    if (todo == null) {
      logAndShowError(ref, 'todo not found');
      return null;
    }

    final copiedTodo =
        todo.copyWith(name: newName, id: null, lastUpdated: DateTime.now());
    if (copiedTodo.parentTodoId != null) {
      return addNewTodoToParent(
          todoFileId, categoryId, copiedTodo.parentTodoId!, todo);
    } else {
      return addNewTodoToCategory(todoFileId, categoryId, copiedTodo);
    }
  }
}
