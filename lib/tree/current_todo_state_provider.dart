import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:memory_notes_organizer/models/current_todo_state.dart';
import 'package:memory_notes_organizer/models/node.dart';
import 'package:memory_notes_organizer/models/models.dart';
import 'package:memory_notes_organizer/providers.dart';

class CurrentTodoStateProvider extends StateNotifier<CurrentTodoState> {
  final Ref ref;
  CurrentTodoStateProvider(this.ref, super.state);

  void setCurrentTodoState(CurrentTodoState currentState) {
    state = currentState;
  }

  CurrentTodoState getCurrentTodoState() => state;

  void setCurrentStateFromNode(Node todoNode) {
    var todoRepository = ref.read(todoRepositoryProvider);
    switch (todoNode.type) {
      case NodeType.root:
      case NodeType.file:
      TodoFile? todoFile = todoRepository.findTodoFile(todoNode.todoInfo.todoFileId);
      if (todoFile != null) {
        state = state.copyWith(currentTodoFile: todoFile, currentCategory: null, currentTodo: null);
      }
      case NodeType.category:
        Category? category = todoRepository.findCategory(todoNode.todoInfo.todoFileId, todoNode.todoInfo.categoryId);
        if (category != null) {
          state = state.copyWith(currentCategory: category, currentTodo: null);
        }
      case NodeType.todo:
        Todo? todo = todoRepository.findTodo(todoNode.todoInfo.todoFileId, todoNode.todoInfo.categoryId, todoNode.id);
        if (todo != null) {
          state = state.copyWith(currentTodo: todo);
        }
    }
  }

  void setCurrentCategory(Category category) {
    state = state.copyWith(currentCategory: category);
  }

  void setCurrentTodoFile(TodoFile todFile) {
    state = state.copyWith(currentTodoFile: todFile);
  }

  Node? goUp() {
    CurrentTodoState currentState = state;
    currentState = currentState.copyWith(currentlySelectedIndex: -1);
    Node? currentlySelectedNode = ref.read(currentlySelectedNodeProvider);
    if (currentlySelectedNode?.previous != null) {
      currentlySelectedNode = currentlySelectedNode?.previous;
    } else {
      currentlySelectedNode = null;
    }
    selectNode(currentlySelectedNode, -1);
    return currentlySelectedNode;
  }

  void goTop() {
    clearSelection();
    state = CurrentTodoState();
  }

  void reset() {
    clearSelection();
    state = CurrentTodoState();
  }

  void clearSelection() {
    CurrentTodoState currentState = state;
    currentState = currentState.copyWith(currentlySelectedIndex: -1);
    Node? currentlySelectedNode = ref.read(currentlySelectedNodeProvider);
    switch (currentlySelectedNode?.type) {
      case NodeType.file:
        currentState = currentState.copyWith(currentCategory: null);
        break;
      case NodeType.category:
        currentState = currentState.copyWith(currentCategory: null);
        break;
      case NodeType.root:
        currentState = currentState.copyWith(currentTodoFile: null, currentCategory: null, currentTodo: null, );
        break;
      case NodeType.todo:
        currentState = currentState.copyWith(currentTodo: null,);
        break;
      case null:
        currentState = CurrentTodoState();
    }
    state = currentState;
    ref.read(currentlySelectedNodeProvider.notifier).setSelectedNode(null);
  }

  void selectNode(Node? node, int index) {
    if (node == null) {
      clearSelection();
      return;
    }
    CurrentTodoState currentState = state;
    currentState = currentState.copyWith(currentlySelectedIndex: -1);
    var todoRepository = ref.read(todoRepositoryProvider);
    switch (node.type) {
      case NodeType.file:
        TodoFile? currentlySelectedTodoFile = todoRepository.findTodoFile(node.id);
        if (currentlySelectedTodoFile != null) {
          currentState = currentState.copyWith(currentTodoFile: currentlySelectedTodoFile);
        }
        if (index == -1) {
          index = todoRepository.findTodoFileIndex(node.id!);
        }
        currentState = currentState.copyWith(currentCategory: null, currentTodo: null, currentlySelectedIndex: index);
        break;
      case NodeType.category:
        TodoFile? currentlySelectedTodoFile = todoRepository.findTodoFile(node.todoInfo.todoFileId);
        if (currentlySelectedTodoFile != null) {
          currentState = currentState.copyWith(currentTodoFile: currentlySelectedTodoFile);
        }
        Category? currentlySelectedCategory = todoRepository.findCategory(
            node.todoInfo.todoFileId, node.todoInfo.categoryId);
        if (currentlySelectedCategory == null) {
          logMessage('Could not set selected category for category ${node.name}');
        } else {
          if (index == -1) {
            final todoFileIndex = todoRepository.findTodoFileIndex(node.todoInfo.todoFileId!);
            final categoryIndex = todoRepository.findCategoryIndex(node.todoInfo.todoFileId!, node.todoInfo.categoryId!);
            index = todoFileIndex + categoryIndex;
          }
          currentState = currentState.copyWith(currentCategory: currentlySelectedCategory, currentTodo: null, currentlySelectedIndex: index);
        }
        break;
      case NodeType.root:
        currentState = currentState.copyWith(currentTodoFile: null, currentCategory: null, currentTodo: null, );
        break;
      case NodeType.todo:
        TodoFile? currentlySelectedTodoFile = todoRepository.findTodoFile(node.todoInfo.todoFileId);
        Category? currentlySelectedCategory = todoRepository.findCategory(
            node.todoInfo.todoFileId, node.todoInfo.categoryId);
        currentState = currentState.copyWith(currentTodoFile: currentlySelectedTodoFile, currentCategory: currentlySelectedCategory, currentTodo: null, currentlySelectedIndex: -1 );
        var foundTodo = todoRepository.findTodoFromCategory(
            node.todoInfo.todoFileId, node.todoInfo.categoryId, node.id);
        foundTodo ??= todoRepository.findTodoInParentTodo(
            node.todoInfo.todoFileId,
            node.todoInfo.categoryId,
            node.todoInfo.parentId,
            node.id);
        final todoFile = todoRepository.findTodoFile(node.todoInfo.todoFileId);
        final todoCategory = todoRepository.findCategory(node.todoInfo.todoFileId, node.todoInfo.categoryId);
        if (index == -1) {
          final todoFileIndex = todoRepository.findTodoFileIndex(node.todoInfo.todoFileId!);
          final categoryIndex = todoRepository.findCategoryIndex(node.todoInfo.todoFileId!, node.todoInfo.categoryId!);
          final todoIndex =  node.id != null ? todoRepository.findTodoIndex(node.todoInfo.todoFileId!, node.todoInfo.categoryId!, node.id!) : 0;
          index = todoFileIndex + categoryIndex + todoIndex;
        }
        currentState = currentState.copyWith(currentTodo: foundTodo, currentCategory: todoCategory, currentTodoFile: todoFile, currentlySelectedIndex: index);
        break;
    }
    ref.read(currentlySelectedNodeProvider.notifier).setSelectedNode(node);
    state = currentState;
  }
}