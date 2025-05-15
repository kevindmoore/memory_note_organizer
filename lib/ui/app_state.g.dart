// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppState _$AppStateFromJson(Map<String, dynamic> json) => _AppState(
  initializing: json['initializing'] as bool? ?? true,
  networkAvailable: json['networkAvailable'] as bool? ?? true,
);

Map<String, dynamic> _$AppStateToJson(_AppState instance) => <String, dynamic>{
  'initializing': instance.initializing,
  'networkAvailable': instance.networkAvailable,
};
