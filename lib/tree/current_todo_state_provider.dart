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
          logMessage('Found index of $index for todo file ${currentlySelectedTodoFile?.name}');
        }
        currentState = currentState.copyWith(currentCategory: null, currentTodo: null, currentlySelectedIndex: index);
        break;
      case NodeType.category:
        Category? currentlySelectedCategory = todoRepository.findCategory(
            node.todoInfo.todoFileId, node.todoInfo.categoryId);
        if (currentlySelectedCategory == null) {
          logMessage('Could not set selected category for category ${node.name}');
        } else {
          if (index == -1) {
            final todoFileIndex = todoRepository.findTodoFileIndex(node.todoInfo.todoFileId!);
            logMessage('Found todoFileIndex of $todoFileIndex for category ${currentlySelectedCategory.name}');
            final categoryIndex = todoRepository.findCategoryIndex(node.todoInfo.todoFileId!, node.todoInfo.categoryId!);
            logMessage('Found categoryIndex of $categoryIndex for category ${currentlySelectedCategory.name}');
            index = todoFileIndex + categoryIndex;
            logMessage('Found index of $index for category ${currentlySelectedCategory.name}');
          }
          currentState = currentState.copyWith(currentCategory: currentlySelectedCategory, currentTodo: null, currentlySelectedIndex: index);
        }
        break;
      case NodeType.root:
        currentState = currentState.copyWith(currentTodoFile: null, currentCategory: null, currentTodo: null, );
        break;
      case NodeType.todo:
        currentState = currentState.copyWith(currentTodoFile: null, currentCategory: null, currentTodo: null, currentlySelectedIndex: -1 );
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
          logMessage('Found todoFileIndex of $todoFileIndex for todo ${foundTodo?.name}');
          final categoryIndex = todoRepository.findCategoryIndex(node.todoInfo.todoFileId!, node.todoInfo.categoryId!);
          logMessage('Found categoryIndex of $categoryIndex for todo ${foundTodo?.name}');
          final todoIndex = todoRepository.findTodoIndex(node.todoInfo.todoFileId!, node.todoInfo.categoryId!, node.id!);
          logMessage('Found todoIndex of $todoIndex for todo ${foundTodo?.name}');
          index = todoFileIndex + categoryIndex + todoIndex;
          logMessage('index $index for todo ${foundTodo?.name}');
        }
        currentState = currentState.copyWith(currentTodo: foundTodo, currentCategory: todoCategory, currentTodoFile: todoFile, currentlySelectedIndex: index);
        break;
    }
    ref.read(currentlySelectedNodeProvider.notifier).setSelectedNode(node);
    state = currentState;
  }
}