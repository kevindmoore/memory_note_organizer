import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memory_notes_organizer/providers.dart';
import 'package:memory_notes_organizer/ui/widgets/theme_panel.dart';

void showThemeDialog(BuildContext context) {
  Future.delayed(const Duration(seconds: 0), ()
  {
    if (context.mounted) {
      showDialog(
          context: context,
          builder: (context) {
            return ThemeDialog();
          });
    }
  });
}

class ThemeDialog extends ConsumerStatefulWidget {

  const ThemeDialog({super.key});

  @override
  ConsumerState createState() => _ThemeDialogState();
}

class _ThemeDialogState extends ConsumerState<ThemeDialog> {

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    return AlertDialog(
      title: const Text('Choose Theme'),
      content: SizedBox(
        width: query.size.width * 0.7,
        height: query.size.height * 0.7,
        child: ThemePanel(),
        ),
      actions: [
        TextButton(
            onPressed: () {
              final dialogState = ref.read(dialogStateProvider);
              dialogState.themeDialogShowing = false;
              Navigator.pop(context);
            },
            child: const Text('Done')),
      ],
    );
  }
}
