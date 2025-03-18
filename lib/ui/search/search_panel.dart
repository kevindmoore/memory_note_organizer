import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memory_notes_organizer/models/search_result.dart';
import 'package:memory_notes_organizer/providers.dart';
import 'package:memory_notes_organizer/todos/todo_manager.dart';
import 'package:utilities/utilities.dart';


class SearchPanel extends ConsumerStatefulWidget {
  const SearchPanel({super.key});

  @override
  ConsumerState<SearchPanel> createState() => _SearchPanelState();
}

class _SearchPanelState extends ConsumerState<SearchPanel> {
  late TextEditingController searchTextController;
  List<SearchResult> searchResults = <SearchResult>[];
  late FocusNode textFocusNode;

  @override
  void initState() {
    super.initState();
    textFocusNode = FocusNode();
    searchTextController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = ref.watch(themeProvider);
    final todoManager = ref.watch(todoManagerProvider);
    final searchText = ref.watch(searchTextStateProvider);
    searchTextController.text = searchText;
    return Container(
      decoration: createGradient(
        theme.startGradientColor,
        theme.endGradientColor,
      ),
      child:
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return CustomScrollView(slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: SizedBox(
                    width: constraints.maxWidth,
                    height: constraints.minHeight,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                startSearch(context, searchTextController.text,
                                    todoManager);
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
                                  ref.read(searchTextStateProvider.notifier).state =
                                      '';
                                  textFocusNode.requestFocus();
                                });
                              },
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                                child: TextField(
                              focusNode: textFocusNode,
                              cursorColor: Colors.black,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Find notes or folders...',
                                // hintStyle: TextStyle(color: Colors.black),
                              ),
                              // autofocus: true,
                              style: getMediumTextStyle(theme.textColor),
                              textInputAction: TextInputAction.done,
                              onSubmitted: (value) {
                                var searchText = searchTextController.text.trim();
                                ref.read(searchTextStateProvider.notifier).state =
                                    searchText;
                                startSearch(context, searchText,
                                    todoManager);
                              },
                              controller: searchTextController,
                            )),
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
              ]);
            },
          ),
        ),
    );
  }

  void startSearch(BuildContext context, String text, TodoManager todoManager) {
    final results = todoManager.search(text);
    if (results.isNotEmpty) {
      setState(() {
        searchResults = results;
      });
    }
  }

  Widget buildSearchResults() {
    var theme = ref.watch(themeProvider);
    if (searchResults.isEmpty) {
      return Flexible(
        child: Center(
          child: Text('No Results', style: getMediumTextStyle(theme.textColor)),
        ),
      );
    }
    return Flexible(
      child: ListView.builder(
          shrinkWrap: true,
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
                style: getMediumTextStyle(theme.textColor),
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
                    style: getMediumTextStyle(theme.textColor),
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
                    ref.read(searchBus).fire(result);
                  },
                ));
          }),
    );
  }
}
