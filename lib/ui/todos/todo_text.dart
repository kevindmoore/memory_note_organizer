import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:memory_notes_organizer/models/current_todo_state.dart';
import 'package:memory_notes_organizer/models/todos.dart';
import 'package:memory_notes_organizer/providers.dart';
import 'package:utilities/utilities.dart';

typedef TodoChangedCallback = void Function(Todo);
typedef TextChangedCallback = void Function(String);
typedef TextSelectionPosition = int Function();

const int checkActiveSeconds = 60 * 5; // 5 minutes
const int checkActiveMinutes = 1; // 1 minutes

class TodoText extends ConsumerStatefulWidget {
  final TodoChangedCallback todoChangedCallback;

  const TodoText({super.key, required this.todoChangedCallback});

  @override
  ConsumerState createState() => _TodoTextState();
}

class _TodoTextState extends ConsumerState<TodoText> {
  late FocusNode todoTextFocusNode;
  late TextEditingController todoNoteTextController;
  late ScrollController scrollController;
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
        undoStack.addUndo(UndoItem<String>(oldText, todoNoteTextController.text, _undo, _redo));
        oldText = todoNoteTextController.text;
        startTimer();
      }
    });
    todoTextFocusNode.addListener(() {
      if (todoTextFocusNode.hasFocus) {
        onFocusGained();
      } else {
        onFocusLost();
      }
    });
  }

  @override
  void dispose() {
    saveNotes();
    todoNoteTextController.dispose();
    todoTextFocusNode.dispose();
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
    CurrentTodoState currentTodoState = ref.watch(currentTodoStateProvider);
    Todo? currentlySelectedTodo = currentTodoState.currentTodo;
    var theme = ref.watch(themeProvider);
    // Node? currentlySelectedNode = ref.watch(currentlySelectedNodeProvider);
    if (currentTodo != currentlySelectedTodo) {
      settingTodoText = true;
      // saveNotes();
      currentScrollPosition = 0;
      currentTodo = currentlySelectedTodo;
      final notes = currentTodo?.notes ?? '';
      todoNoteTextController.text = notes;
      savedText = notes;
      oldText = notes;
      settingTodoText = false;
    }
    if (currentSearchPosition != currentScrollPosition) {
      currentScrollPosition = currentSearchPosition;
      todoNoteTextController.selection = TextSelection.fromPosition(
        TextPosition(offset: currentSearchPosition),
      );
      scrollController.jumpTo(currentSearchPosition.toDouble());
    }
    return TextField(
      decoration: const InputDecoration(border: InputBorder.none),
      style: getMediumTextStyle(theme.textColor),
      keyboardType: TextInputType.multiline,
      // autofocus: true,
      maxLines: null,
      cursorColor: Colors.black,
      focusNode: todoTextFocusNode,
      controller: todoNoteTextController,
      scrollController: scrollController,
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
          widget.todoChangedCallback(updatedTodo);
          startTimer();
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
        todoNoteTextController.selection = TextSelection.collapsed(
          offset: todoNoteTextController.text.length,
        );
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
        todoNoteTextController.selection = TextSelection.collapsed(
          offset: todoNoteTextController.text.length,
        );
      }
      settingTodoText = false;
    });
  }

  void onFocusGained() {
    startTimer();
  }
  void onFocusLost() {
    saveNotes();
  }
}
