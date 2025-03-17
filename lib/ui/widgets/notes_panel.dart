import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_master/bloc/blocs/editor_bloc.dart';
import 'package:utilities/utilities.dart';

import '../../../models/todos.dart';
import '../../providers.dart';
import '../../viewmodels/main_screen_model.dart';
import '../todo_text.dart';
import 'note_panel_search.dart';
import 'row_menu.dart';

/// This Widget holds the controls the notes panel
class NotesPanel extends ConsumerStatefulWidget {
  // final MainFunctions mainFunctions;

  // const NotesPanel(this.mainFunctions, {super.key});
  const NotesPanel({super.key});

  @override
  ConsumerState createState() => _NotesPanelState();
}

class _NotesPanelState extends ConsumerState<NotesPanel> {
  late MainScreenModel mainScreenModel;
  late TextEditingController searchTextController;
  late TextEditingController replaceTextController;
  Todo? currentTodo;
  List<FuncData> funcData = [];

  @override
  void initState() {
    super.initState();
    searchTextController = TextEditingController(text: '');
    replaceTextController = TextEditingController(text: '');
    funcData.add(FuncData(searchTextFunction, startSearch));
    funcData.add(FuncData(undoFunction, undo));
    funcData.add(FuncData(redoFunction, redo));
    funcData.add(FuncData(replaceFunction, replaceText));
    funcData.add(FuncData(replaceAllFunction, replaceAllText));
  }

  @override
  void dispose() {
    searchTextController.dispose();
    replaceTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<Todo?>(currentTodoProvider, (Todo? previous, Todo? next) {
      setState(() {
        currentTodo = mainScreenModel.currentlySelectedTodo;
      });
    });
    mainScreenModel = ref.watch(mainScreenModelProvider);
    final showTitleBar = ref.read(systemInfoProvider).showSystemTitleBar();
    if (mainScreenModel.currentlySelectedTodo == null) {
      return createEmptyNoteScreen();
    }
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              mainScreenModel.themeColors.startGradientColor,
              mainScreenModel.themeColors.endGradientColor
            ]),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (!showTitleBar)
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      flex: 1,
                      child: AutoSizeText(
                          mainScreenModel.currentlySelectedTodo!.name,
                          style: titleText,
                          maxLines: 1)),
                  const Spacer(),
                  RowMenu(
                      mainScreenModel.currentNode, false),
                ],
              ),
            if (!showTitleBar) const Divider(),
            NotePanelSearch(searchTextController, replaceTextController, funcData),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TodoText(
                    todoChangedCallback: todoUpdatedCallback,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void undo() {
    ref.read(editorBlocProvider).add(const EditorEvent.undoEvent());
  }

  void redo() {
    ref.read(editorBlocProvider).add(const EditorEvent.redoEvent());
  }

  Widget createEmptyNoteScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '⛏️',
              style: TextStyle(fontSize: 48),
            ),
            Text(
              'Pick a note to get started',
              style: titleBlackText,
            ),
          ],
        ),
      ),
    );
  }

  void startSearch(String searchText) {
    ref.read(editorBlocProvider).add(
        EditorEvent.searchNoteTextEvent(searchText));
  }

  void replaceText(String searchText, String replaceText) {
    ref.read(editorBlocProvider).add(
        EditorEvent.replaceNoteTextEvent(searchText, replaceText));
  }

  void replaceAllText(String searchText, String replaceText) {
    ref.read(editorBlocProvider).add(
        EditorEvent.replaceAllNoteTextEvent(searchText, replaceText));
  }

  void todoUpdatedCallback(Todo updatedTodo) {
    mainScreenModel.updateCurrentTodo(updatedTodo);
  }

}
