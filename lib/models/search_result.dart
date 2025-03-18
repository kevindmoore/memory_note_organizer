import 'package:memory_notes_organizer/models/todos.dart';

import 'categories.dart';

enum SearchType { file, category, todo }

class ResultPath {
  int todoFileId;
  int? categoryId;
  int? todoId;

  ResultPath({required this.todoFileId, this.categoryId, this.todoId});

  @override
  String toString() {
    return 'todoFileId: $todoFileId categoryId: $categoryId todoId: $todoId';
  }
}

class SearchResult {
  final SearchType searchType;
  final String fullText;
  final ResultPath path;
  TodoFile? todoFile;
  Category? category;
  Todo? todo;

  SearchResult(
      {required this.searchType,
      required this.fullText,
      required this.path,
      this.todoFile,
      this.category,
      this.todo});

  @override
  String toString() {
    return 'searchType: $searchType fullText: $fullText path: $path todoFile: ${todoFile?.name} category: ${category?.name} todo: ${todo?.name}';
  }
}
