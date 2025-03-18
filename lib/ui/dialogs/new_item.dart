import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memory_notes_organizer/constants.dart';
import 'package:memory_notes_organizer/providers.dart';


typedef NameCallBack = void Function(String?);

void showNewDialog(WidgetRef ref, String title, NameCallBack callBack) {
  final dialogState = ref.read(dialogStateProvider);
  if (!dialogState.newItemDialogShowing) {
    dialogState.newItemDialogShowing = true;
    showDialog(
      context: ref.read(appRouterProvider).navigatorKey.currentContext!,
      builder: (context) =>
          NewItemDialog(
            title: newTodoString,
            callBack: callBack,
          ),
    );
  }
}

class NewItemDialog extends ConsumerStatefulWidget {
  final String title;
  final NameCallBack callBack;

  const NewItemDialog({super.key, required this.title, required this.callBack});

  @override
  ConsumerState createState() => _NewItemDialogState();
}

class _NewItemDialogState extends ConsumerState<NewItemDialog> {
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyY, meta: true): oKAction,
        const SingleActivator(LogicalKeyboardKey.keyC, meta: true): cancel,
      },
      child: AlertDialog(
        title: Text(widget.title),
        content: SizedBox(
          width: 150,
          height: 80,
          child: TextField(
            // decoration: const InputDecoration(border: InputBorder.none),
            keyboardType: TextInputType.text,
            autofocus: true,
            maxLines: 1,
            cursorColor: Colors.black,
            controller: textController,
            onSubmitted: (value) {
              oKAction();
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
                oKAction();
              },
              child: const Text('New')),
        ],
      ),
    );
  }

  void cancel() {
    final dialogState = ref.read(dialogStateProvider);
    dialogState.newItemDialogShowing = false;
    Navigator.pop(context);
    widget.callBack(null);
  }

  void oKAction() {
    final dialogState = ref.read(dialogStateProvider);
    dialogState.newItemDialogShowing = false;
    Navigator.pop(context);
    widget.callBack(textController.text);
  }
}
