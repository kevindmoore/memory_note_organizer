import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/models.dart';
import '../../repository/todo_repository.dart';
import '../providers.dart';

typedef OpenCallBack = void Function(TodoFile?);

void showOpen(BuildContext context, TodoRepository todoRepository,
    OpenCallBack callBack) async {
  final todoFiles = await todoRepository.getTodoFiles();
  if (!context.mounted) return;
  if (todoFiles == null) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('No Files Found'),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              if (!context.mounted) return;
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
    return;
  }
  showDialog(
      context: context,
      builder: (context) {
        return OpenDialog(todoFiles: todoFiles, callBack: callBack);
      });
}

class OpenDialog extends ConsumerStatefulWidget {
  final List<TodoFile> todoFiles;
  final OpenCallBack callBack;

  const OpenDialog({super.key, required this.todoFiles, required this.callBack});

  @override
  ConsumerState createState() => _OpenDialogState();
}

class _OpenDialogState extends ConsumerState<OpenDialog> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.enter, meta: false): open,
        const SingleActivator(LogicalKeyboardKey.keyO, meta: false): open,
        const SingleActivator(LogicalKeyboardKey.keyC, meta: false): cancel,
        const SingleActivator(LogicalKeyboardKey.arrowDown, meta: false):
            selectNextRow,
        const SingleActivator(LogicalKeyboardKey.arrowUp, meta: false): selectPreviousRow,
      },
      child: Focus(
        autofocus: true,
        child: AlertDialog(
          title: const Text('Open File'),
          content: SizedBox(
            width: query.size.width * 0.7,
            height: query.size.height * 0.7,
            child: ListView.builder(
              itemCount: widget.todoFiles.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(widget.todoFiles[index].name),
                    selectedTileColor: Colors.blue,
                    selectedColor: Colors.white,
                    selected: index == selectedIndex,
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  cancel();
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  open();
                },
                child: const Text('Open')),
          ],
        ),
      ),
    );
  }

  void open() {
    final dialogState = ref.read(dialogStateProvider);
    dialogState.openDialogShowing = false;
    Navigator.pop(context);
    if (selectedIndex < widget.todoFiles.length) {
      widget.callBack(widget.todoFiles[selectedIndex]);
    } else {
      widget.callBack(null);
    }
  }

  void cancel() {
    final dialogState = ref.read(dialogStateProvider);
    dialogState.openDialogShowing = false;
    Navigator.pop(context);
    widget.callBack(null);
  }

  void selectNextRow() {
    setState(() {
      if ((selectedIndex + 1) < widget.todoFiles.length) {
        selectedIndex++;
      }
    });
  }

  void selectPreviousRow() {
    setState(() {
      if ((selectedIndex - 1) >= 0) {
        selectedIndex--;
      }
    });
  }
}
