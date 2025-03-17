import 'package:freezed_annotation/freezed_annotation.dart';

part 'path.freezed.dart';

enum PathType { file, category, todo }

@freezed
class TodoPath with _$TodoPath {
  const factory TodoPath({
    required String name,
    required String todoId,
    required List<TodoPath> children,
    TodoPath? parent,
  }) = _TodoPath;

  @override
  String toString() {
    return 'TodoPath(todo: $todoId, children: $children, parent: ${parent?.todoId}';
  }
}

@freezed
class CategoryPath with _$CategoryPath {
  const factory CategoryPath(
      {
        required String name,
        required String categoryId,
      required List<TodoPath> todos}) = _CategoryPath;

  @override
  String toString() {
    return 'CategoryPath(category: $categoryId, todos: $todos';
  }
}

@freezed
class FilePath with _$FilePath {
  const factory FilePath(
      {
        required String name,
        required String todoFileId,
      required List<CategoryPath> categories}) = _FilePath;

  @override
  String toString() {
    return 'FilePath(todoFile: $todoFileId, categories: $categories)';
  }
}

@freezed
class Path with _$Path {
  const Path._();

  const factory Path({
    required String name,
    required String todoId,
    Path? child,
    Path? parent,
  }) = _Path;

  @override
  String toString() {
    return 'Path(todo: $todoId child: $child parent: $parent';
  }
}

@freezed
class UIPath with _$UIPath {
  const UIPath._();

  const factory UIPath({
    required String name,
    required PathType type,
    String? todoFileId,
    String? categoryId,
    String? todoId,
    Path? todoPath,
  }) = _UIPath;

/*
  String toPath() {
    var pathString = '';
    if (todoFile != null) {
      pathString += todoFile!.name + ' / ';
    }
    if (category != null) {
      pathString += category!.name + ' / ';
    }
    var currentPath = todoPath;
    while (currentPath != null) {
      pathString += currentPath.todoId + ' / ';
      currentPath = currentPath.child;
    }
    return pathString;
  }

*/
  String getId() {
    switch (type) {
      case PathType.file:
        if (todoFileId != null) {
          return todoFileId!;
        } else {
          return name;
        }
      case PathType.category:
        if (categoryId != null) {
          return categoryId!;
        } else {
          return name;
        }
      case PathType.todo:
        if (todoPath?.todoId != null) {
          return todoPath!.todoId;
        } else {
          return name;
        }
    }
  }

  @override
  String toString() {
    return 'UIPath(name: $name, type: $type todoFile: $todoFileId category: $categoryId todoPath: $todoPath';
  }
}
