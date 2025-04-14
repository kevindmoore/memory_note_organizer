import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memory_notes_organizer/events/menu_events.dart';
import 'package:memory_notes_organizer/providers.dart';
import 'package:utilities/utilities.dart';

import '../../../models/node.dart';

class RowMenu extends ConsumerStatefulWidget {
  final Node childNode;
  final bool selected;

  const RowMenu(this.childNode, this.selected, {super.key});

  @override
  ConsumerState<RowMenu> createState() => _RowMenuState();
}

class _RowMenuState extends ConsumerState<RowMenu> {
  @override
  Widget build(BuildContext context) {
    final menuItems = <PopupMenuEntry>[];

    // File
    if (widget.childNode.type == NodeType.file) {
      menuItems.add(
        buildMenuRow(
          text: 'Close',
          icon: Icons.close,
          onTap: () {
            getMenuBus().fire(CloseCurrentFileEvent());
          },
        ),
      );
      menuItems.add(
        buildMenuRow(
          text: 'Reload',
          icon: Icons.refresh,
          onTap: () {
            getMenuBus().fire(ReloadFileEvent(node: widget.childNode));
          },
        ),
      );
      menuItems.add(
        buildMenuRow(
          text: 'New Category',
          icon: Icons.add,
          onTap: () {
            getMenuBus().fire(NewCategoryEvent(node: widget.childNode));
          },
        ),
      );
    } else if (widget.childNode.type == NodeType.category) {
      menuItems.add(
        buildMenuRow(
          text: 'New Todo',
          icon: Icons.add,
          onTap: () {
            getMenuBus().fire(NewTodoEvent(node: widget.childNode));
          },
        ),
      );
    } else if (widget.childNode.type == NodeType.todo) {
      menuItems.add(
        buildMenuRow(
          text: 'New Todo',
          icon: Icons.add,
          onTap: () {
            getMenuBus().fire(NewTodoEvent(node: widget.childNode));
          },
        ),
      );
    }
    menuItems.add(
      buildMenuRow(
        text: 'Duplicate',
        icon: Icons.copy,
        onTap: () {
          if (widget.childNode.type == NodeType.file) {
            getMenuBus().fire(DuplicateFileEvent(node: widget.childNode));
          } else if (widget.childNode.type == NodeType.category) {
            getMenuBus().fire(DuplicateCategoryEvent(node: widget.childNode));
          } else if (widget.childNode.type == NodeType.todo) {
            getMenuBus().fire(DuplicateTodoEvent(node: widget.childNode));
          }
        },
      ),
    );
    menuItems.add(
      buildMenuRow(
        text: 'Delete',
        icon: Icons.delete,
        onTap: () {
          if (widget.childNode.type == NodeType.file) {
            getMenuBus().fire(DeleteFileEvent(node: widget.childNode));
          } else if (widget.childNode.type == NodeType.category) {
            getMenuBus().fire(DeleteCategoryEvent(node: widget.childNode));
          } else if (widget.childNode.type == NodeType.todo) {
            getMenuBus().fire(DeleteTodoEvent(node: widget.childNode));
          }
        },
      ),
    );
    menuItems.add(
      buildMenuRow(
        text: 'Rename',
        icon: Icons.drive_file_rename_outline,
        onTap: () {
          switch (widget.childNode.type) {
            case NodeType.file:
              getMenuBus().fire(RenameFileEvent(node: widget.childNode));
              break;
            case NodeType.category:
              getMenuBus().fire(RenameCategoryEvent(node: widget.childNode));
              break;
            case NodeType.todo:
              getMenuBus().fire(RenameTodoEvent(node: widget.childNode));
              break;
            case NodeType.root:
              break;
          }
        },
      ),
    );
    return PopupMenuButton(
      menuPadding: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      icon: const Icon(Icons.more_vert),
      itemBuilder: (context) => menuItems,
    );
  }

  PopupMenuItem buildMenuRow({
    required String text,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return PopupMenuItem(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          const SizedBox(width: 4.0),
          Text(text, style: mediumBlackText),
        ],
      ),
    );
  }
}
