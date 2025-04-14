import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:memory_notes_organizer/models/selection_state.dart';
import 'package:memory_notes_organizer/providers.dart';
import 'package:memory_notes_organizer/repository/todo_repository.dart';

import '../models/categories.dart';
import '../models/search_result.dart';
import '../models/todo_files.dart';
import '../models/todos.dart';

class TodoManager extends ChangeNotifier {
  final Ref? ref;

  var todoFiles = TodoFiles(<TodoFile>[]);
  TodoFile? currentTodoFile;

  TodoManager(this.ref);

  int size() => todoFiles.files.length;

  void addTodoFile(TodoFile todoFile) {
    currentTodoFile ??= todoFile;
    todoFiles.addTodoFile(todoFile);
    sortTodoFiles(todoFiles.files);
    notifyListeners();
  }

  void addTodoFileNow(TodoFile todoFile) {
    currentTodoFile ??= todoFile;
    todoFiles.addTodoFile(todoFile);
  }

  void addCategory(int todoFileId, Category category) {
    final todoFile = findTodoFile(todoFileId);
    if (todoFile == null) {
      logError('addCategory: todoFile is null for ${category.name}');
      return;
    }
    List<Category> sortedCategories = List.from(todoFile.categories);
    sortCategories(sortedCategories);
    var updatedTodoFile = todoFile.copyWith(
      categories: [...sortedCategories, category],
    );
    replaceUpdatedTodoFile(updatedTodoFile);
  }

  void setCurrentTodoFile(TodoFile todoFile) {
    currentTodoFile = todoFile;
  }

  void clear() {
    todoFiles.files.clear();
  }

  void clearList() async {
    todoFiles.files.clear();
    currentTodoFile = null;
    notifyListeners();
  }

  void clearAndReset(TodoFiles updatedTodoFiles) async {
    todoFiles.files.clear();
    currentTodoFile = null;
    for (final todoFile in updatedTodoFiles.files) {
      addTodoFile(todoFile);
    }
    notifyListeners();
  }

  void removeCurrentTodoFile() {
    if (currentTodoFile != null) {
      final index = todoFiles.files.indexOf(currentTodoFile!);
      todoFiles.files.remove(currentTodoFile);
      currentTodoFile = null;
      if (index > 0 && todoFiles.files.isNotEmpty) {
        currentTodoFile = todoFiles.files[index - 1];
      }
      notifyListeners();
    }
  }

  void closeFile(TodoFile todoFile) {
    currentTodoFile = todoFile;
    removeCurrentTodoFile();
  }

  void closeAllFiles() {
    clearList();
    notifyListeners();
  }

  String buildCurrentFilesString() {
    var filesString = '';
    if (todoFiles.files.isNotEmpty) {
      for (final todoFile in todoFiles.files) {
        if (todoFile.id != null) {
          filesString = '$filesString${todoFile.id!},';
        }
      }

      if (filesString.isNotEmpty) {
        filesString = filesString.replaceFirst(',', '', filesString.length - 1);
      }
    }
    return filesString;
  }

  void removeTodoFile(TodoFile todoFile) {
    todoFiles.files.remove(todoFile);
    notifyListeners();
  }

  void addTodoFiles(List<TodoFile> newTodoFiles) {
    if (newTodoFiles.isEmpty) {
      return;
    }
    currentTodoFile ??= newTodoFiles[0];
    todoFiles.addAll(newTodoFiles);
    notifyListeners();
  }

  bool contains(String string1, String string2) {
    return string1.toLowerCase().contains(string2.toLowerCase());
  }

  List<SearchResult> search(String text) {
    final results = <SearchResult>[];
    for (final todoFile in todoFiles.files) {
      if (contains(todoFile.name, text)) {
        results.add(
          SearchResult(
            searchType: SearchType.file,
            fullText: todoFile.name,
            path: ResultPath(todoFileId: todoFile.id!),
            todoFile: todoFile,
          ),
        );
      }

      for (final category in todoFile.categories) {
        if (contains(category.name, text)) {
          results.add(
            SearchResult(
              searchType: SearchType.category,
              fullText: category.name,
              path: ResultPath(
                todoFileId: todoFile.id!,
                categoryId: category.id,
              ),
              todoFile: todoFile,
              category: category,
            ),
          );
        }
        for (final todo in category.todos) {
          final todoResults = searchTodo(todo, todoFile, category, text);
          if (todoResults.isNotEmpty) {
            results.addAll(todoResults);
          }
        }
      }
    }
    return results;
  }

  List<SearchResult> searchTodo(
    Todo todo,
    TodoFile todoFile,
    Category category,
    String text,
  ) {
    final results = <SearchResult>[];
    if (todoFile.id == null) {
      logError('TodoFile ${todoFile.name} document id is null');
    }
    if (todoFile.id != null &&
        (contains(todo.name, text) || contains(todo.notes, text))) {
      results.add(
        SearchResult(
          searchType: SearchType.todo,
          fullText: todo.name,
          path: ResultPath(
            todoFileId: todoFile.id!,
            categoryId: category.id,
            todoId: todo.id,
          ),
          todoFile: todoFile,
          category: category,
          todo: todo,
        ),
      );
    }
    if (todo.children.isNotEmpty) {
      for (final childTodo in todo.children) {
        final childResults = searchTodo(childTodo, todoFile, category, text);
        if (childResults.isNotEmpty) {
          results.addAll(childResults);
        }
      }
    }
    return results;
  }

  void _sendFileSearch(SearchResult searchResult) {
    final index = selectFile(searchResult.path.todoFileId);
    if (index != -1) {
      ref
          ?.read(searchBusProvider)
          .fire(
            SelectionState(
              todoFileId: searchResult.path.todoFileId,
              fileIndex: index,
            ),
          );
    }
  }

  void _sendCategorySearch(SearchResult searchResult) {
    final index = selectFile(searchResult.path.todoFileId);
    if (index != -1) {
      final categoryIndex = selectCategory(index, searchResult.path.categoryId);
      if (categoryIndex != -1) {
        ref
            ?.read(searchBusProvider)
            .fire(
              SelectionState(
                todoFileId: searchResult.path.todoFileId,
                fileIndex: index,
                categoryIndex: categoryIndex,
                categoryId: searchResult.path.categoryId,
              ),
            );
      }
    }
  }

  void _sendTodoSearch(SearchResult searchResult) {
    final index = selectFile(searchResult.path.todoFileId);
    if (index != -1) {
      final categoryIndex = selectCategory(index, searchResult.path.categoryId);
      if (categoryIndex != -1) {
        ref
            ?.read(searchBusProvider)
            .fire(
              SelectionState(
                todoFileId: searchResult.path.todoFileId,
                fileIndex: index,
                categoryIndex: categoryIndex,
                categoryId: searchResult.path.categoryId,
                todoId: searchResult.path.todoId!,
              ),
            );
      }
    }
  }

  void goToResult(SearchResult searchResult) {
    switch (searchResult.searchType) {
      case SearchType.file:
        _sendFileSearch(searchResult);
        break;
      case SearchType.category:
        _sendCategorySearch(searchResult);
        break;
      case SearchType.todo:
        _sendTodoSearch(searchResult);
        break;
    }
  }

  TodoFile? findTodoFile(int? id) {
    if (id == null) {
      logError('findTodoFile: id is null');
      return null;
    }
    return todoFiles.files.firstWhereOrNull((todoFile) => todoFile.id == id);
  }

  void replaceUpdatedTodoFile(TodoFile todoFile) {
    final index = todoFiles.files.indexWhere(
      (existingFile) => todoFile.id == existingFile.id,
    );
    if (index != -1) {
      todoFiles.files[index] = todoFile;
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
      logError('findCategory: categories is null');
      return null;
    }
    if (id == null) {
      logError('findCategory: id is null');
      return null;
    }
    return categories.firstWhereOrNull((category) => category.id == id);
  }

  Category? findCategoryInTodoFile(TodoFile? todoFile, int? id) {
    if (todoFile == null || id == null) {
      logError('findCategoryInTodoFile: todoFile is ${todoFile?.name} and id is $id');
      return null;
    }
    return todoFile.categories.firstWhereOrNull(
      (category) => category.id == id,
    );
  }

  Category? findFileCategory(int? todoFileId, int? categoryId) {
    return findCategoryInTodoFile(findTodoFile(todoFileId), categoryId);
  }

  void replaceUpdatedCategory(TodoFile todoFile, Category category) {
    final index = todoFile.categories.indexWhere(
      (existingCategory) => category.id == existingCategory.id,
    );
    if (index != -1) {
      todoFile.categories[index] = category;
    }
  }

  Todo? findTodoFromCategory(Category category, int? id) {
    return category.todos.firstWhereOrNull((todo) => todo.id == id);
  }

  Todo? findTodoFromList(List<Todo>? todos, int? id) {
    if (todos == null || id == null) {
      logError('findTodoFromList:todos: $todos id: $id');
      return null;
    }
    return todos.firstWhereOrNull((todo) => todo.id == id);
  }

  Todo? findParentTodo(Todo todo) {
    return findDeepTodo(todo.todoFileId, todo.categoryId, todo.parentTodoId);
  }

  /* Todo? findTodoInCategory(int? todoFileId, int? categoryId, int? id) {
    final todoFile = findTodoFile(todoFileId);
    if (todoFile == null) {
      logAndShowMessage(ref, 'findTodoInCategory:Could not find todo file id: $fileId');
      return null;
    }
    final category = findCategoryInTodoFile(todoFile, categoryId);
    if (category == null) {
      logAndShowMessage(ref, 'findTodoInCategory:Could not find category id: $categoryId');
      return null;
    }
    return findTodoFromList(category.todos, id);
  }
*/
  Todo? findDeepTodo(int? todoFileId, int? categoryId, int? id) {
    final todoFile = findTodoFile(todoFileId);
    if (todoFile == null) {
      logError('findTodoInCategory:Could not find todo file id: $todoFileId');
      return null;
    }
    final category = findCategoryInTodoFile(todoFile, categoryId);
    if (category == null) {
      logError('findTodoInCategory:Could not find category id: $categoryId');
      return null;
    }
    return findTodoInChildren(category.todos, id);
  }

  int findTodoFileIndex(int todoFileId) {
    return todoFiles.files.indexWhere((todoFile) => todoFile.id == todoFileId);
  }

  int findCategoryIndex(int todoFileId, int categoryId) {
    final todoFile = findTodoFile(todoFileId);
    return todoFile?.categories.indexWhere((category) => category.id == categoryId) ?? -1;
  }

  int findTodoIndex(int? todoFileId, int? categoryId, int? id) {
    final todoFile = findTodoFile(todoFileId);
    if (todoFile == null) {
      logError('findTodoInCategory:Could not find todo file id: $todoFileId');
      return -1;
    }
    final category = findCategoryInTodoFile(todoFile, categoryId);
    if (category == null) {
      logError('findTodoInCategory:Could not find category id: $categoryId');
      return -1;
    }
    return findTodoIndexInChildren(category.todos, id);
  }

  int findTodoIndexInChildren(List<Todo> children, int? id) {
    int resultIndex = -1;
    children.forEachIndexed((index, todo) {
      if (todo.id == id) {
        resultIndex = index;
        return;
      }
      final foundIndex = findTodoIndexInChildren(todo.children, id);
      if (foundIndex != -1) {
        resultIndex = foundIndex;
        return;
      }
    });
    return resultIndex;
  }

  Todo? findTodoInParentTodo(
    int? todoFileId,
    int? categoryId,
    int? parentId,
    int? id,
  ) {
    final todoFile = findTodoFile(todoFileId);
    if (todoFile == null) {
      logMessage('findTodoInCategory:Could not find todo file id: $todoFileId');
      return null;
    }
    final category = findCategoryInTodoFile(todoFile, categoryId);
    if (category == null) {
      logMessage('findTodoInCategory:Could not find category id: $categoryId');
      return null;
    }
    if (parentId == null) {
      logMessage('findTodoInParentTodo: parentId is null');
      return null;
    }
    if (id == null) {
      logMessage('findTodoInParentTodo: id is null');
      return null;
    }
    final parentTodo = findTodoInChildren(category.todos, parentId);
    if (parentTodo == null) {
      logMessage('findTodoInCategory:Could not find parent id: $parentId');
      return null;
    }
    return findTodoInChildren(parentTodo.children, id);
  }

  Todo? findTodoInChildren(List<Todo> children, int? id) {
    if (id == null) {
      logMessage('findTodoInChildren: Id is null');
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
    return todoFiles.files.indexWhere((todoFile) => todoFile.id == id);
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

  int todoIndexInParent(List<Todo> todos, Todo todoToFind) {
    return todos.indexWhere((todo) => todo == todoToFind);
  }

  int childTodoIndexInParent(Todo parentTodo, Todo todo) {
    return todoIndexInParent(parentTodo.children, todo);
  }

  int todoIndexByName(List<Todo> todos, String name) {
    return todos.indexWhere((todo) => todo.name == name);
  }

  int selectFile(int? todoFileId) {
    if (todoFileId == null) {
      logError('selectFile:todoFileId is null');
      return -1;
    }
    final index = todoFiles.files.indexWhere((todoFile) {
      if (todoFile.id == todoFileId) {
        return true;
      }
      return false;
    });
    return index;
  }

  int selectCategory(int fileIndex, int? categoryId) {
    if (categoryId == null) {
      logError('categoryId is null');
      return -1;
    }
    final todoFile = todoFiles.files[fileIndex];
    final index = todoFile.categories.indexWhere((category) {
      if (category.id == categoryId) {
        return true;
      }
      return false;
    });
    return index;
  }

  int selectTodo(int fileIndex, int? categoryId, int? todoId) {
    if (categoryId == null || todoId == null) {
      return -1;
    }
    final todoFile = todoFiles.files[fileIndex];
    final categoryIndex = todoFile.categories.indexWhere((category) {
      if (category.id == categoryId) {
        return true;
      }
      return false;
    });
    if (categoryIndex == -1) {
      return -1;
    }
    final category = todoFile.categories[categoryIndex];
    final index = category.todos.indexWhere((todo) {
      if (todo.id == todoId) {
        return true;
      }
      return false;
    });
    return index;
  }

  int getTodoIndex(List<Todo> todos, int todoId) {
    if (todos.isEmpty) {
      return -1;
    }
    var count = -1;
    var index = -1;
    for (final todo in todos) {
      count++;
      if (todo.id == todoId) {
        index = count;
        break;
      }
      final childIndex = getTodoIndex(todo.children, todoId);
      if (childIndex != -1) {
        return index;
      }
    }
    return index;
  }

  void updateTodoFile(TodoFile todoFile) {
    final index = todoFileIndex(todoFile.id!);
    if (index != -1) {
      todoFiles.files[index] = todoFile;
    } else {
      logError('updateTodoFile: Could not find index for ${todoFile.name}');
    }
  }

  void updateCategory(Category category) {
    final todoFile = findTodoFile(category.todoFileId!);
    if (todoFile == null) {
      logError('updateCategory: todofile is null for ${category.name}');
      return;
    }
    final index = categoryIndex(todoFile.categories, category.id!);
    if (index != -1) {
      todoFile.categories[index] = category;
    }
  }

  void updateTodo(Todo todo) {
    final todoFile = findTodoFile(todo.todoFileId!);
    if (todoFile == null) {
      logError('updateTodo: todofile is null for ${todo.name}');
      return;
    }
    final category = findCategory(todoFile.categories, todo.categoryId!);
    if (category == null) {
      logError('updateTodo: category is null for ${todo.name}');
      return;
    }
    // Check for a parent id
    if (todo.id == null && todo.parentTodoId == null) {
      logError('updateTodo: id and parent id is null for ${todo.name}');
      return;
    } else if (todo.id == null && todo.parentTodoId != null) {
      final parentTodo = findTodoInChildren(category.todos, todo.parentTodoId);
      if (parentTodo != null) {
        final index = todoIndexByName(parentTodo.children, todo.name);
        if (index != -1) {
          parentTodo.children[index] = todo;
        } else {
          logError(
            'Could not find index for parent ${parentTodo.name} and todo ${todo.name}',
          );
        }
      } else {
        logError('Could not find parent todo for todo ${todo.name}');
      }
      return;
    } else if (todo.id != null && todo.parentTodoId != null) {
      final parentTodo = findParentTodo(todo);
      if (parentTodo != null) {
        replaceTodo(parentTodo.children, todo);
      } else {
        logError('Could not find parent todo for ${todo.name}');
      }
      return;
    }
    var index = todoIndex(category.todos, todo.id!);
    if (index != -1) {
      category.todos[index] = todo;
    } else {
      // No id found. Search by name
      index = todoIndexByName(category.todos, todo.name);
      if (index != -1) {
        category.todos[index] = todo;
      } else {
        logError('updateTodo: Could not find index for ${todo.name}');
      }
    }
  }

  void replaceTodo(List<Todo> todos, Todo updatedTodo) {
    var index = 0;
    for (final todo in todos) {
      if (todo.id == updatedTodo.id) {
        todos[index] = updatedTodo;
        return;
      }
      index++;
      if (todo.children.isNotEmpty) {
        replaceTodo(todo.children, updatedTodo);
      }
    }
  }

  void updateTodoInParent(Todo parentTodo, Todo todo) {
    final childIndex = childTodoIndexInParent(parentTodo, todo);
    if (childIndex != -1) {
      parentTodo.children[childIndex] = todo;
    } else {
      logError(
        'updateTodoInParent: Could not find child index in parent todo. ${todo.name}',
      );
    }
  }

  void deleteTodoFile(TodoFile todoFile) {
    final index = todoFileIndex(todoFile.id!);
    if (index != -1) {
      todoFiles.files.removeAt(index);
    }
  }

  void deleteCategory(Category category) {
    final todoFile = findTodoFile(category.todoFileId!);
    if (todoFile == null) {
      logError('deleteCategory: todofile is null for ${category.name}');
      return;
    }
    final index = categoryIndex(todoFile.categories, category.id!);
    if (index != -1) {
      todoFile.categories.removeAt(index);
    } else {
      logError(
        'Did not find category ${category.name} in file: ${todoFile.name}',
      );
    }
  }

  void deleteTodo(Todo todo) {
    final todoFile = findTodoFile(todo.todoFileId!);
    if (todoFile == null) {
      logError('deleteTodo: todofile is null for ${todo.name}');
      return;
    }
    final category = findCategory(todoFile.categories, todo.categoryId!);
    if (category == null) {
      logError('deleteTodo: category is null for ${todo.name}');
      return;
    }
    final index = todoIndex(category.todos, todo.id!);
    if (index != -1) {
      category.todos.removeAt(index);
    } else {
      if (todo.parentTodoId != null) {
        final parentTodo = findParentTodo(todo);
        if (parentTodo != null) {
          parentTodo.children.remove(todo);
        } else {
          logError('Could not find parent todo for ${todo.name}');
        }
      } else {
        logError(
          'Did not find todo ${todo.name} in category: ${category.name}',
        );
      }
    }
  }

  void addTodoToCategory(int todoFileId, int categoryId, Todo todo) {
    final category = findFileCategory(todoFileId, categoryId);
    if (category != null) {
      final todoFile = findTodoFile(todoFileId);
      if (todoFile != null) {
        final updatedCategory = category.copyWith(
          todos: [...category.todos, todo],
        );
        replaceUpdatedCategory(todoFile, updatedCategory);
      } else {
        logError(
          'Could not find todoFile for todoFileId: $todoFileId categoryId: $categoryId and Todo: ${todo.name}',
        );
      }
    } else {
      logError(
        'Could not find category for todoFileId: $todoFileId categoryId: $categoryId and Todo: ${todo.name}',
      );
    }
  }

  void addTodoToParent(Todo todo) {
    final parentTodo = findDeepTodo(
      todo.todoFileId,
      todo.categoryId,
      todo.parentTodoId,
    );
    if (parentTodo != null) {
      final updatedParentTodo = parentTodo.copyWith(
        children: [...parentTodo.children, todo],
      );
      updateTodo(updatedParentTodo);
    } else {
      logError(
        'addNewTodoToParent: Could not find parent id for todo ${todo.name}',
      );
    }
  }

  // This method assumes all ids are set and checks if there is a parent id
  void addTodo(Todo todo) {
    if (todo.todoFileId == null) {
      logError('addTodo: todoFileId is null');
      return;
    }
    if (todo.categoryId == null) {
      logError('addTodo: categoryId is null');
      return;
    }
    if (todo.parentTodoId != null) {
      addTodoToParent(todo);
    } else {
      addTodoToCategory(todo.todoFileId!, todo.categoryId!, todo);
    }
  }
}
