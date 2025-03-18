import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memory_notes_organizer/constants.dart';
import 'package:memory_notes_organizer/models/categories.dart';
import 'package:memory_notes_organizer/models/current_todo_state.dart';
import 'package:memory_notes_organizer/models/node.dart';
import 'package:memory_notes_organizer/models/selection_state.dart';
import 'package:memory_notes_organizer/models/todos.dart';
import 'package:memory_notes_organizer/providers.dart';
import 'package:memory_notes_organizer/router/app_routes.dart';
import 'package:memory_notes_organizer/ui/dialogs/new_item.dart';
import 'package:memory_notes_organizer/ui/dialogs/rename_dialog.dart';
import 'package:memory_notes_organizer/ui/todos/tree/tree_viewmodel.dart';
import 'package:utilities/utilities.dart';

typedef OnSearchFound = void Function(int index, Node node);

class TodoActions {
  final WidgetRef ref;
  bool searching = false;

  TodoActions(this.ref);

  void deleteTodo(Node rootNode, TreeController<Node> treeController) {
    final context = ref.read(appRouterProvider).navigatorKey.currentContext;
    showAreYouSureDialog(context!, () async {
      CurrentTodoState currentTodoState = ref.read(currentTodoStateProvider);
      if (currentTodoState.currentTodo != null) {
        final categoryNode = rootNode.findCategoryNode(
          rootNode,
          currentTodoState.currentCategory!.id!,
        );
        if (categoryNode != null) {
          final todoNode = rootNode.findTodoNode(rootNode, currentTodoState.currentTodo!.id!);
          if (todoNode != null) {
            categoryNode.removeNode(rootNode, todoNode.id!);
            treeController.rebuild();
          }
        }
        var todoRepository = ref.read(todoRepositoryProvider);
        await todoRepository.deleteTodosAndChildren(currentTodoState.currentTodo!, true);
      }
    }, null);
  }

  void newTodo(Node rootNode, TreeViewModel treeViewModel, TreeController<Node> treeController) {
    showNewDialog(ref, newTodoString, (value) async {
      if (value != null) {
        CurrentTodoState currentTodoState = ref.read(currentTodoStateProvider);
        if (currentTodoState.currentTodoFile != null && currentTodoState.currentCategory != null) {
          var todoRepository = ref.read(todoRepositoryProvider);
          int? parentId;
          if (currentTodoState.currentTodo != null) {
            parentId = currentTodoState.currentTodo!.id!;
          }
          final updatedTodo = await todoRepository.addNewTodoToCategory(
            currentTodoState.currentTodoFile!.id!,
            currentTodoState.currentCategory!.id!,
            Todo(name: value, parentTodoId: parentId),
          );
          if (updatedTodo != null) {
            final categoryNode = rootNode.findCategoryNode(
              rootNode,
              currentTodoState.currentCategory!.id!,
            );
            if (parentId != null) {
              final parentNode = rootNode.findTodoNode(rootNode, parentId);
              parentNode?.addChildNode(treeViewModel.createTodoNode(parentNode, updatedTodo));
              treeController.rebuild();
            } else if (categoryNode != null) {
              categoryNode.addChildNode(treeViewModel.createTodoNode(categoryNode, updatedTodo));
              treeController.rebuild();
            }
          }
        }
      }
    });
  }

  void search(
    SelectionState newSelectionState,
    Node rootNode,
    TreeController<Node> treeController,
    OnSearchFound onSearchCallback,
  ) {
    if (searching) {
      return;
    }
    searching = true;
    if (newSelectionState.todoId != null) {
      final node = rootNode.findTodoNode(rootNode, newSelectionState.todoId);
      if (node != null) {
        treeController.collapseAll();
        treeController.expandAncestors(node);
        final index = node.findNodeIndex(rootNode, newSelectionState.todoId);
        if (index != -1) {
          onSearchCallback.call(index, node);
        }
      }
    } else if (newSelectionState.categoryId != null) {
      final node = rootNode.findCategoryNode(rootNode, newSelectionState.categoryId);
      if (node != null) {
        treeController.collapseAll();
        treeController.expandAncestors(node);
        final index = node.findNodeIndex(rootNode, newSelectionState.categoryId);
        if (index != -1) {
          onSearchCallback.call(index, node);
        }
      }
    } else if (newSelectionState.todoFileId != null) {
      final node = rootNode.findTodoFileNode(rootNode, newSelectionState.todoFileId);
      if (node != null) {
        treeController.collapseAll();
        treeController.expandAncestors(node);
        final index = node.findNodeIndex(rootNode, newSelectionState.todoFileId);
        if (index != -1) {
          onSearchCallback.call(index, node);
        }
      }
    }
    searching = false;
  }

  void renameTodo(Node rootNode, TreeViewModel treeViewModel, TreeController<Node> treeController) {
    showRenameDialog(ref, 'Rename Note', (String? newName) {
      if (newName != null) {
        treeViewModel.renameCurrentTodo(newName);
        treeController.rebuild();
      }
    });
  }

  void renameCategory(Node rootNode, TreeViewModel viewModel, TreeController<Node> treeController) {
    showRenameDialog(ref, 'Rename Category', (String? newName) {
      if (newName != null) {
        viewModel.renameCurrentCategory(newName);
        treeController.rebuild();
      }
    });
  }

  void deleteCategory(Node rootNode, TreeViewModel viewModel, TreeController<Node> treeController) {
    final context = ref.read(appRouterProvider).navigatorKey.currentContext;
    showAreYouSureDialog(context!, () async {
      CurrentTodoState currentTodoState = ref.read(currentTodoStateProvider);
      if (currentTodoState.currentCategory != null) {
        final todoFileNode = rootNode.findTodoFileNode(
          rootNode,
          currentTodoState.currentTodoFile!.id!,
        );
        if (todoFileNode != null) {
          todoFileNode.removeNode(rootNode, currentTodoState.currentCategory!.id!);
          treeController.rebuild();
        }
        var todoRepository = ref.read(todoRepositoryProvider);
        await todoRepository.deleteCategory(currentTodoState.currentCategory!, true);
      }
    }, null);
  }

  void duplicateCategory(
    Node rootNode,
    TreeViewModel viewModel,
    TreeController<Node> treeController,
  ) {}

  void renameFile(Node rootNode, TreeViewModel viewModel, TreeController<Node> treeController) {}

  void deleteFile(Node rootNode, TreeViewModel viewModel, TreeController<Node> treeController) {}

  void duplicateFile(Node rootNode, TreeViewModel viewModel, TreeController<Node> treeController) {}

  void closeFile(Node rootNode, TreeViewModel viewModel, TreeController<Node> treeController) {}

  void reloadFile(Node rootNode, TreeViewModel viewModel, TreeController<Node> treeController) {
    var todoRepository = ref.read(todoRepositoryProvider);
    CurrentTodoState currentTodoState = ref.read(currentTodoStateProvider);
    if (currentTodoState.currentTodoFile != null) {
      todoRepository.reloadTodoFile(currentTodoState.currentTodoFile!.id!);
      viewModel.rebuildFileNode(currentTodoState.currentTodoFile!);
    }
  }

  void reload() {
    var todoRepository = ref.read(todoRepositoryProvider);
    todoRepository.reload();
    ref.read(currentTodoStateProvider.notifier).reset();
    ref.read(currentFilesProvider.notifier).reset();
  }

  void newCategory(Node rootNode, TreeViewModel viewModel, TreeController<Node> treeController) {
    showNewDialog(ref, newCategoryString, (value) async {
      if (value != null) {
        CurrentTodoState currentTodoState = ref.read(currentTodoStateProvider);
        if (currentTodoState.currentTodoFile != null) {
          var todoRepository = ref.read(todoRepositoryProvider);
          final newCategory = await todoRepository.addNewCategory(
            currentTodoState.currentTodoFile!.id!,
            Category(name: value),
          );
          if (newCategory != null) {
            final todoFileNode = rootNode.findTodoFileNode(
              rootNode,
              currentTodoState.currentTodoFile!.id!,
            );
            if (todoFileNode != null) {
              var findTodoFile = todoRepository.findTodoFile(currentTodoState.currentTodoFile!.id!);
              if (findTodoFile != null) {
                todoFileNode.addChildNode(
                  viewModel.createCategoryNode(todoFileNode, findTodoFile, newCategory),
                );
              }
              treeController.rebuild();
            }
          }
        }
      }
    });
  }

  void newFile(Node rootNode, TreeViewModel viewModel, TreeController<Node> treeController) {}

  void showLogs() {}

  void logout() {
    var todoRepository = ref.read(todoRepositoryProvider);
    getSupaAuthManager(ref).logout();
    todoRepository.clear();
    ref.read(appRouterProvider).popAndPush(LoginRoute(onResult: (result) => {}));
  }

  void loadFile(Node rootNode, TreeViewModel viewModel, TreeController<Node> treeController) {}

  void openFile(Node rootNode, TreeViewModel viewModel, TreeController<Node> treeController) {}

  void closeAllFiles(Node rootNode, TreeViewModel viewModel, TreeController<Node> treeController) {}
}
