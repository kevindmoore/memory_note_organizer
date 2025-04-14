
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memory_notes_organizer/providers.dart';

typedef NewNameCallBack = void Function(String?);

void showRenameDialog(Ref ref, String title, NewNameCallBack callBack) {
  final dialogState = ref.read(dialogStateProvider);
  if (!dialogState.renameDialogShowing) {
    dialogState.renameDialogShowing = true;
    showDialog(
      context: ref.read(appRouterProvider).navigatorKey.currentContext!,
      builder: (context) =>
          RenameDialog(
            title: title,
            callBack: callBack,
          ),
    );
  }
}

class RenameDialog extends ConsumerStatefulWidget {
  final String title;
  final NewNameCallBack callBack;

  const RenameDialog({super.key, required this.title, required this.callBack});

  @override
  ConsumerState<RenameDialog> createState() => _RenameDialogState();
}

class _RenameDialogState extends ConsumerState<RenameDialog> {
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
        const SingleActivator(LogicalKeyboardKey.keyR, meta: true): oKAction,
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
            textCapitalization: TextCapitalization.sentences,
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
              child: const Text('Cancel \u{2318}+C')),
          TextButton(
              onPressed: () {
                oKAction();
              },
              child: const Text('Rename \u{2318}+R')),
        ],
      ),
    );
  }

  void cancel() {
    final dialogState = ref.read(dialogStateProvider);
    dialogState.renameDialogShowing = false;
    Navigator.pop(context);
    widget.callBack(null);
  }

  void oKAction() {
    final dialogState = ref.read(dialogStateProvider);
    dialogState.renameDialogShowing = false;
    Navigator.pop(context);
    widget.callBack(textController.text.trim());
  }
}
