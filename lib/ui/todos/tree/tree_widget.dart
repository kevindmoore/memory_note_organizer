import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:memory_notes_organizer/events/menu_events.dart';
import 'package:memory_notes_organizer/models/node.dart';
import 'package:memory_notes_organizer/models/search_result.dart';
import 'package:memory_notes_organizer/models/selection_state.dart';
import 'package:memory_notes_organizer/models/todos.dart';
import 'package:memory_notes_organizer/providers.dart';
import 'package:memory_notes_organizer/ui/dialogs/search_dialog.dart';
import 'package:memory_notes_organizer/ui/todos/todo_actions.dart';
import 'package:memory_notes_organizer/ui/todos/tree/tree_row.dart';
import 'package:memory_notes_organizer/ui/todos/tree/tree_viewmodel.dart';
import 'package:memory_notes_organizer/ui/widgets/find_row.dart';
import 'package:memory_notes_organizer/ui/widgets/widget_utils.dart';
import 'package:utilities/utilities.dart';

class TreeWidget extends ConsumerStatefulWidget {
  const TreeWidget({super.key});

  @override
  ConsumerState<TreeWidget> createState() => _TreeWidgetState();
}

class _TreeWidgetState extends ConsumerState<TreeWidget> with AutomaticKeepAliveClientMixin {
  late final TreeController<Node> treeController;
  final ScrollController scrollController = ScrollController();
  TextEditingController nodeTextController = TextEditingController(text: '');
  late final TreeViewModel viewModel;
  FocusNode treeFocusNode = FocusNode();
  FocusNode textFieldFocusNode = FocusNode();
  FocusNode treeRowFocusNode = FocusNode();

  List<TodoFile> currentTodoFiles = [];
  bool loading = true;
  bool searching = false;
  bool initializing = true;
  bool editing = true;
  late TodoActions todoActions;
  Node? editingNode;
  Node? editingParentNode;

  @override
  void initState() {
    super.initState();
    viewModel = ref.read(treeViewModelProvider);
    todoActions = ref.read(todoActionsProvider);
    treeController = TreeController<Node>(
      // Provide the root nodes that will be used as a starting point when
      // traversing your hierarchical data.
      roots: [viewModel.rootNode],
      // Provide a callback for the controller to get the children of a
      // given node when traversing your hierarchical data. Avoid doing
      // heavy computations in this method, it should behave like a getter.
      childrenProvider: (Node node) => node.children,
      parentProvider: (Node node) {
        if (node.type == NodeType.root) {
          return null;
        }
        if (node.type == NodeType.file) {
          return viewModel.rootNode;
        }
        if (node.type == NodeType.category) {
          Node? previousNode = node.previous;
          while (previousNode != null &&
              previousNode.previous != null &&
              previousNode.previous?.type != NodeType.file) {
            previousNode = previousNode.previous;
          }
          return previousNode;
        }
        if (node.type == NodeType.todo) {
          if (node.todoInfo.parentId != null) {
            return node.findTodoNode(viewModel.rootNode, node.todoInfo.parentId);
          }
          // Node? previousNode = node.previous;
          // while (previousNode != null &&
          //     previousNode.previous != null &&
          //     previousNode.previous?.type != NodeType.category) {
          //   previousNode = previousNode.previous;
          // }
          return node.previous;
        }
        return node.previous;
      },
    );
    treeController.expand(viewModel.rootNode);
    setupListeners();
  }

  @override
  void dispose() {
    treeFocusNode.dispose();
    treeController.dispose();
    scrollController.dispose();
    nodeTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Required for automatic keep alive
    super.build(context);
    var theme = ref.watch(themeProvider);
    ref.listen<List<TodoFile>>(currentFilesProvider, (previous, todoFiles) {
      if (initializing && todoFiles.isEmpty) {
        loading = false;
        initializing = false;
      } else {
        initializing = false;
        if (todoFiles.length != currentTodoFiles.length) {
          currentTodoFiles = todoFiles;
          if (todoFiles.isEmpty) {
            loading = true;
          } else {
            buildTree();
          }
        }
      }
      setState(() {});
    });
    if (loading) {
      return loadingWidget(theme);
    }
    return FocusDetector(
      onFocusGained: onFocusGained,
      child: Container(
        decoration: createGradient(theme.startGradientColor, theme.endGradientColor),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              vSpace8,
              const FindRow(),
              vSpace8,
              buildNavigationRow(),
              vSpace8,
              Expanded(
                child: Focus(
                  focusNode: treeFocusNode,
                  onKeyEvent: handleKeyEvent,
                  child: TreeView<Node>(
                    treeController: treeController,
                    controller: scrollController,
                    nodeBuilder: (BuildContext context, TreeEntry<Node> entry) {
                      if (entry.node.type == NodeType.root) {
                        return SizedBox.shrink();
                      }
                      return TreeRow(
                        textController: nodeTextController,
                        treeRowFocusNode: treeRowFocusNode,
                        textFieldFocusNode: textFieldFocusNode,
                        treeController: treeController,
                        entry: entry,
                        editing: entry.node == editingNode,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future buildTree() async {
    await viewModel.buildTree(currentTodoFiles);
    treeController.roots = [viewModel.rootNode];
    setState(() {
      loading = false;
    });
  }

  Widget buildNavigationRow() {
    var theme = ref.watch(themeProvider);
    Node? currentlySelectedNode = ref.watch(currentlySelectedNodeProvider);
    if (currentlySelectedNode == null || currentlySelectedNode.type == NodeType.root) {
      final menuItems = <PopupMenuEntry<PopupMenuItem>>[];
      menuItems.add(
        buildPopupMenuItem(
          child: Row(
            children: [
              const Icon(Icons.file_open),
              const SizedBox(width: 4.0),
              Text('Open', style: mediumBlackText),
            ],
          ),
          onTap: () {
            ref
                .read(todoActionsProvider)
                .openFile(viewModel.rootNode, viewModel, treeController);
          },
        ),
      );
      menuItems.add(
          buildPopupMenuItem(
            child: Row(
              children: [
                const Icon(Icons.close),
                const SizedBox(width: 4.0),
                Text('Close All', style: mediumBlackText),
              ],
            ),
            onTap: () {
              ref
                  .read(todoActionsProvider)
                  .closeAllFiles(viewModel.rootNode, viewModel, treeController);
            },
          ),
      );
      menuItems.add(
          buildPopupMenuItem(
            child: Row(
              children: [
                const Icon(Icons.refresh),
                const SizedBox(width: 4.0),
                Text('Reload', style: mediumBlackText),
              ],
            ),
            onTap: () async {
              await ref
                  .read(todoActionsProvider)
                  .reload();
              treeController.rebuild();
            },
          ),
      );
      return Row(
        children: [
          Text('Lists', style: getMediumTextStyle(theme.textColor)),
          const Spacer(),
          buildIconButton(
            tooltip: 'New',
            onPressed: () {
              ref.read(todoActionsProvider).newFile(viewModel.rootNode, viewModel, treeController);
            },
            icon: Icon(Icons.add, color: theme.textColor),
          ),

          buildPopupMenu(
            icon: Icon(Icons.more_vert, color: theme.textColor),
            itemBuilder:
                (context) => menuItems,
          ),
        ],
      );
    } else {
      final rowWidgets = <Widget>[];
      rowWidgets.add(
        buildIconButton(
          tooltip: 'Go Up',
          onPressed: () {
            getTodoStateProvider().goTop();
            treeController.collapseAll();
            treeController.expand(viewModel.rootNode);
          },
          icon: Icon(Icons.vertical_align_top, color: theme.textColor),
        ),
      );
      rowWidgets.add(
        buildIconButton(
          tooltip: 'Back',
          onPressed: () {
            final node = getTodoStateProvider().goUp();
            if (node != null) {
              treeController.collapse(node);
            } else {
              treeController.collapseAll();
              treeController.expand(viewModel.rootNode);
            }
          },
          icon: Icon(Icons.chevron_left, color: theme.textColor),
        ),
      );
      rowWidgets.add(const Divider());
      rowWidgets.add(
        Expanded(
          flex: 1,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              final node = getTodoStateProvider().goUp();
              if (node != null) {
                treeController.collapse(node);
              }
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: AutoSizeText(
                getCurrentPathString(currentlySelectedNode),
                overflowReplacement: Text(
                  currentlySelectedNode.name,
                  style: getMediumTextStyle(theme.textColor),
                ),
                style: getMediumTextStyle(theme.textColor),
                maxLines: 1,
              ),
            ),
          ),
        ),
      );
      rowWidgets.add(
        buildIconButton(
          tooltip: 'New',
          onPressed: () {
            ref
                .read(todoActionsProvider)
                .newTodo(
                  rootNode: viewModel.rootNode,
                  currentMenuNode: null,
                  treeViewModel: viewModel,
                  treeController: treeController,
                  scrollController: scrollController,
                );
          },
          icon: Icon(Icons.add, color: theme.textColor),
        ),
      );
      if (currentlySelectedNode.type == NodeType.file ||
          currentlySelectedNode.type == NodeType.category) {
        final menuItems = <PopupMenuEntry<PopupMenuItem>>[];
        final deleteText =
            (currentlySelectedNode.type == NodeType.file) ? 'Delete File' : 'Delete Category';
        menuItems.add(
            buildPopupMenuItem(
              child: Row(
                children: [
                  const Icon(Icons.delete),
                  const SizedBox(width: 4.0),
                  Text(deleteText, style: mediumBlackText),
                ],
              ),
              onTap: () {
                if (currentlySelectedNode.type == NodeType.file) {
                  ref
                      .read(todoActionsProvider)
                      .deleteFile(viewModel.rootNode, currentlySelectedNode, viewModel, treeController);
                } else {
                  ref
                      .read(todoActionsProvider)
                      .deleteCategory(viewModel.rootNode, currentlySelectedNode, viewModel, treeController);
                }
              },
            ),
        );
        menuItems.add(
            buildPopupMenuItem(
              child: Row(
                children: [
                  const Icon(Icons.close),
                  const SizedBox(width: 4.0),
                  Text('Close', style: mediumBlackText),
                ],
              ),
              onTap: () {
                ref
                    .read(todoActionsProvider)
                    .closeFile(viewModel.rootNode, currentlySelectedNode, viewModel, treeController);
              },
            ),
        );
        rowWidgets.add(
          buildPopupMenu(
            icon: Icon(Icons.more_vert, color: theme.textColor),
            itemBuilder:
                (context) => menuItems,
          ),
        );
      }
      return Row(children: rowWidgets);
    }
  }

  Widget buildPopupMenu({required Icon icon, required PopupMenuItemBuilder<PopupMenuItem> itemBuilder}) {
    return PopupMenuButton(
      icon: icon,
      itemBuilder: itemBuilder,
    );
  }

  PopupMenuEntry<PopupMenuItem> buildPopupMenuItem({required Widget child, VoidCallback? onTap}) {
    return PopupMenuItem(
      onTap: onTap,
      child: child,
    );
  }

  Row buildRow(List<Widget> widgets) {
    return Row(children: widgets,);
  }

  IconButton buildIconButton({required String tooltip, required Widget icon, required VoidCallback onPressed}) {
    return IconButton(
      tooltip: tooltip,
      constraints: const BoxConstraints(),
      padding: const EdgeInsets.fromLTRB(2.0, 8.0, 0.0, 8.0),
      alignment: Alignment.centerLeft,
      onPressed: onPressed,
      icon: icon,
    );

  }

  String getCurrentPathString(Node? currentNode) {
    if (currentNode == viewModel.rootNode) {
      return '';
    }
    var pathString = '';
    Node? node = currentNode;
    // Go from bottom up
    final names = <String>[];
    while (node != null && node != viewModel.rootNode) {
      if (node.type != NodeType.todo) {
        names.add(node.name);
      }
      node = node.previous;
    }

    // Now reverse the order
    for (var i = names.length - 1; i >= 0; i--) {
      pathString += '${names[i]} / ';
    }
    return pathString;
  }

  void setupListeners() {
    getSearchBus().on<SearchResult>().listen((event) {
      getTodoRepository().showSearch(event);
    });
    getSearchBus().on<SelectionState>().listen((newSelectionState) {
      todoActions.search(newSelectionState, viewModel.rootNode, treeController, (index, node) {
        logMessage('Searching for ${node.name} at index $index');
        getMenuBus().fire(TabSelectEvent(0));
        todoActions.scrollToIndex(index, scrollController);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          expandNodesUntil(node);
          getTodoStateProvider().selectNode(node, -1);
          setState(() {});
        });
      });
    });
    getMenuBus().on<Event>().listen((event) {
      switch (event.runtimeType) {
        case _ when event is CloseCurrentFileEvent:
          todoActions.closeFile(viewModel.rootNode, event.node, viewModel, treeController);
          break;
        case _ when event is CloseAllFileEvent:
          todoActions.closeAllFiles(viewModel.rootNode, viewModel, treeController);
          break;
        case _ when event is OpenFileEvent:
          todoActions.openFile(viewModel.rootNode, viewModel, treeController);
          break;
        case _ when event is LoadFileEvent:
          todoActions.loadFile(viewModel.rootNode, viewModel, treeController);
          break;
        case _ when event is LogoutEvent:
          todoActions.logout();
          break;
        case _ when event is LogsEvent:
          todoActions.showLogs();
          break;
        case _ when event is NewFileEvent:
          todoActions.newFile(viewModel.rootNode, viewModel, treeController);
          break;
        case _ when event is NewCategoryEvent:
          todoActions.newCategory(
            rootNode: viewModel.rootNode,
            currentMenuNode: event.node,
            viewModel: viewModel,
            treeController: treeController,
          );
          break;
        case _ when event is NewTodoEvent:
          todoActions.newTodo(
            rootNode: viewModel.rootNode,
            currentMenuNode: event.node,
            treeViewModel: viewModel,
            treeController: treeController,
            scrollController: scrollController,
          );
          break;
        case _ when event is DeleteTodoEvent:
          todoActions.deleteTodo(
            rootNode: viewModel.rootNode,
            currentMenuNode: event.node,
            treeController: treeController,
          );
          break;
        case _ when event is RenameTodoEvent:
          todoActions.renameTodo(viewModel.rootNode, event.node, viewModel, treeController);
          break;
        case _ when event is ReloadEvent:
          todoActions.reload();
          break;
        case _ when event is ReloadFileEvent:
          todoActions.reloadFile(viewModel.rootNode, event.node, viewModel, treeController);
          break;
        case _ when event is CloseFileEvent:
          todoActions.closeFile(viewModel.rootNode, event.node, viewModel, treeController);
          break;
        case _ when event is DuplicateFileEvent:
          todoActions.duplicateFile(viewModel.rootNode, event.node, viewModel, treeController);
          break;
        case _ when event is DeleteFileEvent:
          todoActions.deleteFile(viewModel.rootNode, event.node, viewModel, treeController);
          break;
        case _ when event is RenameFileEvent:
          todoActions.renameFile(viewModel.rootNode, event.node, viewModel, treeController);
          break;
        case _ when event is DuplicateCategoryEvent:
          todoActions.duplicateCategory(viewModel.rootNode, event.node, viewModel, treeController);
          break;
        case _ when event is DeleteCategoryEvent:
          todoActions.deleteCategory(viewModel.rootNode, event.node, viewModel, treeController);
          break;
        case _ when event is RenameCategoryEvent:
          todoActions.renameCategory(viewModel.rootNode, event.node, viewModel, treeController);
          break;
        case _ when event is QuitEvent:
          final currentContext = ref.read(appRouterProvider).navigatorKey.currentContext!;
          if (currentContext.mounted) {
            showAreYouSureDialog(
              currentContext,
              () {
                SystemNavigator.pop();
              },
              () {
                // No
              },
            );
          }

          break;
        case _ when event is DuplicateTodoEvent:
          todoActions.duplicateTodo(rootNode: viewModel.rootNode, currentMenuNode: event.node, viewModel: viewModel, treeController: treeController);
          break;
        case _ when event is TodoUpdatedEvent:
          viewModel.updateTodoNode(event.todo);
          break;
        case _ when event is ShowSearchEvent:
          showSearchDialog(ref);
          break;
        default:
          logMessage('Unknown Event: ${event.runtimeType}');
      }
    });
  }

  void expandNodesUntil(Node node) {
    treeController.expandAncestors(node);
  }

  @override
  bool get wantKeepAlive => true;

  void closeKeyboard() {
    unawaited(dismissKeyboard());
  }

  void onFocusGained() {
    closeKeyboard();
  }

  KeyEventResult handleKeyEvent(FocusNode node, KeyEvent event) {
    // Correctly check for key press and Enter key
    if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.enter) {
      if (HardwareKeyboard.instance.isControlPressed || // Ctrl
          HardwareKeyboard.instance.isMetaPressed) {

        if (editing) {
          Node? currentlySelectedNode = ref.read(currentlySelectedNodeProvider);
          if (currentlySelectedNode != null && currentlySelectedNode.id == null) {
            saveTodo(currentlySelectedNode);
          } else {
            renameTodo(currentlySelectedNode);
          }
        }
// Add a new Node
        editingParentNode = ref.read(currentlySelectedNodeProvider);
        editingNode = viewModel.addNewNodeAtSelectedNode();
        if (editingNode != null) {
          treeController.rebuild();
          treeController.expandAncestors(editingNode!);
          nodeTextController.text = '';
          textFieldFocusNode.requestFocus();
          getTodoStateProvider().selectNode(editingNode!, -1);
          setState(() {
            editing = true;
          });
        }
      } else if (HardwareKeyboard.instance.isAltPressed) {

        // Add a new Sibling Node
        Node? currentNode = ref.read(currentlySelectedNodeProvider);
        editingParentNode = currentNode?.previous;
        if (editingParentNode != null) {
          editingNode = viewModel.addNewNodeToParent(editingParentNode!);
          if (editingNode != null) {
            treeController.rebuild();
            treeController.expandAncestors(editingNode!);
            nodeTextController.text = '';
            textFieldFocusNode.requestFocus();
            getTodoStateProvider().selectNode(editingNode!, -1);
            setState(() {
              editing = true;
            });
          }
        }
      } else {
        if (editing) {
          Node? currentlySelectedNode = ref.read(currentlySelectedNodeProvider);
          if (currentlySelectedNode != null && currentlySelectedNode.id == null) {
            saveTodo(currentlySelectedNode);
          } else {
            renameTodo(currentlySelectedNode);
          }
        }
        setState(() {
          editing = !editing;
          if (editing) {
            editingNode = ref.read(currentlySelectedNodeProvider);
            nodeTextController.text = editingNode?.name ?? '';
            WidgetsBinding.instance.addPostFrameCallback((_) {
              textFieldFocusNode.requestFocus();
              nodeTextController.selection = TextSelection.fromPosition(
                TextPosition(offset: nodeTextController.text.length),
              );
            });
          }
        });
      }
      return KeyEventResult.handled;
    }
    if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.escape) {
      setState(() {
        if (editing) {
          Node? currentlySelectedNode = ref.read(currentlySelectedNodeProvider);
          if (currentlySelectedNode != null && currentlySelectedNode.id == null) {
            saveTodo(currentlySelectedNode);
          } else {
            renameTodo(currentlySelectedNode);
          }
        }
        editing = false;
      });
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  Future saveTodo(Node currentlySelectedNode) async {
    if (editing) {
      if (nodeTextController.text.isNotEmpty && editingParentNode != null) {
        Node updatedNode = await viewModel.updateItemAtSelectedNode(editingParentNode!, currentlySelectedNode, nodeTextController.text);
        treeController.rebuild();
        setState(() {});
        WidgetsBinding.instance.addPostFrameCallback((_) {
          getTodoStateProvider().selectNode(updatedNode, -1);
          treeRowFocusNode.requestFocus();
        });
      } else {
        // Delete the empty node
        if (nodeTextController.text.isEmpty) {
          Node? currentlySelectedNode = ref.read(currentlySelectedNodeProvider);
          if (currentlySelectedNode != null) {
            currentlySelectedNode.deleteNode(currentlySelectedNode);
            treeController.rebuild();
            setState(() {});
          }
        }
      }
      editing = false;
      editingNode = null;
      editingParentNode = null;
    }
  }

  Future renameTodo(Node? currentlySelectedNode) async {
    if (editing) {
      if (nodeTextController.text.isNotEmpty) {
        await viewModel.renameCurrentTodo(nodeTextController.text);
        treeController.rebuild();
        setState(() {});
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Node? currentlySelectedNode = ref.read(currentlySelectedNodeProvider);
          if (currentlySelectedNode != null) {
            Node? updatedNode = viewModel.rootNode.findNodeById(
              viewModel.rootNode,
              currentlySelectedNode.id,
            );
            if (updatedNode != null) {
              getTodoStateProvider().selectNode(updatedNode, -1);
            }
            treeRowFocusNode.requestFocus();
          }
        });
      }
      editing = false;
      editingNode = null;
      editingParentNode = null;
    }
  }
}
