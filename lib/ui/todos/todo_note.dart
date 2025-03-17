
import 'package:flutter/material.dart';
import '../../models/models.dart';

class TodoNote extends StatefulWidget {
  final Todo? todo;

  const TodoNote({super.key, this.todo});

  @override
  State createState() => _TodoNoteState();
}

class _TodoNoteState extends State<TodoNote> {
  late TextEditingController todoTextController;

  @override
  void initState() {
    super.initState();
    todoTextController =
        TextEditingController(text: (widget.todo?.notes ?? ''));
  }

  @override
  void dispose() {
    todoTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.todo == null || widget.todo?.notes == null) {
      return Container();
    }
    todoTextController.text = widget.todo?.notes ?? '';
    return Expanded(
        flex: 8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: TextField(
                  decoration: const InputDecoration(border: InputBorder.none),
                  autofocus: true,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: todoTextController,
                  style: const TextStyle(fontSize: 12)),
            ),
          ],
        ));
  }
}
