import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../main/main_functions.dart';
import '../providers.dart';

void showThemeDialog(BuildContext context, MainFunctions mainFunctions) {
  Future.delayed(const Duration(seconds: 0), ()
  {
    if (context.mounted) {
      showDialog(
          context: context,
          builder: (context) {
            return ThemeDialog(mainFunctions: mainFunctions);
          });
    }
  });
}

class ThemeDialog extends ConsumerStatefulWidget {
  final MainFunctions mainFunctions;

  const ThemeDialog({super.key, required this.mainFunctions});

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
        child: widget.mainFunctions.createThemePanel(),
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
