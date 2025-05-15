import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

part 'app_state.g.dart';

@freezed
abstract class AppState with _$AppState {
  const factory AppState({
    @Default(true) bool initializing,
    @Default(true) bool networkAvailable,
  }) = _AppState;

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);
}
