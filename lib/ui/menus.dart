import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memory_notes_organizer/models/node.dart';
import 'package:menubar/menubar.dart';
import 'package:memory_notes_organizer/events/menu_events.dart';
import 'package:memory_notes_organizer/providers.dart';
import 'package:utilities/utilities.dart';

class MenuState {}

class MenuManager extends StateNotifier<MenuState> {
  final Ref ref;

  MenuManager(this.ref) : super(MenuState());

  List<PlatformMenu> createMenus() {
    return [
      createNotesMenu(),
      createFileMenu(),
      createTodosMenu(),
      createFindMenu(),
      createHelpMenu(),
    ];
  }

  void createWindowsMenus() {
    setApplicationMenu([
      createWindowsFileMenu(),
      createWindowsTodosMenu(),
      createWindowsFindMenu(),
      createWindowsHelpMenu(),
    ]);
  }

  LogicalKeyboardKey getMetaKey() =>
      isMac() ? LogicalKeyboardKey.meta : LogicalKeyboardKey.control;

  PlatformMenu createNotesMenu() {
    return PlatformMenu(
      label: 'Memory Note Organizer',
      menus: [
        PlatformMenuItem(
          label: 'Quit',
          onSelected: () => handleQuit(),
          shortcut: const SingleActivator(LogicalKeyboardKey.keyQ, meta: true),
        ),
      ],
    );
  }

  PlatformMenu createFileMenu() {
    return PlatformMenu(
      label: 'File',
      menus: [
        PlatformMenuItem(
          label: 'Open',
          onSelected: () => handleOpen(),
          shortcut: const SingleActivator(LogicalKeyboardKey.keyO, meta: true),
        ),
        PlatformMenuItem(
          label: 'Close',
          onSelected: () => handleClose(),
          shortcut: const SingleActivator(LogicalKeyboardKey.keyW, meta: true),
        ),
        PlatformMenuItemGroup(
          members: [
            PlatformMenuItem(
              label: 'Close All',
              onSelected: () => handleCloseAll(),
            ),
          ],
        ),
        PlatformMenuItemGroup(
          members: [
            // PlatformMenuItem(
            //   label: 'Import',
            //   onSelected: () => handleImport(),
            //   shortcut: const SingleActivator(
            //     LogicalKeyboardKey.keyI,
            //     meta: true,
            //   ),
            // ),
            PlatformMenuItem(
              label: 'Export',
              onSelected: () => handleExport(),
              shortcut: const SingleActivator(
                LogicalKeyboardKey.keyE,
                meta: true,
              ),
            ),
          ],
        ),
        PlatformMenuItemGroup(
          members: [
            PlatformMenuItem(label: 'Reload', onSelected: () => handleReload()),
            PlatformMenuItem(
              label: 'Log Out',
              onSelected: () => handleLogout(),
            ),
          ],
        ),
      ],
    );
  }

  NativeSubmenu createWindowsFileMenu() {
    return NativeSubmenu(
      label: 'File',
      children: [
        NativeMenuItem(
          label: 'Open',
          onSelected: () => handleOpen(),
          shortcut: LogicalKeySet(getMetaKey(), LogicalKeyboardKey.keyO),
        ),
        NativeMenuItem(
          label: 'Close',
          onSelected: () => handleClose(),
          shortcut: LogicalKeySet(getMetaKey(), LogicalKeyboardKey.keyW),
        ),
        const NativeMenuDivider(),
        NativeMenuItem(label: 'Close All', onSelected: () => handleCloseAll()),
        const NativeMenuDivider(),
        // NativeMenuItem(
        //   label: 'Import',
        //   onSelected: () => handleImport(),
        //   shortcut: LogicalKeySet(getMetaKey(), LogicalKeyboardKey.keyI),
        // ),
        NativeMenuItem(
          label: 'Export',
          onSelected: () => handleExport(),
          shortcut: LogicalKeySet(getMetaKey(), LogicalKeyboardKey.keyE),
        ),
        const NativeMenuDivider(),
        NativeMenuItem(label: 'Reload', onSelected: () => handleReload()),
        NativeMenuItem(label: 'Log Out', onSelected: () => handleLogout()),
      ],
    );
  }

  // void handleImport() async {
  //   final result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['todo'],
  //   );
  //   if (result != null) {
  //     final platformFile = result.files.first;
  //
  //     if (platformFile.path != null) {
  //       // final file = File(platformFile.path!);
  //       var name = platformFile.name;
  //       if (name.contains('.todo')) {
  //         name = name.substring(0, name.indexOf('.todo'));
  //       }
  //     }
  //   }
  // }

  PlatformMenu createTodosMenu() {
    return PlatformMenu(
      label: 'Todos',
      menus: [
        PlatformMenu(
          label: 'New',
          menus: [
            PlatformMenuItem(label: 'List', onSelected: () => newFile()),
            PlatformMenuItem(
              label: 'Category',
              onSelected: () => newCategory(),
            ),
            PlatformMenuItem(label: 'Todo', onSelected: () => newTodo()),
          ],
        ),
        PlatformMenu(
          label: 'Delete',
          menus: [
            PlatformMenuItem(label: 'List', onSelected: () => deleteFile()),
            PlatformMenuItem(
              label: 'Category',
              onSelected: () => deleteCategory(),
            ),
            PlatformMenuItem(label: 'Todo', onSelected: () => deleteTodo()),
          ],
        ),
        PlatformMenu(
          label: 'Rename',
          menus: [
            PlatformMenuItem(label: 'List', onSelected: () => renameFile()),
            PlatformMenuItem(
              label: 'Category',
              onSelected: () => renameCategory(),
            ),
            PlatformMenuItem(label: 'Todo', onSelected: () => renameTodo()),
          ],
        ),
      ],
    );
  }

  NativeSubmenu createWindowsTodosMenu() {
    return NativeSubmenu(
      label: 'Todos',
      children: [
        NativeSubmenu(
          label: 'New',
          children: [
            NativeMenuItem(label: 'List', onSelected: () => newFile()),
            NativeMenuItem(label: 'Category', onSelected: () => newCategory()),
            NativeMenuItem(label: 'Todo', onSelected: () => newTodo()),
          ],
        ),
        NativeSubmenu(
          label: 'Delete',
          children: [
            NativeMenuItem(label: 'List', onSelected: () => deleteFile()),
            NativeMenuItem(
              label: 'Category',
              onSelected: () => deleteCategory(),
            ),
            NativeMenuItem(label: 'Todo', onSelected: () => deleteTodo()),
          ],
        ),
        NativeSubmenu(
          label: 'Rename',
          children: [
            NativeMenuItem(label: 'List', onSelected: () => renameFile()),
            NativeMenuItem(
              label: 'Category',
              onSelected: () => renameCategory(),
            ),
            NativeMenuItem(label: 'Todo', onSelected: () => renameTodo()),
          ],
        ),
      ],
    );
  }

  void handleOpen() async {
    ref.read(eventBusProvider).fire(OpenFileEvent());
  }

  void handleClose() async {
    ref.read(eventBusProvider).fire(CloseCurrentFileEvent());
  }

  void handleCloseAll() async {
    ref.read(eventBusProvider).fire(CloseAllFileEvent());
  }

  void deleteTodo() {
    ref.read(eventBusProvider).fire(DeleteTodoEvent());
  }

  void deleteCategory() {
    ref.read(eventBusProvider).fire(DeleteCategoryEvent());
  }

  void deleteFile() {
    Node? node = ref.read(currentlySelectedNodeProvider);
    if (node != null) {
      ref.read(eventBusProvider).fire(DeleteFileEvent(node: node));
    }
  }

  void renameTodo() {
    ref.read(eventBusProvider).fire(RenameTodoEvent());
  }

  void renameCategory() {
    ref.read(eventBusProvider).fire(RenameCategoryEvent());
  }

  void renameFile() {
    ref.read(eventBusProvider).fire(RenameFileEvent());
  }

  void newCategory() {
    ref.read(eventBusProvider).fire(NewCategoryEvent());
  }

  void newTodo() {
    ref.read(eventBusProvider).fire(NewTodoEvent());
  }

  void newFile() {
    ref.read(eventBusProvider).fire(NewFileEvent());
  }

  PlatformMenu createFindMenu() {
    return PlatformMenu(
      label: 'Find',
      menus: [
        PlatformMenuItem(label: 'Search', onSelected: () => handleSearch()),
      ],
    );
  }

  NativeSubmenu createWindowsFindMenu() {
    return NativeSubmenu(
      label: 'Find',
      children: [
        NativeMenuItem(label: 'Search', onSelected: () => handleSearch()),
      ],
    );
  }

  void handleSearch() {
    ref.read(eventBusProvider).fire(ShowSearchEvent());
  }

  PlatformMenu createHelpMenu() {
    return PlatformMenu(
      label: 'Help',
      menus: [PlatformMenuItem(label: 'Logs', onSelected: () => handleLogs())],
    );
  }

  NativeSubmenu createWindowsHelpMenu() {
    return NativeSubmenu(
      label: 'Help',
      children: [NativeMenuItem(label: 'Logs', onSelected: () => handleLogs())],
    );
  }

  void handleLogs() {
    ref.read(eventBusProvider).fire(LogsEvent());
  }

  void handleLogout() {
    ref.read(eventBusProvider).fire(LogoutEvent());
  }

  /*
  void handleSave() async {
    final currentTodoFile = ref.read(todoRepositoryProvider).currentTodoFile;
    if (currentTodoFile != null) {
      log('Saving File');
      ref.read(firebaseProvider).writeTodoFile(currentTodoFile);
    }
  }
*/

  // void handleNew() async {
  //   final jsonString = await rootBundle.loadString('assets/todo.json');
  //   final todoFile = TodoFile.fromJson(jsonDecode(jsonString));
  //   ref.read(todoRepositoryProvider).fireTodoFile(todoFile);
  // }

  void handleExport() {
    final currentTodoFile = ref
        .read(todoRepositoryProvider)
        .currentTodoFile;
    if (currentTodoFile != null) {
      log('Exporting File');
      log(jsonEncode(currentTodoFile.toJson()));
    }
  }

  void handleReload() {
    ref.read(eventBusProvider).fire(ReloadEvent());
  }

  void handleQuit() {
    ref.read(eventBusProvider).fire(QuitEvent());
  }
}
