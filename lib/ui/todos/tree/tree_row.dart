import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memory_notes_organizer/models/node.dart';
import 'package:memory_notes_organizer/providers.dart';
import 'package:memory_notes_organizer/ui/todos/tree/tree_viewmodel.dart';
import 'package:memory_notes_organizer/ui/widgets/row_menu.dart';
import 'package:utilities/utilities.dart';

class TreeEditingInfo {
  bool editing;
  Node? entry;

  TreeEditingInfo(this.editing, this.entry);
}

class TreeRow extends ConsumerStatefulWidget {
  final TreeController<Node> treeController;
  final TreeEntry<Node> entry;
  final bool editing;
  final TextEditingController textController;
  final FocusNode textFieldFocusNode;
  final FocusNode treeRowFocusNode;

  const TreeRow({
    required this.textController,
    required this.treeRowFocusNode,
    required this.textFieldFocusNode,
    required this.treeController,
    required this.entry,
    required this.editing,
    super.key,
  });

  @override
  ConsumerState<TreeRow> createState() => _TreeRowState();
}

class _TreeRowState extends ConsumerState<TreeRow> {
  double rowHeight = 40;

  late final TreeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = ref.read(treeViewModelProvider);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Node node = widget.entry.node;
    var theme = ref.watch(themeProvider);
    Node? currentlySelectedNode = ref.watch(currentlySelectedNodeProvider);
    final selected = currentlySelectedNode == node;
    final color = selected ? theme.inverseTextColor : theme.textColor;

    final row = GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        setState(() {
          if (!widget.entry.isExpanded) {
            widget.treeController.toggleExpansion(node);
          }
          if (currentlySelectedNode != node) {
            getTodoStateProvider().selectNode(node, -1);
            widget.treeRowFocusNode.requestFocus();
          }
        });
      },
      child: TreeIndentation(
        entry: widget.entry,
        guide: const IndentGuide.connectingLines(indent: 24, color: Colors.black),
        child: SizedBox(
          height: rowHeight,
          child: Align(
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(width: 4),
                Expanded(
                  child: Focus(
                    focusNode: widget.treeRowFocusNode,
                    child:
                        (widget.editing)
                            ? TextField(
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.sentences,
                              style: getTreeText(Colors.green),
                              focusNode: widget.textFieldFocusNode,
                              maxLines: 1,
                              cursorColor: Colors.black,
                              controller: widget.textController,
                            )
                            : AutoSizeText(
                              node.name,
                              style: getTreeText(color),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                  ),
                ),
                // if (node.children.isNotEmpty)
                Align(alignment: Alignment.centerRight, child: RowMenu(node, selected)),
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

  TextStyle getTreeText(Color color) {
    if (isDesktop()) {
      return getMediumTextStyle(color);
    } else {
      return TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: color);
    }
  }
}
