
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:utilities/utilities.dart';

typedef TextChangedListener = Function(String? newValue);

class TextEditor extends ConsumerStatefulWidget {
  final String initialText;
  final Color textColor;
  final TextChangedListener changedListener;
  final bool editing;
  const TextEditor({super.key, required this.initialText,
    required this.textColor,
    required this.editing,
    required this.changedListener,
  });

  @override
  ConsumerState createState() => _TextEditorState();

}

class _TextEditorState extends ConsumerState<TextEditor> {
  late TextEditingController textController;
  late FocusNode textFocusNode;
  bool editing = false;


  @override
  Widget build(BuildContext context) {
    if (widget.editing) {
      return Expanded(
        child: KeyboardListener(
          focusNode: textFocusNode,
          onKeyEvent: (event) {
            if (event.runtimeType == KeyDownEvent &&
                ((event.logicalKey == LogicalKeyboardKey.enter) ||
                    (event.logicalKey == LogicalKeyboardKey.escape))) {
              setState(() {
                editing = false;
                if (event.logicalKey == LogicalKeyboardKey.escape) {
                  widget.changedListener(null);
                } else {
                  widget.changedListener(textController.text);
                }
              });
            }
          },
          child: TextField(
            onSubmitted: (newValue) {
              setState(() {
                textController.text = newValue;
                widget.changedListener(textController.text);
                editing = false;
              });
            },
            autofocus: true,
            controller: textController,
            style: getMediumTextStyle(widget.textColor),
          ),
        ),
      );
    }
    return Expanded(
      child: AutoSizeText(
        textController.text,
        style: getMediumTextStyle(widget.textColor),
        maxLines: 1,
      ),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    editing = widget.editing;
    textFocusNode = FocusNode();
    textFocusNode.addListener(() {
      if (!textFocusNode.hasFocus && widget.editing) {
        setState(() {
          editing = false;
        });
      }
    });
    textController = TextEditingController(text: widget.initialText);
  }
}
