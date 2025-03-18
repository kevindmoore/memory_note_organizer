import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memory_notes_organizer/models/current_todo_state.dart';
import 'package:memory_notes_organizer/providers.dart';
import 'package:utilities/utilities.dart';


typedef StartSearchCallback = void Function(String);

const String searchTextFunction = 'searchTextFunction';
const String undoFunction = 'undoFunction';
const String redoFunction = 'redoFunction';
const String replaceFunction = 'replaceFunction';
const String replaceAllFunction = 'replaceAllFunction';

/// This widget holds the search button panel
class NotePanelSearch extends ConsumerStatefulWidget {
  final TextEditingController searchTextController;
  final TextEditingController replaceTextController;
  final List<FuncData> funcData;

  const NotePanelSearch(
      this.searchTextController, this.replaceTextController, this.funcData,
      {super.key});

  @override
  ConsumerState<NotePanelSearch> createState() => _NotePanelSearchState();
}

class _NotePanelSearchState extends ConsumerState<NotePanelSearch> {

  @override
  Widget build(BuildContext context) {
    var theme = ref.read(themeProvider);
    CurrentTodoState currentTodoState = ref.watch(currentTodoStateProvider);
    return FocusTraversalGroup(
      policy: OrderedTraversalPolicy(),
      child: Column(
        children: [
          Row(mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Text(currentTodoState.currentTodo?.name ?? '',
                style: getMediumTextStyle(
                    theme.textColor))
          ]),
          Row(mainAxisSize: MainAxisSize.max, children: [
            IconButton(
              tooltip: 'Find',
              autofocus: false,
              icon: const Icon(
                Icons.find_in_page_outlined,
                color: Colors.black,
              ),
              onPressed: () {
                findFunction(widget.funcData, searchTextFunction)
                    ?.call(widget.searchTextController.text);
                final currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
            ),
            IconButton(
              tooltip: 'Clear',
              autofocus: false,
              icon: const Icon(
                Icons.cancel_outlined,
              ),
              onPressed: () {
                setState(() {
                  widget.searchTextController.clear();
                });
              },
            ),
            FocusTraversalOrder(
              order: const NumericFocusOrder(1.0),
              child: Expanded(
                  child: MouseRegion(
                cursor: SystemMouseCursors.text,
                child: TextField(
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Find Text',
                    // hintStyle: TextStyle(color: Colors.black),
                  ),
                  style: const TextStyle(color: Colors.black),
                  textInputAction: TextInputAction.done,
                  onSubmitted: (value) {
                    findFunction(widget.funcData, searchTextFunction)
                        ?.call(widget.searchTextController.text);
                  },
                  controller: widget.searchTextController,
                ),
              )),
            ),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                tooltip: 'Replace',
                autofocus: false,
                icon: const Icon(
                  Icons.find_replace_outlined,
                ),
                onPressed: () {
                  setState(() {
                    findFunction(widget.funcData, replaceFunction)?.call(
                        widget.searchTextController.text,
                        widget.replaceTextController.text);
                  });
                },
              ),
              IconButton(
                tooltip: 'Replace All',
                autofocus: false,
                icon: const Icon(
                  Icons.library_books_outlined,
                ),
                onPressed: () {
                  setState(() {
                    findFunction(widget.funcData, replaceAllFunction)?.call(
                        widget.searchTextController.text,
                        widget.replaceTextController.text);
                  });
                },
              ),
              FocusTraversalOrder(
                order: const NumericFocusOrder(2.0),
                child: Expanded(
                    child: MouseRegion(
                  cursor: SystemMouseCursors.text,
                  child: TextField(
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Replace Text',
                      // hintStyle: TextStyle(color: Colors.black),
                    ),
                    style: const TextStyle(color: Colors.black),
                    textInputAction: TextInputAction.done,
                    onSubmitted: (value) {
                      findFunction(widget.funcData, replaceFunction)?.call(
                          widget.searchTextController.text,
                          widget.replaceTextController.text);
                    },
                    controller: widget.replaceTextController,
                  ),
                )),
              ),
              IconButton(
                tooltip: 'Undo',
                autofocus: false,
                icon: const Icon(
                  Icons.undo_outlined,
                ),
                onPressed: () {
                  findFunction(widget.funcData, undoFunction)?.call();
                },
              ),
              IconButton(
                tooltip: 'Redo',
               autofocus: false,
                icon: const Icon(
                  Icons.redo_outlined,
                ),
                onPressed: () {
                  findFunction(widget.funcData, redoFunction)?.call();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

// class FieldTraversalPolicy extends FocusTraversalPolicy with DirectionalFocusTraversalPolicyMixin {
//   @override
//   Iterable<FocusNode> sortDescendants(Iterable<FocusNode> descendants, FocusNode currentNode) {
//     final List<FocusNode> sortedList = <FocusNode>[];
//
//     for (final node in descendants) {
//       if (node.runtimeType == TextField.)
//     }
//     return sortedList;
//   }
//
// }
