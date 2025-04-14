import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:memory_notes_organizer/constants.dart';
import 'package:memory_notes_organizer/models/categories.dart';
import 'package:memory_notes_organizer/models/current_todo_state.dart';
import 'package:memory_notes_organizer/models/node.dart';
import 'package:memory_notes_organizer/models/selection_state.dart';
import 'package:memory_notes_organizer/models/todos.dart';
import 'package:memory_notes_organizer/providers.dart';
import 'package:memory_notes_organizer/router/app_routes.dart';
import 'package:memory_notes_organizer/ui/dialogs/new_item.dart';
import 'package:memory_notes_organizer/ui/dialogs/open_dialog.dart';
import 'package:memory_notes_organizer/ui/dialogs/rename_dialog.dart';
import 'package:memory_notes_organizer/ui/todos/tree/tree_viewmodel.dart';
import 'package:utilities/utilities.dart';

import '../dialogs/duplicate_dialog.dart';

typedef OnSearchFound = void Function(int index, Node node);

class TodoActions {
  final Ref ref;
  bool searching = false;

  TodoActions(this.ref);

  void deleteTodo({
    required Node rootNode,
    Node? currentMenuNode,
    required TreeController<Node> treeController,
  }) {
    if (currentMenuNode != null) {
      ref.read(currentlySelectedNodeProvider.notifier).setSelectedNode(currentMenuNode);
      ref.read(currentTodoStateProvider.notifier).setCurrentStateFromNode(currentMenuNode);
    }
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

  void duplicateTodo({
    required Node rootNode,
    Node? currentMenuNode,
    required TreeViewModel viewModel,
    required TreeController<Node> treeController,
  }) {
    if (currentMenuNode != null) {
      ref.read(currentlySelectedNodeProvider.notifier).setSelectedNode(currentMenuNode);
      ref.read(currentTodoStateProvider.notifier).setCurrentStateFromNode(currentMenuNode);
    }
    showDuplicateDialog(ref, 'Duplicate Todo', (String? newName) async {
      if (newName != null) {
        await viewModel.duplicateCurrentTodo(newName);
        treeController.rebuild();
      }
    });
  }

  void newTodo({
    required Node rootNode,
    Node? currentMenuNode,
    required TreeViewModel treeViewModel,
    required TreeController<Node> treeController,
    required ScrollController scrollController,
  }) {
    if (currentMenuNode != null) {
      ref.read(currentlySelectedNodeProvider.notifier).setSelectedNode(currentMenuNode);
      ref.read(currentTodoStateProvider.notifier).setCurrentStateFromNode(currentMenuNode);
    }
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
            Todo(name: value, parentTodoId: parentId, lastUpdated: DateTime.now()),
          );
          if (updatedTodo != null) {
            final categoryNode = rootNode.findCategoryNode(
              rootNode,
              currentTodoState.currentCategory!.id!,
            );
            // Need to update the last updated date on the category and todo file
            final category = todoRepository.findCategory(
              currentTodoState.currentTodoFile!.id!,
              currentTodoState.currentCategory!.id!,
            );
            if (category != null) {
              await todoRepository.updateCategory(category.copyWith(lastUpdated: DateTime.now()));
            }
            final todoFile = todoRepository.findTodoFile(currentTodoState.currentTodoFile!.id!);
            if (todoFile != null) {
              await todoRepository.updateTodoFile(todoFile.copyWith(lastUpdated: DateTime.now()));
            }
            if (parentId != null) {
              final parentNode = rootNode.findTodoNode(rootNode, parentId);
              if (parentNode != null) {
                var todoNode = treeViewModel.createCategoryTodoNode(parentNode, updatedTodo);
                parentNode.addChildNode(todoNode);
                treeController.rebuild();
                treeController.expand(parentNode);
                ref.read(currentTodoStateProvider.notifier).selectNode(todoNode, -1);
                final index = todoNode.findNodeIndex(rootNode, todoNode.id);
                if (index != -1) {
                  scrollToIndex(index, scrollController);
                }
              }
            } else if (categoryNode != null) {
              var todoNode = treeViewModel.createCategoryTodoNode(categoryNode, updatedTodo);
              categoryNode.addChildNode(todoNode);
              treeController.expand(categoryNode);
              treeController.rebuild();
              ref.read(currentTodoStateProvider.notifier).selectNode(todoNode, -1);
              final index = todoNode.findNodeIndex(rootNode, todoNode.id);
              if (index != -1) {
                scrollToIndex(index, scrollController);
              }
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

  void renameTodo(
    Node rootNode,
    Node? currentMenuNode,
    TreeViewModel treeViewModel,
    TreeController<Node> treeController,
  ) {
    if (currentMenuNode != null) {
      ref.read(currentlySelectedNodeProvider.notifier).setSelectedNode(currentMenuNode);
      ref.read(currentTodoStateProvider.notifier).setCurrentStateFromNode(currentMenuNode);
    }
    showRenameDialog(ref, 'Rename Note', (String? newName) async {
      if (newName != null) {
        await treeViewModel.renameCurrentTodo(newName);
        treeController.rebuild();
      }
    });
  }

  void renameCategory(
    Node rootNode,
    Node? currentMenuNode,
    TreeViewModel viewModel,
    TreeController<Node> treeController,
  ) {
    if (currentMenuNode != null) {
      ref.read(currentlySelectedNodeProvider.notifier).setSelectedNode(currentMenuNode);
      ref.read(currentTodoStateProvider.notifier).setCurrentStateFromNode(currentMenuNode);
    }
    showRenameDialog(ref, 'Rename Category', (String? newName) async {
      if (newName != null) {
        await viewModel.renameCurrentCategory(newName);
        treeController.rebuild();
      }
    });
  }

  void deleteCategory(Node rootNode,
      Node? currentMenuNode,
      TreeViewModel viewModel, TreeController<Node> treeController) {
    if (currentMenuNode != null) {
      ref.read(currentlySelectedNodeProvider.notifier).setSelectedNode(currentMenuNode);
      ref.read(currentTodoStateProvider.notifier).setCurrentStateFromNode(currentMenuNode);
    }
    final context = ref.read(appRouterProvider).navigatorKey.currentContext;
    showAreYouSureDialog(context!, () async {
      CurrentTodoState currentTodoState = ref.read(currentTodoStateProvider);
      if (currentTodoState.currentCategory != null) {
        final todoFileNode = rootNode.findTodoFileNode(
          rootNode,
          currentTodoState.currentTodoFile!.id!,
        );
        if (todoFileNode != null && currentTodoState.currentCategory!.id != null) {
          todoFileNode.removeNode(rootNode, currentTodoState.currentCategory!.id!);
          treeController.rebuild();
        } else {
          logError('deleteCategory: Current Category id is null or todoFileNode is null');
        }
        var todoRepository = ref.read(todoRepositoryProvider);
        await todoRepository.deleteCategory(currentTodoState.currentCategory!, true);
      } else {
        logError('deleteCategory: Current Category is null');
      }
    }, null);
  }

  void duplicateCategory(
    Node rootNode,
    Node? currentMenuNode,
    TreeViewModel viewModel,
    TreeController<Node> treeController,
  ) {
    if (currentMenuNode != null) {
      ref.read(currentlySelectedNodeProvider.notifier).setSelectedNode(currentMenuNode);
      ref.read(currentTodoStateProvider.notifier).setCurrentStateFromNode(currentMenuNode);
    }
    showDuplicateDialog(ref, 'Duplicate Category', (String? newName) async {
      if (newName != null) {
        await viewModel.duplicateCurrentCategory(newName);
        treeController.rebuild();
      }
    });
  }

  void renameFile(
    Node rootNode,
    Node? currentMenuNode,
    TreeViewModel viewModel,
    TreeController<Node> treeController,
  ) {
    if (currentMenuNode != null) {
      ref.read(currentlySelectedNodeProvider.notifier).setSelectedNode(currentMenuNode);
      ref.read(currentTodoStateProvider.notifier).setCurrentStateFromNode(currentMenuNode);
    }
    showRenameDialog(ref, 'Rename File', (String? newName) async {
      if (newName != null) {
        await viewModel.renameCurrentFile(newName);
        treeController.rebuild();
      }
    });
  }

  void deleteFile(
    Node rootNode,
    Node? currentMenuNode,
    TreeViewModel viewModel,
    TreeController<Node> treeController,
  ) {
    if (currentMenuNode != null) {
      ref.read(currentlySelectedNodeProvider.notifier).setSelectedNode(currentMenuNode);
      ref.read(currentTodoStateProvider.notifier).setCurrentStateFromNode(currentMenuNode);
    }
    final context = ref.read(appRouterProvider).navigatorKey.currentContext;
    showAreYouSureDialog(context!, () async {
      CurrentTodoState currentTodoState = ref.read(currentTodoStateProvider);
      if (currentTodoState.currentTodoFile != null) {
        final todoFileNode = rootNode.findTodoFileNode(
          rootNode,
          currentTodoState.currentTodoFile!.id!,
        );
        if (todoFileNode != null) {
          todoFileNode.removeNode(rootNode, currentTodoState.currentTodoFile!.id!);
          treeController.rebuild();
        }
        var todoRepository = ref.read(todoRepositoryProvider);
        await todoRepository.deleteTodoFile(currentTodoState.currentTodoFile!);
      }
    }, null);
  }

  void duplicateFile(
    Node rootNode,
    Node? currentMenuNode,
    TreeViewModel viewModel,
    TreeController<Node> treeController,
  ) {
    if (currentMenuNode != null) {
      ref.read(currentlySelectedNodeProvider.notifier).setSelectedNode(currentMenuNode);
      ref.read(currentTodoStateProvider.notifier).setCurrentStateFromNode(currentMenuNode);
    }
    showDuplicateDialog(ref, 'Duplicate File', (String? newName) async {
      if (newName != null) {
        await viewModel.duplicateCurrentTodoFile(newName);
        treeController.rebuild();
      }
    });
  }

  /// Close the current file
  void closeFile(
    Node rootNode,
    Node? currentMenuNode,
    TreeViewModel viewModel,
    TreeController<Node> treeController,
  ) {
    if (currentMenuNode != null) {
      ref.read(currentlySelectedNodeProvider.notifier).setSelectedNode(currentMenuNode);
      ref.read(currentTodoStateProvider.notifier).setCurrentStateFromNode(currentMenuNode);
    }
    var todoRepository = ref.read(todoRepositoryProvider);
    CurrentTodoState currentTodoState = ref.read(currentTodoStateProvider);
    if (currentTodoState.currentTodoFile != null) {
      TodoFile? todoFile = todoRepository.findTodoFile(currentTodoState.currentTodoFile!.id!);
      if (todoFile != null) {
        todoRepository.closeFile(todoFile);
        Node? selectedNode = ref.read(currentlySelectedNodeProvider.notifier).getSelectedNode();
        if (selectedNode != null) {
          rootNode.removeNode(rootNode, selectedNode.id!);
          treeController.rebuild();
        }
      }
    }
  }

  /// Reload the current file
  Future reloadFile(
    Node rootNode,
    Node? currentMenuNode,
    TreeViewModel viewModel,
    TreeController<Node> treeController,
  ) async {
    if (currentMenuNode != null) {
      ref.read(currentlySelectedNodeProvider.notifier).setSelectedNode(currentMenuNode);
      ref.read(currentTodoStateProvider.notifier).setCurrentStateFromNode(currentMenuNode);
    }
    var todoRepository = ref.read(todoRepositoryProvider);
    CurrentTodoState currentTodoState = ref.read(currentTodoStateProvider);
    if (currentTodoState.currentTodoFile != null) {
      await todoRepository.reloadTodoFile(currentTodoState.currentTodoFile!.id!);
      viewModel.rebuildFileNode(currentTodoState.currentTodoFile!);
      treeController.rebuild();
    }
  }

  /// Reload the all files
  Future reload() async {
    ref.read(currentTodoStateProvider.notifier).reset();
    ref.read(currentFilesProvider.notifier).reset();
    var todoRepository = ref.read(todoRepositoryProvider);
    await todoRepository.reload();
  }

  /// Create a new Category
  Future<void> newCategory({
    required Node rootNode,
    Node? currentMenuNode,
    required TreeViewModel viewModel,
    required TreeController<Node> treeController,
  }) async {
    if (currentMenuNode != null) {
      ref.read(currentlySelectedNodeProvider.notifier).setSelectedNode(currentMenuNode);
      ref.read(currentTodoStateProvider.notifier).setCurrentStateFromNode(currentMenuNode);
    }
    showNewDialog(ref, newCategoryString, (value) async {
      if (value != null) {
        CurrentTodoState currentTodoState = ref.read(currentTodoStateProvider);
        if (currentTodoState.currentTodoFile != null) {
          var todoRepository = ref.read(todoRepositoryProvider);
          final newCategory = await todoRepository.addNewCategory(
            currentTodoState.currentTodoFile!.id!,
            Category(name: value),
          );
          // Need to update the last updated date on the todo file
          TodoFile? todoFile = todoRepository.findTodoFile(currentTodoState.currentTodoFile!.id!);
          if (todoFile != null) {
            todoFile = await todoRepository.updateTodoFile(
              todoFile.copyWith(lastUpdated: DateTime.now()),
            );
          }
          if (newCategory != null) {
            final todoFileNode = rootNode.findTodoFileNode(
              rootNode,
              currentTodoState.currentTodoFile!.id!,
            );
            if (todoFileNode != null) {
              var findTodoFile = todoRepository.findTodoFile(currentTodoState.currentTodoFile!.id!);
              if (findTodoFile != null) {
                findTodoFile = todoRepository.addCategoryToTodoFile(findTodoFile, newCategory);
                todoFileNode.addChildNode(
                  viewModel.createCategoryNode(todoFileNode, findTodoFile, newCategory),
                );
                treeController.expand(todoFileNode);
              }
              treeController.rebuild();
            }
          }
        }
      }
    });
  }

  /// Create a new File
  void newFile(Node rootNode, TreeViewModel viewModel, TreeController<Node> treeController) {
    showNewDialog(ref, newListString, (value) async {
      if (value != null) {
        var todoRepository = ref.read(todoRepositoryProvider);
        var todoFile = TodoFile(name: value);
        todoFile = await todoRepository.addNewTodoFile(todoFile);
        var todoFileNode = viewModel.createTodoFileNode(todoFile);
        rootNode.addChildNode(todoFileNode);
        treeController.expand(todoFileNode);
        treeController.rebuild();
      }
    });
  }

  void showLogs() {}

  /// Logout the user
  void logout() {
    var todoRepository = ref.read(todoRepositoryProvider);
    getProviderSupaAuthManager(ref).logout();
    todoRepository.clear();
    ref.read(appRouterProvider).popAndPush(LoginRoute(onResult: (result) {
      if (result) {
        ref.read(appRouterProvider).replace(MainScreenRoute());
      }
    }));
  }

  /// Read a file from disk
  void loadFile(Node rootNode, TreeViewModel viewModel, TreeController<Node> treeController) {}

  /// Show a dialog to load a file
  void openFile(Node rootNode, TreeViewModel viewModel, TreeController<Node> treeController) {
    showOpen(ref, (TodoFile? todoFile) async {
      if (todoFile != null) {
        var todoRepository = ref.read(todoRepositoryProvider);
        todoFile = await todoRepository.addNewTodoFile(todoFile);
        var todoFileNode = viewModel.createTodoFileNode(todoFile);
        rootNode.addChildNode(todoFileNode);
        treeController.expand(todoFileNode);
        treeController.rebuild();
      }
    });
  }

  /// Close all files
  void closeAllFiles(Node rootNode, TreeViewModel viewModel, TreeController<Node> treeController) {
    final context = ref.read(appRouterProvider).navigatorKey.currentContext;
    showAreYouSureDialog(context!, () async {
      var todoRepository = ref.read(todoRepositoryProvider);
      todoRepository.closeAllFiles();
      ref.read(currentTodoStateProvider.notifier).reset();
      ref.read(currentlySelectedNodeProvider.notifier).setSelectedNode(null);
    }, null);
  }

  void scrollToIndex(int index, ScrollController scrollController) {
    final scrollOffset = index * 40.0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollOffset,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }
}
