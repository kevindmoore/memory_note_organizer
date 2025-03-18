import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memory_notes_organizer/providers.dart';

class LogsDialog extends ConsumerStatefulWidget {
  const LogsDialog({super.key});

  @override
  ConsumerState createState() => _LogsDialogState();
}

class _LogsDialogState extends ConsumerState<LogsDialog> {
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
    final query = MediaQuery.of(context);
    final entries = ref.read(logProvider).logEntries;
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyO, meta: true): oKAction,
      },
      child: AlertDialog(
        title: const Text('Logs'),
        content: SizedBox(
          width: query.size.width * 0.7,
          height: query.size.height * 0.7,
          child: ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(entries[index]),
                );
              }),
        ),
        actions: [
          TextButton(
              onPressed: () {
                oKAction();
              },
              child: const Text('OK')),
        ],
      ),
    );
  }

  void oKAction() {
    final dialogState = ref.read(dialogStateProvider);
    dialogState.logsDialogShowing = false;
    Navigator.pop(context);
  }
}
