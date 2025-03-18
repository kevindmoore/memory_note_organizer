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
import 'package:memory_notes_organizer/ui/todos/tree/tree_viewmodel.dart';
import 'package:memory_notes_organizer/ui/widgets/find_row.dart';
import 'package:memory_notes_organizer/ui/widgets/row_menu.dart';
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
  late final TreeViewModel viewModel;
  List<TodoFile> currentTodoFiles = [];
  bool loading = true;
  bool searching = false;
  late TodoActions todoActions;

  @override
  void initState() {
    super.initState();
    viewModel = ref.read(treeViewModelProvider);
    todoActions = TodoActions(ref);
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
    treeController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Required for automatic keep alive
    super.build(context);
    var theme = ref.watch(themeProvider);
    List<TodoFile> todoFiles = ref.watch(currentFilesProvider);
    if (todoFiles.length != currentTodoFiles.length) {
      currentTodoFiles = todoFiles;
      if (todoFiles.isEmpty) {
        loading = true;
      } else {
        buildTree();
      }
    }
    if (loading) {
      return loadingWidget();
    }
    return FocusDetector(
      onFocusGained: closeKeyboard,
      child: Container(
        decoration: createGradient(
          theme.startGradientColor,
          theme.endGradientColor,
        ),
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
                child: TreeView<Node>(
                  treeController: treeController,
                  controller: scrollController,
                  nodeBuilder: (BuildContext context, TreeEntry<Node> entry) {
                    if (entry.node.type == NodeType.root) {
                      return SizedBox.shrink();
                    }
                    return getTreeRow(entry);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getTreeRow(TreeEntry<Node> entry) {
    Node node = entry.node;
    var theme = ref.watch(themeProvider);
    Node? currentlySelectedNode = ref.watch(currentlySelectedNodeProvider);
    final selected = currentlySelectedNode == node;
    final color = selected ? theme.inverseTextColor : theme.textColor;
    final row = GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        setState(() {
          treeController.toggleExpansion(entry.node);
          if (currentlySelectedNode != node) {
          //   getTodoStateProvider().clearSelection();
          // } else {
            // Should be selected in this method
            getTodoStateProvider().selectNode(node, -1);
            // if (usePhone(mediaQuery)) {
            //   // context.pushNamed(notesRouteName);
            // }
          }
        });
      },
      child: TreeIndentation(
        entry: entry,
        guide: const IndentGuide.connectingLines(
          indent: 24,
          color: Colors.black,
        ),
        child: SizedBox(
          height: 40,
          child: Align(
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(width: 4),
                Expanded(
                  child: AutoSizeText(
                    node.name,
                    style: getMediumTextStyle(color),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // if (node.children.isNotEmpty)
                Align(
                  alignment: Alignment.centerRight,
                  child: RowMenu(node, selected),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    if (selected) {
      return Container(decoration: createBlackBorderedBox(), child: row);
    } else {
      return row;
    }
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
    if (currentlySelectedNode == null ||
        currentlySelectedNode.type == NodeType.root) {
      return Row(
        children: [
          Text('Lists', style: getMediumTextStyle(theme.textColor)),
          const Spacer(),
          IconButton(
            tooltip: 'New',
            onPressed: () {},
            icon: Icon(Icons.add, color: theme.textColor),
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert, color: theme.textColor),
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    child: Row(
                      children: [
                        const Icon(Icons.file_open),
                        const SizedBox(width: 4.0),
                        Text('Open', style: mediumBlackText),
                      ],
                    ),
                    onTap: () {
                      todoActions.openFile(viewModel.rootNode, viewModel, treeController);
                    },
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: [
                        const Icon(Icons.close),
                        const SizedBox(width: 4.0),
                        Text('Close All', style: mediumBlackText),
                      ],
                    ),
                    onTap: () {
                      todoActions.closeAllFiles(viewModel.rootNode, viewModel, treeController);
                    },
                  ),
                ],
          ),
        ],
      );
    } else {
      final rowWidgets = <Widget>[];
      rowWidgets.add(
        IconButton(
          tooltip: 'Go Up',
          constraints: const BoxConstraints(),
          padding: const EdgeInsets.fromLTRB(2.0, 8.0, 0.0, 8.0),
          alignment: Alignment.centerLeft,
          onPressed: () {
            getTodoStateProvider().goTop();
            treeController.collapseAll();
            treeController.expand(viewModel.rootNode);
          },
          icon: Icon(Icons.vertical_align_top, color: theme.textColor),
        ),
      );
      rowWidgets.add(
        IconButton(
          tooltip: 'Back',
          constraints: const BoxConstraints(),
          padding: const EdgeInsets.fromLTRB(2.0, 8.0, 0.0, 8.0),
          alignment: Alignment.centerLeft,
          onPressed: () {
            final node = getTodoStateProvider().goUp();
            if (node != null) {
              treeController.collapse(node);
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
        IconButton(
          tooltip: 'New',
          onPressed: () {
            todoActions.newTodo(viewModel.rootNode, viewModel, treeController);
          },
          icon: Icon(Icons.add, color: theme.textColor),
        ),
      );
      if (currentlySelectedNode.type == NodeType.file ||
          currentlySelectedNode.type == NodeType.category) {
        final deleteText =
            (currentlySelectedNode.type == NodeType.file)
                ? 'Delete File'
                : 'Delete Category';
        rowWidgets.add(
          PopupMenuButton(
            icon: Icon(Icons.more_vert, color: theme.textColor),
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    child: Row(
                      children: [
                        const Icon(Icons.delete),
                        const SizedBox(width: 4.0),
                        Text(deleteText, style: mediumBlackText),
                      ],
                    ),
                    onTap: () {
                      if (currentlySelectedNode.type == NodeType.file) {
                        todoActions.deleteFile(viewModel.rootNode, viewModel, treeController);
                      } else {
                        todoActions.deleteCategory(viewModel.rootNode, viewModel, treeController);
                      }
                    },
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: [
                        const Icon(Icons.close),
                        const SizedBox(width: 4.0),
                        Text('Close', style: mediumBlackText),
                      ],
                    ),
                    onTap: () {
                      todoActions.closeFile(viewModel.rootNode, viewModel, treeController);
                    },
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: [
                        const Icon(Icons.refresh),
                        const SizedBox(width: 4.0),
                        Text('Reload', style: mediumBlackText),
                      ],
                    ),
                    onTap: () {
                      todoActions.reloadFile(viewModel.rootNode, viewModel, treeController);
                    },
                  ),
                ],
          ),
        );
      }
      return Row(children: rowWidgets);
    }
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
        final scrollOffset = index * 40.0;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // expandNodesUntil(node);
          scrollController.animateTo(
            scrollOffset,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
          getTodoStateProvider().selectNode(node, -1);
          setState(() {});
        });
      });
   });
    getMenuBus().on<Event>().listen((event) {
      switch (event.runtimeType) {
        case _ when event is CloseCurrentFileEvent:
          todoActions.closeFile(viewModel.rootNode, viewModel, treeController);
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
          todoActions.newCategory(viewModel.rootNode, viewModel, treeController);
          break;
        case _ when event is NewTodoEvent:
          todoActions.newTodo(viewModel.rootNode, viewModel, treeController);
          break;
        case _ when event is DeleteTodoEvent:
          todoActions.deleteTodo(viewModel.rootNode, treeController);
          break;
        case _ when event is RenameTodoEvent:
          todoActions.renameTodo(viewModel.rootNode, viewModel, treeController);
          break;
        case _ when event is ReloadEvent:
          todoActions.reload();
          break;
        case _ when event is ReloadFileEvent:
          todoActions.reloadFile(viewModel.rootNode, viewModel, treeController);
          break;
        case _ when event is CloseFileEvent:
          todoActions.closeFile(viewModel.rootNode, viewModel, treeController);
          break;
        case _ when event is DuplicateFileEvent:
          todoActions.duplicateFile(viewModel.rootNode, viewModel, treeController);
          break;
        case _ when event is DeleteFileEvent:
          todoActions.deleteFile(viewModel.rootNode, viewModel, treeController);
          break;
        case _ when event is RenameFileEvent:
          todoActions.renameFile(viewModel.rootNode, viewModel, treeController);
          break;
        case _ when event is DuplicateCategoryEvent:
          todoActions.duplicateCategory(viewModel.rootNode, viewModel, treeController);
          break;
        case _ when event is DeleteCategoryEvent:
          todoActions.deleteCategory(viewModel.rootNode, viewModel, treeController);
          break;
        case _ when event is RenameCategoryEvent:
          todoActions.renameCategory(viewModel.rootNode, viewModel, treeController);
          break;
        case _ when event is QuitEvent:
          final currentContext = ref.read(appRouterProvider).navigatorKey.currentContext!;
          if (currentContext.mounted) {
            showAreYouSureDialog(currentContext, () {
              SystemNavigator.pop();
            }, () {
              // No
            });
          }

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
}
