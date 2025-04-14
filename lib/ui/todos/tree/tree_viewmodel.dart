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
  Node rootNode = Node(name: 'root', id: rootId, type: NodeType.root, todoInfo: TodoInfo());

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
      final categoryNode = createCategoryNode(todoFileNode, todoFile, category);
      todoFileNode.addChildNode(categoryNode);
      buildCategories(category, categoryNode);
    }
  }

  void rebuildTodoNode(Node todoNode, Todo todo) {
    final parentNode = rootNode.findParentTodoNode(rootNode, todoNode.id);
    if (parentNode != null) {
      int? parentId = todo.parentTodoId;
      if (parentId != null) {
        final parentNode = rootNode.findTodoNode(rootNode, parentId);
        if (parentNode != null) {
          var newTodoNode = createTodoNodeFromParent(parentNode, todo);
          parentNode.replaceChildNode(parentNode, newTodoNode);
          return;
        }
      }
      var newTodoNode = createCategoryTodoNode(parentNode, todo);
      parentNode.replaceChildNode(parentNode, newTodoNode);
    }
  }

  void updateTodoNode(Todo todo) {
    final todoNode = rootNode.findTodoNode(rootNode, todo.id);
    if (todoNode != null) {
      rebuildTodoNode(todoNode, todo);
    }
  }

  void rebuildCategoryNode(Node categoryNode, Category category) {
    final todoFileNode = rootNode.findTodoFileNode(rootNode, categoryNode.todoInfo.todoFileId);
    if (todoFileNode != null) {
      TodoFile? todoFile = todoRepository.findTodoFile(categoryNode.todoInfo.todoFileId);
      if (todoFile != null) {
        var newCategoryNode = createCategoryNode(todoFileNode, todoFile, category);
        todoFileNode.replaceChildNode(todoFileNode, newCategoryNode);
      }
    }
  }

  Node createCategoryNode(Node todoFileNode, TodoFile todoFile, Category category) {
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

  Node createCategoryTodoNode(Node categoryNode, Todo todo) {
    Node newTodoNode = Node(
      name: todo.name,
      id: todo.id,
      type: NodeType.todo,
      previous: categoryNode,
      todoInfo: TodoInfo(todoFileId: categoryNode.todoInfo.todoFileId, categoryId: categoryNode.id),
    );
    buildChildTodos(todo.children, newTodoNode);
    return newTodoNode;
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
      var todoNode = createCategoryTodoNode(categoryNode, todo);
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

  Future renameCurrentTodo(String newName) async {
    CurrentTodoState currentTodoState = ref.read(currentTodoStateProvider);
    if (currentTodoState.currentTodo != null) {
      Todo? updatedTodo = currentTodoState.currentTodo!.copyWith(name: newName);
      updatedTodo = await todoRepository.updateTodo(updatedTodo);
      currentTodoState = currentTodoState.copyWith(currentTodo: updatedTodo);
      ref.read(currentTodoStateProvider.notifier).setCurrentTodoState(currentTodoState);
      Node? todoNode = rootNode.findTodoNode(rootNode, updatedTodo!.id);
      if (todoNode != null) {
        rebuildTodoNode(todoNode, updatedTodo);
      }
    }
  }

  Future renameCurrentCategory(String newName) async {
    CurrentTodoState currentTodoState = ref.read(currentTodoStateProvider);
    if (currentTodoState.currentCategory != null) {
      currentTodoState = currentTodoState.copyWith(
        currentCategory: currentTodoState.currentCategory!.copyWith(name: newName),
      );
      await todoRepository.updateCategory(currentTodoState.currentCategory!);
      ref.read(currentTodoStateProvider.notifier).setCurrentTodoState(currentTodoState);
      Node? categoryNode = rootNode.findCategoryNode(
        rootNode,
        currentTodoState.currentCategory!.id,
      );
      if (categoryNode != null) {
        rebuildCategoryNode(categoryNode, currentTodoState.currentCategory!);
      }
    }
  }

  Future renameCurrentFile(String newName) async {
    CurrentTodoState currentTodoState = ref.read(currentTodoStateProvider);
    if (currentTodoState.currentTodoFile != null) {
      currentTodoState = currentTodoState.copyWith(
        currentTodoFile: currentTodoState.currentTodoFile!.copyWith(name: newName),
      );
      await todoRepository.updateTodoFile(currentTodoState.currentTodoFile!);
      ref.read(currentTodoStateProvider.notifier).setCurrentTodoState(currentTodoState);
      Node? todoFileNode = rootNode.findTodoFileNode(
        rootNode,
        currentTodoState.currentTodoFile!.id,
      );
      if (todoFileNode != null) {
        rebuildTodoFileNode(todoFileNode, currentTodoState.currentTodoFile!);
      }
    }
  }

  void rebuildFileNode(TodoFile todoFile) {
    final todoFileNode = rootNode.findTodoFileNode(rootNode, todoFile.id);
    if (todoFileNode != null) {
      var newTodoFileNode = createTodoFileNode(todoFile);
      rebuildTodoFileNode(newTodoFileNode, todoFile);
      todoFileNode.replaceChildNode(rootNode, newTodoFileNode);
    }
  }

  Node addNewNodeToParent(Node parentNode) {
    switch (parentNode.type) {
      case NodeType.root:
        Node newTodoFileNode = createTodoFileNode(TodoFile(name: ''));
        parentNode.addChildNode(newTodoFileNode);
        return newTodoFileNode;
      case NodeType.file:
        TodoFile? todoFile = todoRepository.findTodoFile(parentNode.todoInfo.todoFileId);
        Node newCategoryNode = createCategoryNode(parentNode, todoFile!, Category(name: ''));
        parentNode.addChildNode(newCategoryNode);
        return newCategoryNode;
      case NodeType.category:
        Node newTodoNode = createCategoryTodoNode(parentNode, Todo(name: ''));
        parentNode.addChildNode(newTodoNode);
        return newTodoNode;
      case NodeType.todo:
        Node newTodoNode = createTodoNodeFromParent(parentNode, Todo(name: ''));
        parentNode.addChildNode(newTodoNode);
        return newTodoNode;
    }
  }

  Node? addNewNodeAtSelectedNode() {
    Node? currentlySelectedNode = ref.read(currentlySelectedNodeProvider);
    if (currentlySelectedNode != null) {
      switch (currentlySelectedNode.type) {
        case NodeType.root:
          Node newTodoFileNode = createTodoFileNode(TodoFile(name: ''));
          currentlySelectedNode.addChildNode(newTodoFileNode);
          return newTodoFileNode;
        case NodeType.file:
          TodoFile? todoFile = todoRepository.findTodoFile(
            currentlySelectedNode.todoInfo.todoFileId,
          );
          Node newCategoryNode = createCategoryNode(
            currentlySelectedNode,
            todoFile!,
            Category(name: ''),
          );
          currentlySelectedNode.addChildNode(newCategoryNode);
          return newCategoryNode;
        case NodeType.category:
          Node newTodoNode = createCategoryTodoNode(currentlySelectedNode, Todo(name: ''));
          currentlySelectedNode.addChildNode(newTodoNode);
          return newTodoNode;
        case NodeType.todo:
          Node newTodoNode = createTodoNodeFromParent(currentlySelectedNode, Todo(name: ''));
          currentlySelectedNode.addChildNode(newTodoNode);
          return newTodoNode;
      }
    }
    return null;
  }

  Future<Node> updateItemAtSelectedNode(Node parentNode, Node newNode, String updatedName) async {
    Node currentNode = newNode;
    switch (parentNode.type) {
      case NodeType.root:
        final todoFile = await todoRepository.addNewTodoFile(TodoFile(name: updatedName));
        newNode = createTodoFileNode(todoFile);
        parentNode.replaceChildNodeWithNode(parentNode, currentNode, newNode);
      case NodeType.file:
        final newCategory = await todoRepository.addNewCategory(
          newNode.todoInfo.todoFileId!,
          Category(name: updatedName),
        );
        if (newCategory == null) {
          logError('addItemAtSelectedNode: newCategory is null');
          return newNode;
        }
        TodoFile? todoFile = todoRepository.findTodoFile(parentNode.todoInfo.todoFileId);
        if (todoFile == null) {
          logError('addItemAtSelectedNode: todoFile is null');
          return newNode;
        }
        Node newCategoryNode = createCategoryNode(parentNode, todoFile, newCategory);
        parentNode.replaceChildNodeWithNode(parentNode, currentNode, newCategoryNode);
      case NodeType.category:
        final newTodo = await todoRepository.addNewTodo(
          newNode.todoInfo.todoFileId!,
          newNode.todoInfo.categoryId!,
          Todo(name: updatedName),
        );
        if (newTodo == null) {
          logError('addItemAtSelectedNode: newTodo is null');
          return newNode;
        }
        Node newTodoNode = createCategoryTodoNode(parentNode, newTodo);
        parentNode.replaceChildNodeWithNode(parentNode, currentNode, newTodoNode);
        return newTodoNode;
      case NodeType.todo:
        Todo newTodo = Todo(name: updatedName);
        if (newNode.todoInfo.parentId == null) {
          final addedTodo = await todoRepository.addNewTodoToCategory(
            newNode.todoInfo.todoFileId!,
            newNode.todoInfo.categoryId!,
            newTodo,
          );
          if (addedTodo == null) {
            logError('addItemAtSelectedNode: addedTodo is null');
            return newNode;
          }
          newTodo = addedTodo;
        } else {
          final addedTodo = await todoRepository.addNewTodoToParent(
            newNode.todoInfo.todoFileId!,
            newNode.todoInfo.categoryId!,
            newNode.todoInfo.parentId!,
            newTodo,
          );
          if (addedTodo == null) {
            logError('addItemAtSelectedNode: addedTodo is null');
            return newNode;
          }
          newTodo = addedTodo;
        }
        Node newTodoNode = createTodoNodeFromParent(parentNode, newTodo);
        parentNode.replaceChildNodeWithNode(parentNode, currentNode, newTodoNode);
        return newTodoNode;
    }
    return newNode;
  }

  Future duplicateCurrentTodo(String newName) async {
    Node? currentlySelectedNode = ref.read(currentlySelectedNodeProvider);
    CurrentTodoState currentTodoState = ref.read(currentTodoStateProvider);
    if (currentlySelectedNode != null && currentTodoState.currentTodo != null) {
      // TODO What about children?
      Todo? newTodo = await todoRepository.duplicateTodo(
        currentlySelectedNode.todoInfo.todoFileId,
        currentlySelectedNode.todoInfo.categoryId,
        currentlySelectedNode.todoInfo.categoryId,
        currentTodoState.currentTodo!.id,
        newName,
      );
      if (newTodo != null) {
        currentTodoState = currentTodoState.copyWith(currentTodo: newTodo);
        final categoryNode = rootNode.findCategoryNode(
          rootNode,
          currentlySelectedNode.todoInfo.categoryId,
        );
        if (categoryNode != null) {
            final todoNode = createTodoNodeFromParent(categoryNode, newTodo);
            categoryNode.addChildNode(todoNode);
        }
        ref.read(currentTodoStateProvider.notifier).setCurrentTodoState(currentTodoState);
      }
    }
  }

  Future duplicateCurrentCategory(String newName) async {
    Node? currentlySelectedNode = ref.read(currentlySelectedNodeProvider);
    CurrentTodoState currentTodoState = ref.read(currentTodoStateProvider);
    if (currentlySelectedNode != null && currentTodoState.currentCategory != null) {
      Category? newCategory = await todoRepository.duplicateCategory(
        currentlySelectedNode.todoInfo.todoFileId,
        currentlySelectedNode.todoInfo.categoryId,
        newName,
      );
      if (newCategory != null) {
        currentTodoState = currentTodoState.copyWith(currentCategory: newCategory);
        final todoFileNode = rootNode.findTodoFileNode(
          rootNode,
          currentlySelectedNode.todoInfo.todoFileId,
        );
        if (todoFileNode != null) {
          TodoFile? todoFile = todoRepository.findTodoFile(
            currentlySelectedNode.todoInfo.todoFileId,
          );
          if (todoFile != null) {
            final categoryNode = createCategoryNode(todoFileNode, todoFile, newCategory);
            todoFileNode.addChildNode(categoryNode);
            buildCategories(newCategory, categoryNode);
          }
        }
        ref.read(currentTodoStateProvider.notifier).setCurrentTodoState(currentTodoState);
      }
    }
  }

  Future duplicateCurrentTodoFile(String newName) async {
    Node? currentlySelectedNode = ref.read(currentlySelectedNodeProvider);
    CurrentTodoState currentTodoState = ref.read(currentTodoStateProvider);
    if (currentlySelectedNode != null && currentTodoState.currentTodoFile != null) {
      // TODO What about children?
      TodoFile? newTodoFile = await todoRepository.duplicateTodoFile(
        currentlySelectedNode.todoInfo.todoFileId,
        newName,
      );
      if (newTodoFile != null) {
        currentTodoState = currentTodoState.copyWith(currentTodoFile: newTodoFile);
        final todoFileNode = createTodoFileNode(newTodoFile);
        rootNode.addChildNode(todoFileNode);
        ref.read(currentTodoStateProvider.notifier).setCurrentTodoState(currentTodoState);
      }
    }
  }
}
