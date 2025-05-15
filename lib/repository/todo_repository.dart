import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:supa_manager/supa_manager.dart';
import 'package:memory_notes_organizer/providers.dart';
import 'package:memory_notes_organizer/repository/todo_parser.dart';

import '../models/models.dart';
import '../models/search_result.dart';
import '../todos/todo_manager.dart';
import 'category_table_handler.dart';
import 'current_state_table_handler.dart';
import 'todo_file_table_handler.dart';
import 'todo_table_handler.dart';

class TodoRepository extends ChangeNotifier {
  final Ref ref;
  final TodoManager todoManager;
  final SupaDatabaseManager databaseRepository;
  bool _disableNotifyNow = false;
  bool _loading = false;
  var remoteTodoFiles = TodoFiles(<TodoFile>[]);

  // final LocalRepo localRepo;
  final loadRemoteFilesFirst = true;
  late TodoTableHandler todoTableHandler;
  late CategoryTableHandler categoryTableHandler;
  late CurrentStateTableHandler currentStateTableHandler;
  late TodoFileTableHandler todoFileTableHandler;

  TodoFile? get currentTodoFile => todoManager.currentTodoFile;

  set currentTodoFile(TodoFile? todoFile) => todoManager.currentTodoFile = todoFile;

  int size() => todoManager.size();

  TodoRepository({
    required this.ref,
    required this.todoManager,
    required this.databaseRepository,
    // required this.localRepo
  }) {
    _loading = true;
    // New Way
    // Steps:
    // 1. Load local database
    // 2. Load remote database
    // 3. Sync databases

    // listenToLoginState();
    // Old Way - Load from remote database
    currentStateTableHandler = CurrentStateTableHandler(
      ref,
      databaseRepository,
      // localRepo,
      todoManager,
    );
    todoTableHandler = TodoTableHandler(
      ref,
      databaseRepository,
      // localRepo,
      todoManager,
    );
    categoryTableHandler = CategoryTableHandler(
      ref,
      databaseRepository,
      // localRepo,
      todoManager,
      todoTableHandler,
    );
    todoFileTableHandler = TodoFileTableHandler(
      ref,
      databaseRepository,
      // localRepo,
      todoManager,
      categoryTableHandler,
      currentStateTableHandler,
    );
    if (loadRemoteFilesFirst) {
      // TODO: This is temporary to rebuild the database
      // localRepo.eraseDatabase();
      loadRemoteFiles();
      listenToLoginState();
    }
  }

  bool get loading => _loading;

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
    _notify();
  }

  void listenToLoginState() {
    ref.read(logInStateProvider).addListener(_loginStateListener);
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

  Future<Todo?> addNewTodoToCategory(int? todoFileId, int? categoryId, Todo todo) async {
    final newTodo = todoTableHandler.addNewTodoToCategory(todoFileId, categoryId, todo);
    _notify();
    return newTodo;
  }

  Future<Todo?> addNewTodo(int todoFileId, int categoryId, Todo todo) async {
    final newTodo = todoTableHandler.addNewTodo(todo, todoFileId, categoryId);
    _notify();
    return newTodo;
  }

  Future<Todo?> addNewTodoToParent(
    int? todoFileId,
    int? categoryId,
    int parentId,
    Todo todo,
  ) async {
    return todoTableHandler.addNewTodoToParent(todoFileId, categoryId, parentId, todo);
  }

  void addTodo(Todo todo) {
    todoManager.addTodo(todo);
    _notify();
  }

  Future<TodoFile> addNewTodoFile(TodoFile todoFile) async {
    if (await todoFileTableHandler.getTodoFileByName(todoFile.name) != null) {
      logError('List with name ${todoFile.name} already exists');
      return todoFile;
    }
    final updatedTodoFile = todoFile.copyWith(lastUpdated: DateTime.now());
    final newTodoFile = await todoFileTableHandler.addNewTodoFile(updatedTodoFile);
    _notify();
    return newTodoFile;
  }

  TodoFile addCategoryToTodoFile(TodoFile todoFile, Category category) {
    return todoFile.copyWith(categories: [...todoFile.categories, category]);
  }

  Future<List<Category>> addCategories(int todoFileId, List<Category> categories) async {
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
    final filesString = await getCurrentFilesString();
    List<TodoFile> currentTodoFiles = [];
    if (filesString != null) {
      final documentIds = filesString.split(',');
      await Future.forEach(documentIds, (String id) async {
        if (id.isEmpty) {
          return;
        }
        final stopwatch = Stopwatch()..start();
        TodoFile? todoFile = await loadTodoFileCategoriesAndTodos(int.parse(id));
        if (todoFile != null) {
          currentTodoFiles.add(todoFile);
        }
        stopwatch.stop();
        if (loadRemoteFilesFirst) {}
      });
      _loading = false;
      sortTodoFiles(currentTodoFiles);
      // logMessage('Loaded ${currentTodoFiles.length} files: $currentTodoFiles');
      ref.read(currentFilesProvider.notifier).setTodoFiles(currentTodoFiles);
    }

    _notify();

    return remoteTodoFiles;
  }

  Future syncRemoteFiles(TodoFiles remoteFiles) async {
    // Sync Database
    remoteTodoFiles = remoteFiles;
    // final currentState = await getCurrentState();
    // await localRepo.syncDatabases(currentState, remoteFiles);
    // This has to be done by the original instance of the repository
    // todoManager.clearAndReset(remoteFiles);
    _notify();
  }

  void updateRemoteFiles(TodoFiles remoteFiles) {
    todoManager.clearAndReset(remoteFiles);
    _notify();
  }

  Future<TodoFile?> loadTodoFileCategoriesAndTodos(int todoFileId) async {
    var todoFile = await todoFileTableHandler.loadTodoFileCategoriesAndTodos(todoFileId);
    if (todoFile != null) {
      List<Category> sortedCategories = List.from(todoFile.categories);
      sortCategories(sortedCategories);
      todoFile = todoFile.copyWith(categories: sortedCategories);
    }
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
    return categoryTableHandler.getCategoriesAndTodosWithFileId(todoFileId);
  }

  Future<List<Todo>> getTodosWithFileAndCategory(int todoFileId, int categoryId) async {
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
    return todoManager.todoFiles;
  }

  Future<List<TodoFile>?> getTodoFiles() async {
    var todoFiles = await todoFileTableHandler.getTodoFiles();
    if (todoFiles != null) {
      sortTodoFiles(todoFiles);
    }
    return todoFiles;
  }

  Future<TodoFile?> getTodoFile(int todoDocId) async {
    return todoFileTableHandler.getTodoFile(todoDocId);
  }

  Future<TodoFile?> saveTodoFile(TodoFile todoFile) async {
    return todoFileTableHandler.saveTodoFile(todoFile);
  }

  Future deleteTodoFileById(int? todoFileId) async {
    if (todoFileId == null) {
      logError('deleteTodoFileById: todoFileId is null');
      return null;
    }
    final todoFile = findTodoFile(todoFileId);
    if (todoFile == null) {
      logError('deleteTodoFileById: TodoFile not found for $todoFileId');
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
    todoManager.removeTodoFile(todoFile);
    _notify();
  }

  Future deleteCategoryById(int? todoFileId, int? categoryId, bool removeFromList) async {
    if (todoFileId == null) {
      logError('deleteCategoryById: todoFileId is null');
      return null;
    }
    if (categoryId == null) {
      logError('deleteCategoryById: categoryId is null');
      return null;
    }
    final category = findCategory(todoFileId, categoryId);
    if (category == null) {
      logError('deleteCategoryById: category is null');
      return null;
    }
    return deleteCategory(category, removeFromList);
  }

  Future deleteCategory(Category category, bool removeFromList) async {
    final result = categoryTableHandler.deleteCategory(category, removeFromList);
    _notify();
    return result;
  }

  Future deleteTodoById(int? todoFileId, int? categoryId, int? todoId, bool removeFromList) async {
    if (todoFileId == null) {
      logError('deleteTodoById: todoFileId is null');
      return null;
    }
    if (categoryId == null) {
      logError('deleteTodoById: categoryId is null');
      return null;
    }
    final todo = findTodo(todoFileId, categoryId, todoId);
    if (todo == null) {
      logError('deleteTodoById: todo is null');
      return null;
    }
    return deleteTodo(todo, removeFromList);
  }

  Future deleteTodo(Todo todo, bool removeFromList) async {
    final result = todoTableHandler.deleteTodo(todo, removeFromList);
    _notify();
    return result;
  }

  Future deleteTodosAndChildren(Todo todo, bool removeFromList) async {
    // 1st delete the children
    for (final child in todo.children) {
      await deleteTodo(child, removeFromList);
    }
    final result = todoTableHandler.deleteTodo(todo, removeFromList);
    _notify();
    return result;
  }

  Future updateTodoFileById(int? todoFileId, String updatedFileName) async {
    if (todoFileId == null) {
      logError('updateTodoFileById: todoFileId is null');
      return null;
    }
    var todoFile = todoManager.findTodoFile(todoFileId);
    if (todoFile == null) {
      logError('updateTodoFileById: Could not find TodoFile for $todoFileId');
      return null;
    }
    todoFile = todoFile.copyWith(name: updatedFileName);
    return updateTodoFile(todoFile);
  }

  Future<TodoFile?> updateTodoFile(TodoFile todoFile) async {
    TodoFile? updatedTodoFile = todoFile.copyWith(lastUpdated: DateTime.now());
    updatedTodoFile = await todoFileTableHandler.updateTodoFile(updatedTodoFile);
    _notify();
    return updatedTodoFile;
  }

  Future<Todo?> updateTodo(Todo todo) async {
    final updatedTodo = await todoTableHandler.updateTodo(todo);
    _notify();
    return updatedTodo;
  }

  Todo? findDeepTodo(int? todoFileId, int? categoryId, int? id) {
    return todoManager.findDeepTodo(todoFileId, categoryId, id);
  }

  Future updateCategoryById(int? todoFileId, int? categoryId, String updatedCategoryName) async {
    if (categoryId == null || todoFileId == null) {
      logError('updateCategoryById: categoryId or todoFileId is null');
      return null;
    }
    var category = todoManager.findFileCategory(todoFileId, categoryId);
    if (category == null) {
      logError('updateCategoryById: category is null');
      return null;
    }
    category = category.copyWith(name: updatedCategoryName);
    return updateCategory(category);
  }

  Future updateCategory(Category updatedCategory) async {
    updatedCategory = updatedCategory.copyWith(lastUpdated: DateTime.now());
    final result = categoryTableHandler.updateCategory(updatedCategory);
    _notify();
    return result;
  }

  void replaceCategory(Category updatedCategory) {
    todoManager.updateCategory(updatedCategory);
    _notify();
  }

  void showSearch(SearchResult searchResult) {
    todoManager.goToResult(searchResult);
  }

  void clear() {
    todoManager.clear();
  }

  Future<Category?> addNewCategory(int todoFileId, Category category) async {
    Category? updatedCategory = category.copyWith(lastUpdated: DateTime.now());
    var todoFile = findTodoFile(todoFileId);
    if (todoFile != null) {
      updateTodoFile(todoFile);
    }
    updatedCategory = await categoryTableHandler.addNewCategory(todoFileId, updatedCategory);
    return updatedCategory;
  }

  TodoFile? findTodoFile(int? id) {
    return todoManager.findTodoFile(id);
  }

  Todo? findTodoFromCategory(int? todoFileId, int? categoryId, int? todoId) {
    return todoManager.findDeepTodo(todoFileId, categoryId, todoId);
  }

  Todo? findTodoInCategory(int? todoId, Category category) {
    return todoManager.findTodoFromCategory(category, todoId);
  }

  Todo? findTodo(int? todoFileId, int? categoryId, int? id) {
    return todoManager.findDeepTodo(todoFileId, categoryId, id);
  }

  int findTodoIndex(int? todoFileId, int? categoryId, int? id) {
    return todoManager.findTodoIndex(todoFileId, categoryId, id);
  }

  int findTodoFileIndex(int todoFileId) {
    return todoManager.findTodoFileIndex(todoFileId);
  }

  int findCategoryIndex(int todoFileId, int categoryId) {
    return todoManager.findCategoryIndex(todoFileId, categoryId);
  }

  Todo? findTodoInParentTodo(int? todoFileId, int? categoryId, int? parentId, int? id) {
    return todoManager.findTodoInParentTodo(todoFileId, categoryId, parentId, id);
  }

  Category? findCategory(int? todoFileId, int? categoryId) {
    return todoManager.findFileCategory(todoFileId, categoryId);
  }

  int getTodoChildCount(int? todoFileId, int? categoryId, int? id) {
    return todoManager.getTodoChildCount(todoFileId, categoryId, id);
  }

  String? findTodoFileName(int? id) {
    return todoManager.findTodoFileName(id);
  }

  String? findCategoryName(int? todoFileId, int? id) {
    return todoManager.findCategoryName(todoFileId, id);
  }

  String? findTodoName(int? todoFileId, int? categoryId, int? id) {
    return todoManager.findTodoName(todoFileId, categoryId, id);
  }

  void openTodoFile(int todoFileId) async {
    if (todoManager.findTodoFile(todoFileId) != null) {
      logMessage('List already open');
      return;
    }
    final todoFile = await loadTodoFileCategoriesAndTodos(todoFileId);
    if (todoFile != null) {
      todoManager.addTodoFile(todoFile);
    }
    updateCurrentFiles();
    _notify();
  }

  Future<TodoFile?> reloadTodoFile(int todoFileId) async {
    final todoFile = await loadTodoFileCategoriesAndTodos(todoFileId);
    if (todoFile != null) {
      todoManager.addTodoFile(todoFile);
    }
    return todoFile;
  }

  void replaceTodoFile(TodoFile todoFile) async {
    todoManager.replaceUpdatedTodoFile(todoFile);
    _notify();
  }

  void setCurrentTodoFile(TodoFile todoFile) {
    todoManager.setCurrentTodoFile(todoFile);
  }

  void removeCurrentTodoFile() {
    todoManager.removeCurrentTodoFile();
    updateCurrentFiles();
    _notify();
  }

  void closeFile(TodoFile todoFile) {
    todoManager.closeFile(todoFile);
    updateCurrentFiles();
    _notify();
  }

  void closeAllFiles() {
    todoManager.closeAllFiles();
    updateCurrentFiles();
    _notify();
  }

  FutureOr<TodoFiles> reload() async {
    todoManager.clearList();
    return await loadRemoteFiles();
  }

  void loadFile(File file, String name) async {
    if (await file.exists()) {
      file.readAsString().then((String contents) async {
        final todoParser = TodoParser();
        final todoFile = todoParser.parseFile(name, contents);
        await saveTodoFile(todoFile);
        _notify();
      });
    }
  }

  Future<TodoFile?> duplicateTodoFile(int? todoFileId, String newName) async {
    if (todoFileId == null) {
      logError('todoFileId is null');
      return null;
    }
    final todoFile = todoManager.findTodoFile(todoFileId);
    if (todoFile == null) {
      logError('todoFile not found');
      return null;
    }

    final copiedTodoFile = todoFile.copyWith(name: newName, id: null, lastUpdated: DateTime.now());
    return addNewTodoFile(copiedTodoFile);
  }

  Future<Category?> duplicateCategory(int? todoFileId, int? categoryId, String newName) async {
    if (todoFileId == null) {
      logError('todoFileId is null');
      return null;
    }
    if (categoryId == null) {
      logError('categoryId is null');
      return null;
    }
    final category = todoManager.findFileCategory(todoFileId, categoryId);
    if (category == null) {
      logError('category not found');
      return null;
    }

    final todoFile = todoManager.findTodoFile(todoFileId);
    Category? copiedCategory = category.copyWith(name: newName, id: null, lastUpdated: DateTime.now());
    copiedCategory = await addNewCategory(todoFileId, copiedCategory);
    if (copiedCategory == null) {
      logError('copiedCategory is null');
      return null;
    }
    todoManager.addCategory(todoFileId, copiedCategory);
    final List<Todo> childTodos = [];
    for (final todo in category.todos) {
      var copiedTodo = await duplicateTodo(todoFileId, category.id, copiedCategory.id, todo.id, todo.name);
      if (copiedTodo != null) {
        childTodos.add(copiedTodo);
      }
    }
    copiedCategory = copiedCategory.copyWith(todos: childTodos);
    return copiedCategory;
  }

  Future<Todo?> duplicateTodo(int? todoFileId, int? categoryId, int? newCategoryId, int? id, String newName) async {
    if (todoFileId == null) {
      logError('todoFileId is null');
      return null;
    }
    if (categoryId == null) {
      logError('categoryId is null');
      return null;
    }
    if (id == null) {
      logError('id is null');
      return null;
    }
    final todo = todoManager.findDeepTodo(todoFileId, categoryId, id);
    if (todo == null) {
      logError('todo not found');
      return null;
    }

    final copiedTodo = todo.copyWith(name: newName, id: null, lastUpdated: DateTime.now());
    if (copiedTodo.parentTodoId != null) {
      return await addNewTodoToParent(todoFileId, newCategoryId, copiedTodo.parentTodoId!, todo);
    } else {
      return await addNewTodoToCategory(todoFileId, newCategoryId, copiedTodo);
    }
  }
}

/// Sort List of TodoFiles. Sorts in place
void sortTodoFiles(List<TodoFile> todoFiles) {
  todoFiles.sort((a, b) {
    // Use last_updated if available, otherwise fallback to created_at
    DateTime? dateA = a.lastUpdated ?? a.createdAt;
    DateTime? dateB = b.lastUpdated ?? b.createdAt;
    // Handle nulls first - place them at the end
    if (dateA == null && dateB == null) {
      // print('  Result: 0 (Both null)');
      return 0; // Both null, equal
    } else if (dateA == null) {
      // print('  Result: 1 (A is null, Nulls Last)');
      return 1; // a is null, b is not. a comes after b (nulls last).
    } else if (dateB == null) {
      // print('  Result: -1 (B is null, Nulls Last)');
      return -1; // b is null, a is not. a comes before b (nulls last).
    } else {
      // Both are non-null, compare descending (latest first)
      int comparisonResult = dateB.compareTo(dateA); // <<< Ensure this line is active
      // print('  Result: $comparisonResult (dateB.compareTo(dateA))');
      return comparisonResult;
    }
  });
}

/// Sort List of Category. Sorts in place
void sortCategories(List<Category> categories) {
  categories.sort((a, b) {
    // Use last_updated if available, otherwise fallback to created_at
    DateTime? dateA = a.lastUpdated ?? a.createdAt;
    DateTime? dateB = b.lastUpdated ?? b.createdAt;
    // Handle nulls first - place them at the end
    if (dateA == null && dateB == null) {
      // print('  Result: 0 (Both null)');
      return 0; // Both null, equal
    } else if (dateA == null) {
      // print('  Result: 1 (A is null, Nulls Last)');
      return 1; // a is null, b is not. a comes after b (nulls last).
    } else if (dateB == null) {
      // print('  Result: -1 (B is null, Nulls Last)');
      return -1; // b is null, a is not. a comes before b (nulls last).
    } else {
      // Both are non-null, compare descending (latest first)
      int comparisonResult = dateB.compareTo(dateA); // <<< Ensure this line is active
      // print('  Result: $comparisonResult (dateB.compareTo(dateA))');
      return comparisonResult;
    }
  });
}

/// Sort List of Todos. Sorts in place
void sortTodos(List<Todo> todos) {
  todos.sort((a, b) {
    // Use last_updated if available, otherwise fallback to created_at
    DateTime? dateA = a.lastUpdated ?? a.createdAt;
    DateTime? dateB = b.lastUpdated ?? b.createdAt;
    // Handle nulls first - place them at the end
    if (dateA == null && dateB == null) {
      // print('  Result: 0 (Both null)');
      return 0; // Both null, equal
    } else if (dateA == null) {
      // print('  Result: 1 (A is null, Nulls Last)');
      return 1; // a is null, b is not. a comes after b (nulls last).
    } else if (dateB == null) {
      // print('  Result: -1 (B is null, Nulls Last)');
      return -1; // b is null, a is not. a comes before b (nulls last).
    } else {
      // Both are non-null, compare descending (latest first)
      int comparisonResult = dateB.compareTo(dateA); // <<< Ensure this line is active
      // print('  Result: $comparisonResult (dateB.compareTo(dateA))');
      return comparisonResult;
    }
  });
}
