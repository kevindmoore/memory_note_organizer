import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utilities/utilities.dart';

import '../../../models/node.dart';

class RowMenu extends ConsumerStatefulWidget {
  // final MainFunctions mainFunctions;
  final Node childNode;
  final bool selected;
  // const RowMenu(this.mainFunctions, this.childNode, this.selected, {super.key});
  const RowMenu(this.childNode, this.selected, {super.key});

  @override
  ConsumerState<RowMenu> createState() => _RowMenuState();
}

class _RowMenuState extends ConsumerState<RowMenu> {
  @override
  Widget build(BuildContext context) {
    final menuItems = <PopupMenuEntry>[];
    if (widget.childNode.type == NodeType.file) {
      menuItems.add(PopupMenuItem(
        child: Row(
          children: [
            const Icon(Icons.close, color: Colors.black,),
            const SizedBox(
              width: 4.0,
            ),
            Text(
              'Close',
              style: mediumBlackText,
            )
          ],
        ),
        onTap: () {
          // widget.mainFunctions.closeCurrentFile();
        },
      ));
      menuItems.add(PopupMenuItem(
        child: Row(
          children: [
            const Icon(Icons.refresh, color: Colors.black,),
            const SizedBox(
              width: 4.0,
            ),
            Text(
              'Reload',
              style: mediumBlackText,
            )
          ],
        ),
        onTap: () {
          // widget.mainFunctions.reloadCurrentFile();
        },
      ));
    }
    menuItems.add(
      PopupMenuItem(
        child: Row(
          children: [
            const Icon(Icons.copy, color: Colors.black,),
            const SizedBox(
              width: 4.0,
            ),
            Text(
              'Duplicate',
              style: mediumBlackText,
            )
          ],
        ),
        onTap: () {
          // widget.mainFunctions.showNewDialog(context, 'Duplicate', (newName) {
          //   if (newName != null) {
          //     final addedItem = widget.mainFunctions.duplicate(widget.childNode, newName);
          //     widget.mainFunctions.callback.call(CallbackType.add, addedItem);
          //   }
          // });
        },
      ),
    );
    menuItems.add(
      PopupMenuItem(
        child: Row(
          children: [
            const Icon(Icons.delete, color: Colors.black,),
            const SizedBox(
              width: 4.0,
            ),
            Text(
              'Delete',
              style: mediumBlackText,
            )
          ],
        ),
        onTap: () {
          // widget.mainFunctions.showAreYouSureDialog(context, () {
          //   widget.mainFunctions.mainScreenModel.deletePath(widget.childNode);
          //   widget.mainFunctions.callback.call(CallbackType.delete, null);
          // }, null);
        },
      ),
    );
    menuItems.add(
      PopupMenuItem(
        child: Row(
          children: [
            const Icon(Icons.drive_file_rename_outline, color: Colors.black,),
            const SizedBox(
              width: 4.0,
            ),
            Text(
              'Rename',
              style: mediumBlackText,
            )
          ],
        ),
        onTap: () {
          // Navigator.pop(context);
          switch (widget.childNode.type) {
            case NodeType.file:
              // widget.mainFunctions.renameList(context);
              break;
            case NodeType.category:
              // widget.mainFunctions.renameCategory(context);
              break;
            case NodeType.todo:
              // widget.mainFunctions.renameTodo(context);
              break;
            case NodeType.root:
              break;
          }
          // widget.mainFunctions.callback.call(CallbackType.refresh, null);
        },
      ),
    );
    return PopupMenuButton(
      icon: const Icon(
        Icons.more_vert,
        // color: widget.selected
        //     ? widget.mainFunctions.mainScreenModel.themeColors.inverseTextColor
        //     : widget.mainFunctions.mainScreenModel.themeColors.textColor,
      ),
      itemBuilder: (context) => menuItems,
    );
  }
}
