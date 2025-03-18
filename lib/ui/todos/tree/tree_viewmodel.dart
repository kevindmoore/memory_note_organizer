import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:memory_notes_organizer/models/categories.dart';
import 'package:memory_notes_organizer/models/current_todo_state.dart';
import 'package:memory_notes_organizer/models/node.dart';
import 'package:memory_notes_organizer/models/todos.dart';
import 'package:memory_notes_organizer/providers.dart';
import 'package:memory_notes_organizer/repository/todo_repository.dart';

const int rootId = -1;

class TreeViewModel {
  final Ref ref;
  late TodoRepository todoRepository;
  Node rootNode = Node(
    name: 'root',
    id: rootId,
    type: NodeType.root,
    todoInfo: TodoInfo(),
  );

  TreeViewModel(this.ref) {
    todoRepository = ref.read(todoRepositoryProvider);
  }

  Future buildTree(List<TodoFile> todoFiles) async {
    rootNode.clearChildren();
    for (final todoFile in todoFiles) {
      var todoFileNode = createTodoFileNode(todoFile);
      rootNode.addChildNode(todoFileNode);
      rebuildTodoFileNode(todoFileNode, todoFile);
    }
  }

  void rebuildTodoFileNode(Node todoFileNode, TodoFile todoFile) {
    for (final category in todoFile.categories) {
      final categoryNode = createCategoryNode(
        todoFileNode,
        todoFile,
        category,
      );
      todoFileNode.addChildNode(categoryNode);
      buildCategories(category, categoryNode);
    }
  }

  void rebuildTodoNode(Node todoNode, Todo todo) {
    final categoryNode = rootNode.findParentTodoNode(
      rootNode,
      todoNode.id,
    );
    if (categoryNode != null) {
      int? parentId = todo.parentTodoId;
      if (parentId != null) {
        final parentNode = rootNode.findTodoNode(rootNode, parentId);
        if (parentNode != null) {
          var newTodoNode = createTodoNode(parentNode, todo);
          parentNode.replaceChildNode(parentNode, newTodoNode);
          return;
        }
      }
      var newTodoNode = createTodoNode(categoryNode, todo);
      categoryNode.replaceChildNode(categoryNode, newTodoNode);
    }
  }

  void updateTodoNode(Todo todo) {
    final todoNode = rootNode.findTodoNode(rootNode, todo.id);
    if (todoNode != null) {
      rebuildTodoNode(todoNode, todo);
    }
  }

  void rebuildCategoryNode(Node categoryNode, Category category) {
    final todoFileNode = rootNode.findTodoFileNode(
      rootNode,
      categoryNode.todoInfo.todoFileId,
    );
    if (todoFileNode != null) {
      TodoFile? todoFile = todoRepository.findTodoFile(categoryNode.todoInfo.todoFileId);
      if (todoFile != null) {
        var newCategoryNode = createCategoryNode(
            todoFileNode, todoFile, category);
        todoFileNode.replaceChildNode(todoFileNode, newCategoryNode);
      }
    }
  }

  Node createCategoryNode(
    Node todoFileNode,
    TodoFile todoFile,
    Category category,
  ) {
    if (todoFile.id == null || category.id == null) {
      logError(
        'createCategoryNode: todoFile id is ${todoFile.id} and category.id is ${category.id}',
      );
    }
    return Node(
      name: category.name,
      id: category.id,
      type: NodeType.category,
      previous: todoFileNode,
      todoInfo: TodoInfo(todoFileId: todoFile.id, categoryId: category.id),
    );
  }

  Node createTodoFileNode(TodoFile todoFile) {
    if (todoFile.id == null) {
      logError('createTodoFileNode: todoFile id is null');
    }
    return Node(
      name: todoFile.name,
      id: todoFile.id,
      type: NodeType.file,
      todoInfo: TodoInfo(todoFileId: todoFile.id),
    );
  }

  Node createTodoNode(Node categoryNode, Todo todo) {
    return Node(
      name: todo.name,
      id: todo.id,
      type: NodeType.todo,
      previous: categoryNode,
      todoInfo: TodoInfo(
        todoFileId: categoryNode.todoInfo.todoFileId,
        categoryId: categoryNode.id,
      ),
    );
  }

  Node createTodoNodeFromParent(Node parentTodoNode, Todo todo) {
    return Node(
      name: todo.name,
      id: todo.id,
      type: NodeType.todo,
      previous: parentTodoNode,
      todoInfo: TodoInfo(
        todoFileId: parentTodoNode.todoInfo.todoFileId,
        categoryId: parentTodoNode.todoInfo.categoryId,
        parentId: parentTodoNode.id,
      ),
    );
  }

  void buildCategories(Category category, Node categoryNode) {
    for (final todo in category.todos) {
      var todoNode = createTodoNode(categoryNode, todo);
      categoryNode.addChildNode(todoNode);
      buildChildTodos(todo.children, todoNode);
    }
  }

  void buildChildTodos(List<Todo> todos, Node parentNode) {
    for (final todo in todos) {
      var childTodoNode = Node(
        name: todo.name,
        id: todo.id,
        previous: parentNode,
        type: NodeType.todo,
        todoInfo: TodoInfo(
          todoFileId: parentNode.todoInfo.todoFileId,
          categoryId: parentNode.todoInfo.categoryId,
          parentId: parentNode.id,
        ),
      );
      parentNode.addChildNode(childTodoNode);
      buildChildTodos(todo.children, parentNode);
    }
  }

  void renameCurrentTodo(String newName) {
    CurrentTodoState currentTodoState = ref.read(currentTodoStateProvider);
    if (currentTodoState.currentTodo != null) {
      currentTodoState = currentTodoState.copyWith(
        currentTodo: currentTodoState.currentTodo!.copyWith(name: newName),
      );
      todoRepository.updateTodo(currentTodoState.currentTodo!);
      ref
          .read(currentTodoStateProvider.notifier)
          .setCurrentTodoState(currentTodoState);
      Node? todoNode = rootNode.findTodoNode(
        rootNode,
        currentTodoState.currentTodo!.id,
      );
      if (todoNode != null) {
        rebuildTodoNode(todoNode, currentTodoState.currentTodo!);
      }
    }
  }

  void renameCurrentCategory(String newName) {
    CurrentTodoState currentTodoState = ref.read(currentTodoStateProvider);
    if (currentTodoState.currentCategory != null) {
      currentTodoState = currentTodoState.copyWith(
        currentCategory: currentTodoState.currentCategory!.copyWith(name: newName),
      );
      todoRepository.updateCategory(currentTodoState.currentCategory!);
      ref
          .read(currentTodoStateProvider.notifier)
          .setCurrentTodoState(currentTodoState);
      Node? categoryNode = rootNode.findCategoryNode(
        rootNode,
        currentTodoState.currentCategory!.id,
      );
      if (categoryNode != null) {
        rebuildCategoryNode(categoryNode, currentTodoState.currentCategory!);
      }
    }

  }

  void rebuildFileNode(TodoFile todoFile) {
    final todoFileNode = rootNode.findTodoFileNode(
      rootNode,
      todoFile.id,
    );
    if (todoFileNode != null) {
      var newTodoFileNode = createTodoFileNode(todoFile);
      rebuildTodoFileNode(newTodoFileNode, todoFile);
      todoFileNode.replaceChildNode(rootNode, newTodoFileNode);
    }
  }
}
