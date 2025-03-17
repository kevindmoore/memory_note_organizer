
import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:note_master/bloc/blocs/editor_bloc.dart';
import 'package:note_master/utils/utils.dart';
import 'package:utilities/utilities.dart';

import '../../models/todos.dart';
import '../providers.dart';
import '../viewmodels/main_screen_model.dart';

typedef TodoChangedCallback = void Function(Todo);
typedef TextChangedCallback = void Function(String);
typedef TextSelectionPosition = int Function();

const int checkActiveSeconds = 60 * 5; // 5 minutes
const int checkActiveMinutes = 5; // 5 minutes

class TodoText extends ConsumerStatefulWidget {
  final TodoChangedCallback todoChangedCallback;

  const TodoText(
      {super.key, required this.todoChangedCallback});

  @override
  ConsumerState createState() => _TodoTextState();
}

class _TodoTextState extends ConsumerState<TodoText> {
  late FocusNode todoTextFocusNode;
  late TextEditingController todoNoteTextController;
  late ScrollController scrollController;
  late MainScreenModel mainScreenModel;
  int currentScrollPosition = 0;
  int currentSearchPosition = 0;
  Todo? currentTodo;
  var savedText = '';
  var oldText = '';
  var settingTodoText = false;
  final UndoManager undoStack = UndoManager();
  Timer? timer;

  bool get hasChanged => savedText != todoNoteTextController.text;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    todoNoteTextController = TextEditingController(text: '');
    todoTextFocusNode = FocusNode();
    todoNoteTextController.addListener(() {
      if (oldText != todoNoteTextController.text && !settingTodoText) {
        undoStack
            .addUndo(UndoItem<String>(oldText, todoNoteTextController.text, _undo, _redo));
        oldText = todoNoteTextController.text;
        startTimer();
      }
    });
  }

  @override
  void dispose() {
    saveNotes();
    todoNoteTextController.dispose();
    super.dispose();
  }

  void startTimer() {
    timer ??= Timer(const Duration(minutes: checkActiveMinutes), onTimerFinished);
  }

  void cancelTimer() {
    timer?.cancel();
    timer = null;
  }

  void onTimerFinished() {
    saveNotes();
  }

  @override
  Widget build(BuildContext context) {
    mainScreenModel = ref.watch(mainScreenModelProvider);
    if (currentTodo != mainScreenModel.currentlySelectedTodo) {
      settingTodoText = true;
      saveNotes();
      currentScrollPosition = 0;
      currentTodo = mainScreenModel.currentlySelectedTodo;
      final notes = currentTodo?.notes ?? '';
      todoNoteTextController.text = notes;
      savedText = notes;
      oldText = notes;
      settingTodoText = false;
    }
    if (currentSearchPosition != currentScrollPosition) {
      currentScrollPosition = currentSearchPosition;
      todoNoteTextController.selection = TextSelection.fromPosition(
          TextPosition(offset: currentSearchPosition));
      scrollController.jumpTo(currentSearchPosition.toDouble());
    }
    return BlocListener<EditorBloc, EditorState>(
      bloc: ref.watch(editorBlocProvider),
      listener: (listenerContext, state) {
        state.maybeWhen(
            undoState: () {
              undoStack.undo();
            },
            redoState: () {
              undoStack.redo();
            },
            updatedNotesState: (notes) {
              settingTodoText = true;
              todoNoteTextController.text = notes;
              undoStack
                  .addUndo(UndoItem<String>(oldText, notes, _undo, _redo));
              oldText = notes;
              todoTextFocusNode.requestFocus();
              settingTodoText = false;
            },
            searchNoteTextState: (String searchText) {

            },
            replaceNoteTextState: (String searchText, String replaceText) {
              if (searchText.isEmpty || replaceText.isEmpty) {
                logAndShowWidgetError(ref, 'Either search or replace text is empty');
                return;
              }
              settingTodoText = true;
              oldText = todoNoteTextController.text;
              final currentNotesText = todoNoteTextController.text;
              var currentPosition = todoNoteTextController.selection.extentOffset;
              currentPosition = currentPosition == -1 ? 0 : currentPosition;
              final index = currentNotesText.indexOf(searchText, currentPosition);
              if (index != -1) {
                final updatedText = currentNotesText.replaceFirst(
                    searchText, replaceText, index);
                todoNoteTextController.text = updatedText;
                undoStack
                    .addUndo(UndoItem<String>(oldText, updatedText, _undo, _redo));
                oldText = updatedText;
                todoNoteTextController.selection = TextSelection.collapsed(offset:index + replaceText.length);
              }
              todoTextFocusNode.requestFocus();
              settingTodoText = false;
            },
            replaceAllNoteTextState: (String searchText, String replaceText) {
              if (searchText.isEmpty || replaceText.isEmpty) {
                logAndShowWidgetError(ref, 'Either search or replace text is empty');
                return;
              }
              settingTodoText = true;
              oldText = todoNoteTextController.text;
              final currentNotesText = todoNoteTextController.text;
              final currentPosition = todoNoteTextController.selection;
              var index = currentNotesText.indexOf(searchText);
              var updatedText = currentNotesText;
              final updated = index != -1;
              while (index != -1) {
                updatedText = updatedText.replaceFirst(
                    searchText, replaceText, index);
                index = updatedText.indexOf(searchText, index + replaceText.length + 1);
              }
              if (updated) {
                todoNoteTextController.text = updatedText;
                undoStack
                    .addUndo(
                    UndoItem<String>(oldText, updatedText, _undo, _redo));
                oldText = updatedText;
              }
              todoNoteTextController.selection = currentPosition;
              todoTextFocusNode.requestFocus();
              settingTodoText = false;
            },
            noState: () {},
            orElse: () {
              logMessage('event not found $state');
            });
      },
      child: TextField(
        decoration: const InputDecoration(border: InputBorder.none),
        style: getMediumTextStyle(mainScreenModel.themeColors.textColor),
        keyboardType: TextInputType.multiline,
        autofocus: true,
        maxLines: null,
        cursorColor: Colors.black,
        focusNode: todoTextFocusNode,
        controller: todoNoteTextController,
        scrollController: scrollController,
      ),
    );
  }

  void startSearch(String searchText) {
    final index = todoNoteTextController.text.indexOf(searchText, currentSearchPosition);
    if (index != -1) {
      setState(() {});
      currentSearchPosition = index + 1;
    }
  }

  void saveNotes() {
    cancelTimer();
    if (hasChanged) {
      savedText = todoNoteTextController.text;
      oldText = todoNoteTextController.text;
      if (currentTodo != null) {
        final updatedTodo = currentTodo!.copyWith(notes: todoNoteTextController.text);
        SchedulerBinding.instance.addPostFrameCallback((_) {
          widget.todoChangedCallback(
              updatedTodo);
        });
      }
    }
  }

  void _undo(String oldValue) {
    setState(() {
      settingTodoText = true;
      final oldPosition = todoNoteTextController.selection;
      todoNoteTextController.text = oldValue;
      oldText = todoNoteTextController.text;
      todoTextFocusNode.requestFocus();
      if (oldPosition.extentOffset < todoNoteTextController.text.length) {
        todoNoteTextController.selection = oldPosition;
      } else {
        todoNoteTextController.selection = TextSelection.collapsed(offset:todoNoteTextController.text.length);
      }
      settingTodoText = false;
    });
  }

  void _redo(String newValue) {
    setState(() {
      settingTodoText = true;
      final oldPosition = todoNoteTextController.selection;
      todoNoteTextController.text = newValue;
      oldText = todoNoteTextController.text;
      todoTextFocusNode.requestFocus();
      if (oldPosition.extentOffset < todoNoteTextController.text.length) {
        todoNoteTextController.selection = oldPosition;
      } else {
        todoNoteTextController.selection = TextSelection.collapsed(offset:todoNoteTextController.text.length);
      }
      settingTodoText = false;
    });
  }
}
