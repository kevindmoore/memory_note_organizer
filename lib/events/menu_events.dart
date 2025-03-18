import 'dart:io';

import 'package:memory_notes_organizer/models/todos.dart';

sealed class Event {}

class CloseCurrentFileEvent implements Event {}
class CloseAllFileEvent implements Event {}
class OpenFileEvent implements Event {}
class LoadFileEvent implements Event {
  final File file;
  final String name;

  LoadFileEvent(this.file, this.name);
}
class LogoutEvent implements Event {}
class LogsEvent implements Event {}
class NewFileEvent implements Event {}
class NewCategoryEvent implements Event {}
class NewTodoEvent implements Event {}
class DeleteTodoEvent implements Event {
  final int? todoId;

  DeleteTodoEvent([this.todoId]);

}
class RenameTodoEvent implements Event {
  final int? todoId;

  RenameTodoEvent([this.todoId]);

}
class ReloadEvent implements Event {}
class ReloadFileEvent implements Event {
  final int? fileId;

  ReloadFileEvent([this.fileId]);
}
class CloseFileEvent implements Event {
  final int? fileId;

  CloseFileEvent([this.fileId]);
}
class DuplicateFileEvent implements Event {
  final int? fileId;

  DuplicateFileEvent([this.fileId]);
}
class DeleteFileEvent implements Event {
  final int? fileId;

  DeleteFileEvent([this.fileId]);
}
class RenameFileEvent implements Event {
  final int? fileId;

  RenameFileEvent([this.fileId]);
}
class DuplicateCategoryEvent implements Event {
  final int? categoryId;

  DuplicateCategoryEvent([this.categoryId]);
}
class DeleteCategoryEvent implements Event {
  final int? categoryId;

  DeleteCategoryEvent([this.categoryId]);
}
class RenameCategoryEvent implements Event {
  final int? categoryId;

  RenameCategoryEvent([this.categoryId]);
}
class QuitEvent implements Event {}
class ShowSearchEvent implements Event {}
class TodoUpdatedEvent implements Event {
  final Todo todo;

  TodoUpdatedEvent(this.todo);
}

class TabSelectEvent implements Event {
  final int index;

  TabSelectEvent(this.index);
}