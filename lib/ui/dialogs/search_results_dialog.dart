
import 'package:flutter/material.dart';

import '../../models/search_result.dart';

typedef ResultCallback = Function(SearchResult);

class SearchResultsDialog extends StatefulWidget {
  final List<SearchResult> results;
  final ResultCallback callback;

  const SearchResultsDialog(
      {super.key, required this.results, required this.callback});

  @override
  State createState() => _SearchResultsDialogState();
}

class _SearchResultsDialogState extends State<SearchResultsDialog> {
  var selectedIndex = 0;
  List<bool> _selected = [];
  final WidgetStateProperty<Color?> defaultRowColor = WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.blue.withAlpha(204);
      }
      return null;
    },
  );


  @override
  void initState() {
    super.initState();
    _selected = List<bool>.generate(widget.results.length, (int index) => false);
  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    return AlertDialog(
      title: const Text('Search Results'),
      content: SizedBox(
        width: query.size.width * 0.7,
        height: query.size.height * 0.7,
        child: SingleChildScrollView(
          child: DataTable(
              showCheckboxColumn: false,
              border: TableBorder.all(),
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'Text',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'File',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Category',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Todo',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ],
              rows: buildTableRows(widget.results)),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel')),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (selectedIndex < widget.results.length) {
                widget.callback(widget.results[selectedIndex]);
              }
            },
            child: const Text('Go To')),
      ],
    );
  }

  List<DataRow> buildTableRows(List<SearchResult> results) {
    final rows = <DataRow>[];

    results.asMap().forEach((index, result) {
      final children = <DataCell>[];
      children.add(DataCell(Text(result.fullText)));
      if (result.todoFile != null) {
        children.add(DataCell(Text(result.todoFile!.name),));
      }
      if (result.category != null) {
        children.add(DataCell(Text(result.category!.name)));
      }
      if (result.todo != null) {
        children.add(DataCell(Text(result.todo!.name)));
      }
      rows.add(DataRow(
        cells: children,
        selected: _selected[index],
        color: defaultRowColor,
        onSelectChanged: (bool? selected) {
          setState(() {
            // only 1 can be selected
            _selected = List<bool>.generate(widget.results.length, (int index) => false);
            _selected[index] = selected!;
            selectedIndex = index;
          });
        },
      ));
    });
    return rows;
  }
}
