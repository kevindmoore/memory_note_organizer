import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_master/bloc/blocs/search_bloc.dart';
import 'package:note_master/models/search_result.dart';
import 'package:note_master/todos/todo_manager.dart';
import 'package:utilities/utilities.dart';

import '../providers.dart';

class SearchDialog extends ConsumerStatefulWidget {
  const SearchDialog({super.key});

  @override
  ConsumerState createState() => _SearchDialogState();
}

class _SearchDialogState extends ConsumerState<SearchDialog> {
  late TextEditingController searchTextController;
  List<SearchResult> searchResults = <SearchResult>[];
  FocusNode textFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    searchTextController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todoManager = ref.watch(todoManagerProvider);
    final searchText = ref.watch(searchTextStateProvider);
    searchTextController.text = searchText;
    final query = MediaQuery.of(context);
    final width = query.size.width * 0.7;
    final height = query.size.height * 0.7;
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(24.0, 0.0, 0.0, 24.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      content: SizedBox(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: SizedBox(
            width: width,
            height: height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        tooltip: 'Close',
                        icon: const Icon(
                          Icons.cancel_rounded,
                        ),
                        onPressed: () {
                          final dialogState = ref.read(dialogStateProvider);
                          dialogState.searchDialogShowing = false;
                          Navigator.pop(context);
                        },
                      ),
                    ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      tooltip: 'Search',
                      icon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        ref.read(searchTextStateProvider.notifier).state =
                            searchTextController.text;
                        startSearch(
                            context, searchTextController.text, todoManager);
                        final currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                      },
                    ),
                    IconButton(
                      tooltip: 'Clear',
                      icon: const Icon(
                        Icons.cancel_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          searchTextController.clear();
                          ref.read(searchTextStateProvider.notifier).state = '';
                          textFocusNode.requestFocus();
                        });
                      },
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: TextField(
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Find notes or folders...',
                          // hintStyle: TextStyle(color: Colors.black),
                        ),
                        autofocus: true,
                        focusNode: textFocusNode,
                        style: const TextStyle(color: Colors.black),
                        textInputAction: TextInputAction.done,
                        onSubmitted: (value) {
                          ref.read(searchTextStateProvider.notifier).state =
                              searchTextController.text;
                          startSearch(
                              context, searchTextController.text, todoManager);
                        },
                        controller: searchTextController,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Text('Matches', style: getMediumTextStyle(lightGreyColor)),
                const SizedBox(
                  height: 8,
                ),
                buildSearchResults(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void startSearch(BuildContext context, String text, TodoManager todoManager) {
    ref.read(searchBlocProvider).add(const SearchEvent.searchStartEvent());
    final results = todoManager.search(text);
    setState(() {
      searchResults = results;
    });
  }

  Widget buildSearchResults() {
    if (searchResults.isEmpty) {
      return const Expanded(
        child: Center(
          child: Text('No Results'),
        ),
      );
    }
    return Expanded(
      child: ListView.builder(
          itemCount: searchResults.length,
          itemBuilder: (context, index) {
            final result = searchResults[index];
            var notes = '';
            final widgets = <Widget>[];
            switch (result.searchType) {
              case SearchType.file:
                widgets.add(
                  const Icon(
                    Icons.folder,
                  ),
                );
                break;
              case SearchType.category:
                widgets.add(
                  const Icon(
                    Icons.folder,
                  ),
                );
                break;
              case SearchType.todo:
                notes = result.todo?.notes.trim() ?? '';
                widgets.add(
                  const Icon(
                    Icons.insert_drive_file_outlined,
                  ),
                );
                break;
            }
            widgets.add(const SizedBox(width: 8));
            widgets.add(
              Text(
                result.fullText,
              ),
            );
            widgets.add(const SizedBox(width: 8));
            if (notes.isNotEmpty) {
              widgets.add(const VerticalDivider(
                thickness: 1,
                width: 20,
                color: Colors.grey,
              ));
              widgets.add(
                Expanded(
                  child: Text(
                    notes,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            }
            widgets.add(const SizedBox(width: 8));

            return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: IntrinsicHeight(
                      child: Row(
                        children: widgets,
                      ),
                    ),
                  ),
                  onTap: () {
                    ref
                        .read(searchBlocProvider)
                        .add(SearchEvent.searchEventResult(result));
                    final dialogState = ref.read(dialogStateProvider);
                    dialogState.searchDialogShowing = false;
                    ref.read(searchBus).fire(result);
                    Navigator.pop(context);
                  },
                ));
          }),
    );
  }
}
