import 'package:freezed_annotation/freezed_annotation.dart';

part 'current_state.freezed.dart';
part 'current_state.g.dart';

List<Map<String, dynamic>> currentStateToDatabaseJson(CurrentState currentState, String userId) {
  final currentStates = <Map<String, dynamic>>[];
  final updatedCurrentState = currentState.copyWith(userId: userId);
  currentStates.add(updatedCurrentState.toJson());
  return currentStates;
}

@freezed
abstract class CurrentState with _$CurrentState {
  @JsonSerializable(explicitToJson: true)
  const factory CurrentState({
    required String currentFiles,
    @JsonKey(includeIfNull: false)
    int? id,
    @JsonKey(name: 'user_id', includeIfNull: false) String? userId,
    @JsonKey(name: 'last_updated', includeIfNull: false) DateTime? lastUpdated,
  }) = _CurrentState;

  factory CurrentState.fromJson(Map<String, dynamic> json) =>
      _$CurrentStateFromJson(json);

}