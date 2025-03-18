import 'package:freezed_annotation/freezed_annotation.dart';

part 'selection_state.freezed.dart';

@freezed
abstract class SelectionState with _$SelectionState {
  const factory SelectionState({
    @Default(null) int? todoFileId,
    @Default(-1) int fileIndex,
    @Default(null) int? categoryId,
    @Default(-1) int categoryIndex,
    @Default(null) int? todoId,
  }) = _SelectionState;

}