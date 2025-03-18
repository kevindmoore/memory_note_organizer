import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:memory_notes_organizer/models/models.dart';

part 'current_todo_state.freezed.dart';

part 'current_todo_state.g.dart';

@freezed
abstract class CurrentTodoState with _$CurrentTodoState {
  const factory CurrentTodoState({
    TodoFile? currentTodoFile,
    Todo? currentTodo,
    Category? currentCategory,
    @Default(-1) int currentlySelectedIndex,
  }) = _CurrentTodoState;

  factory CurrentTodoState.fromJson(Map<String, dynamic> json) =>
      _$CurrentTodoStateFromJson(json);
}
