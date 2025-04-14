import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:memory_notes_organizer/repository/todo_repository.dart';
import 'package:supa_manager/supa_manager.dart';

import '../models/models.dart';
import '../todos/todo_manager.dart';
import 'model_table_entries.dart';
import 'todo_table_handler.dart';

class CategoryTableHandler {
  final Ref? ref;
  final SupaDatabaseManager databaseRepository;
  // final LocalRepo localRepo;
  final TodoManager? todoManager;
  final TodoTableHandler todoTableHandler;
  final CategoryTableData categoryTableData = CategoryTableData();

  CategoryTableHandler(this.ref, this.databaseRepository,
      // this.localRepo,
      this.todoManager, this.todoTableHandler);

  Future<List<Category>?> loadCategoriesForFileId(int todoFileId) async {
    final result = await databaseRepository.readEntriesWhere(
        categoryTableData, todoFileIdName, todoFileId);
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

  Future<List<Category>> getCategoriesAndTodosWithFileId(int todoFileId) async {
    final result = await databaseRepository.readEntriesWhere(
        categoryTableData, todoFileIdName, todoFileId);
    switch (result) {
      case Success(data: final data):
        final categories = <Category>[];
        await Future.forEach(data, (Category category) async {
          final todos = await todoTableHandler.getTodosWithFileAndCategory(
              todoFileId, category.id!);
          var reorderedTodos = reorderTodos(todos);
          sortTodos(reorderedTodos);
          category = category.copyWith(
              todos: reorderedTodos);
          // category = category.copyWith(
          //     todos: reorderTodos(todos), lastUpdated: DateTime.now());
          categories.add(category);
        });
        return categories;
      case Failure(error: final error):
        logError( error.toString());
      case ErrorMessage(message: final message, code: _):
        logError( message!);
    }
    return <Category>[];
  }

  Future deleteCategory(Category category, bool removeFromList) async {
    if (removeFromList) {
      todoManager?.deleteCategory(category);
    }
    await Future.forEach(category.todos, (Todo todo) async {
      await todoTableHandler.deleteTodo(todo, false);
    });
    final result = await databaseRepository.deleteTableEntry(
        categoryTableData, CategoryTableEntry(category, category.id!));
    // localRepo.deleteLocalCategory(category);
    return result;
  }

  Future updateCategory(Category updatedCategory) async {
    updatedCategory = updatedCategory.copyWith(lastUpdated: DateTime.now());
    todoManager?.updateCategory(updatedCategory);
    final result = await databaseRepository.updateTableEntry(
        categoryTableData,
        CategoryTableEntry(
          updatedCategory,
          updatedCategory.todoFileId!,
        ));
    // localRepo.updateLocalCategory(updatedCategory);
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

  Future<Category?> addNewCategory(int todoFileId, Category category) async {
    category =
        category.copyWith(todoFileId: todoFileId, lastUpdated: DateTime.now());
    final result = await databaseRepository.addEntry(
        categoryTableData, CategoryTableEntry(category, category.todoFileId!));
    switch (result) {
      case Success(data: final data):
        if (category.todoFileId == null) {
          logError(
              'addCategory: Category ${category.name} todo file id is null');
        } else {
          todoManager?.addCategory(category.todoFileId!, category);
          // localRepo.addLocalCategory(category);
        }
        return data;
      case Failure(error: final error):
        logError( error.toString());
      case ErrorMessage(message: final message, code: _):
        logError( message!);
    }
    return null;
  }

  List<Todo> reorderTodos(List<Todo> todos) {
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
        childTodo = childTodo.copyWith(
            children: childrenOfChildrenTodos);
        // childTodo = childTodo.copyWith(
        //     children: childrenOfChildrenTodos, lastUpdated: DateTime.now());
        _findChildTodos(allCategoryTodos, childTodo, childrenOfChildrenTodos);
      }
      parentChildTodos.add(childTodo);
    }
    parentTodo = parentTodo.copyWith(
        children: parentChildTodos);
    // parentTodo = parentTodo.copyWith(
    //     children: parentChildTodos, lastUpdated: DateTime.now());
    return parentTodo;
  }

}
