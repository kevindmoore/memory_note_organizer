import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utilities/utilities.dart';

import '../../../models/node.dart';
import '../../../utils/utils.dart';
import 'text_editor.dart';
import '../../viewmodels/main_screen_model.dart';
import '../main_functions.dart';
import 'row_menu.dart';

class NodeRow extends ConsumerStatefulWidget {
  final Node currentNode;
  final int index;
  final bool editing;
  final bool selected;

  const NodeRow(this.currentNode,
      this.index, this.editing, this.selected,
      {super.key});

  @override
  ConsumerState<NodeRow> createState() => _NodeRowState();
}

class _NodeRowState extends ConsumerState<NodeRow> {
  late MainFunctions mainFunctions;
  late MainScreenModel mainScreenModel;

  @override
  void initState() {
    mainFunctions = MainFunctions(mainFunctionCallback);
    super.initState();
  }

  void mainFunctionCallback(CallbackType type, Object? data) {
    // TODO - Do something with this?
    switch (type) {
      case CallbackType.add:
        break;
      case CallbackType.delete:
        break;
      case CallbackType.rename:
        break;
      case CallbackType.refresh:
        break;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    mainScreenModel = ref.watch(mainScreenModelProvider);
    mainFunctions.build(ref);
    if (widget.selected) {
      return Container(
          decoration: createBlackBorderedBox(),
          child: buildNodeRow(
              context,
              widget.currentNode,
              widget.index,
              mainScreenModel.themeColors.inverseTextColor,
              true,
              widget.editing,
              widget.selected));
    } else {
      return buildNodeRow(
          context,
          widget.currentNode,
          widget.index,
          mainScreenModel.themeColors.textColor,
          false,
          widget.editing,
          widget.selected);
    }
  }

  Widget buildNodeRow(BuildContext context, Node currentNode, int index,
      Color textColor, bool showMenu, bool editing, bool selected) {
    if (currentNode.children.isEmpty) {
      return Container();
    }
    if (index < 0 || index >= currentNode.children.length) {
      logAndShowWidgetError(ref, 'Index $index not in the current nodes length of ${currentNode.children.length}');
      return Container();
    }
    final childNode = currentNode.children[index];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            width: 4,
          ),
          useFolder(childNode)
              ? Icon(
                  Icons.folder,
                  color: textColor,
                )
              : Icon(
                  Icons.file_copy,
                  color: textColor,
                ),
          const SizedBox(
            width: 8,
          ),
          TextEditor(
            key: ValueKey(childNode.getId()),
            initialText: childNode.name,
            textColor: textColor,
            editing: editing,
            changedListener: (newValue) {
              // logMessage('Change Listener: newvalue = $newValue');
              mainScreenModel.editingRow = -1;
              if (newValue != null) {
                mainScreenModel.updateName(childNode, newValue);
              }
            },
          ),
          const SizedBox(
            width: 8,
          ),
          displayNextArrow(currentNode, index),
          if (showMenu) RowMenu(childNode, selected)
        ],
      ),
    );
  }

  void resetFlags() {
    mainScreenModel.showNewFolder = false;
    mainScreenModel.changeTheme = false;
    mainScreenModel.showDeleteMenu = false;
  }

  Widget displayNextArrow(Node currentNode, int index) {
    final childNode = currentNode.children[index];
    if (childNode.children.isNotEmpty) {
      final iconColor = index == mainScreenModel.currentlySelectedIndex
          ? Colors.black
          : Colors.white;
      return IconButton(
        onPressed: () {
          resetFlags();
          mainScreenModel.selectCurrentNode(childNode);
        },
        icon: Icon(
          Icons.arrow_forward_ios,
          color: iconColor,
        ),
      );
    }
    return Container();
  }

  bool useFolder(Node path) {
    if (path.type == NodeType.file ||
        path.type == NodeType.category ||
        (path.children.isNotEmpty)) {
      return true;
    }
    return false;
  }
}
