import 'dart:io';

import 'package:memory_notes_organizer/models/node.dart';
import 'package:memory_notes_organizer/models/todos.dart';

sealed class Event {}

class CloseCurrentFileEvent implements Event {
  Node? node;
  CloseCurrentFileEvent({this.node});

}
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
class NewCategoryEvent implements Event {
  Node? node;
  NewCategoryEvent({this.node});
}

class NewTodoEvent implements Event {
  Node? node;

  NewTodoEvent({this.node});
}
class DeleteTodoEvent implements Event {
  Node? node;

  DeleteTodoEvent({this.node});

}
class RenameTodoEvent implements Event {
  Node? node;

  RenameTodoEvent({this.node});

}
class ReloadEvent implements Event {}
class ReloadFileEvent implements Event {
  Node? node;

  ReloadFileEvent({this.node});
}
class CloseFileEvent implements Event {
  Node? node;

  CloseFileEvent({this.node});
}
class DuplicateFileEvent implements Event {
  Node? node;

  DuplicateFileEvent({this.node});
}
class DeleteFileEvent implements Event {
  Node? node;

  DeleteFileEvent({this.node});
}
class RenameFileEvent implements Event {
  Node? node;

  RenameFileEvent({this.node});
}
class DuplicateCategoryEvent implements Event {
  Node? node;

  DuplicateCategoryEvent({this.node});
}
class DuplicateTodoEvent implements Event {
  Node? node;

  DuplicateTodoEvent({this.node});
}
class DeleteCategoryEvent implements Event {
  Node? node;

  DeleteCategoryEvent({this.node});
}
class RenameCategoryEvent implements Event {
  Node? node;

  RenameCategoryEvent({this.node});
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