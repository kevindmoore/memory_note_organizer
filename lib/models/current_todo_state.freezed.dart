// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'current_todo_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CurrentTodoState {

 TodoFile? get currentTodoFile; Todo? get currentTodo; Category? get currentCategory; int get currentlySelectedIndex;
/// Create a copy of CurrentTodoState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrentTodoStateCopyWith<CurrentTodoState> get copyWith => _$CurrentTodoStateCopyWithImpl<CurrentTodoState>(this as CurrentTodoState, _$identity);

  /// Serializes this CurrentTodoState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrentTodoState&&(identical(other.currentTodoFile, currentTodoFile) || other.currentTodoFile == currentTodoFile)&&(identical(other.currentTodo, currentTodo) || other.currentTodo == currentTodo)&&(identical(other.currentCategory, currentCategory) || other.currentCategory == currentCategory)&&(identical(other.currentlySelectedIndex, currentlySelectedIndex) || other.currentlySelectedIndex == currentlySelectedIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentTodoFile,currentTodo,currentCategory,currentlySelectedIndex);

@override
String toString() {
  return 'CurrentTodoState(currentTodoFile: $currentTodoFile, currentTodo: $currentTodo, currentCategory: $currentCategory, currentlySelectedIndex: $currentlySelectedIndex)';
}


}

/// @nodoc
abstract mixin class $CurrentTodoStateCopyWith<$Res>  {
  factory $CurrentTodoStateCopyWith(CurrentTodoState value, $Res Function(CurrentTodoState) _then) = _$CurrentTodoStateCopyWithImpl;
@useResult
$Res call({
 TodoFile? currentTodoFile, Todo? currentTodo, Category? currentCategory, int currentlySelectedIndex
});


$TodoFileCopyWith<$Res>? get currentTodoFile;$TodoCopyWith<$Res>? get currentTodo;$CategoryCopyWith<$Res>? get currentCategory;

}
/// @nodoc
class _$CurrentTodoStateCopyWithImpl<$Res>
    implements $CurrentTodoStateCopyWith<$Res> {
  _$CurrentTodoStateCopyWithImpl(this._self, this._then);

  final CurrentTodoState _self;
  final $Res Function(CurrentTodoState) _then;

/// Create a copy of CurrentTodoState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentTodoFile = freezed,Object? currentTodo = freezed,Object? currentCategory = freezed,Object? currentlySelectedIndex = null,}) {
  return _then(_self.copyWith(
currentTodoFile: freezed == currentTodoFile ? _self.currentTodoFile : currentTodoFile // ignore: cast_nullable_to_non_nullable
as TodoFile?,currentTodo: freezed == currentTodo ? _self.currentTodo : currentTodo // ignore: cast_nullable_to_non_nullable
as Todo?,currentCategory: freezed == currentCategory ? _self.currentCategory : currentCategory // ignore: cast_nullable_to_non_nullable
as Category?,currentlySelectedIndex: null == currentlySelectedIndex ? _self.currentlySelectedIndex : currentlySelectedIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of CurrentTodoState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TodoFileCopyWith<$Res>? get currentTodoFile {
    if (_self.currentTodoFile == null) {
    return null;
  }

  return $TodoFileCopyWith<$Res>(_self.currentTodoFile!, (value) {
    return _then(_self.copyWith(currentTodoFile: value));
  });
}/// Create a copy of CurrentTodoState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TodoCopyWith<$Res>? get currentTodo {
    if (_self.currentTodo == null) {
    return null;
  }

  return $TodoCopyWith<$Res>(_self.currentTodo!, (value) {
    return _then(_self.copyWith(currentTodo: value));
  });
}/// Create a copy of CurrentTodoState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryCopyWith<$Res>? get currentCategory {
    if (_self.currentCategory == null) {
    return null;
  }

  return $CategoryCopyWith<$Res>(_self.currentCategory!, (value) {
    return _then(_self.copyWith(currentCategory: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _CurrentTodoState implements CurrentTodoState {
  const _CurrentTodoState({this.currentTodoFile, this.currentTodo, this.currentCategory, this.currentlySelectedIndex = -1});
  factory _CurrentTodoState.fromJson(Map<String, dynamic> json) => _$CurrentTodoStateFromJson(json);

@override final  TodoFile? currentTodoFile;
@override final  Todo? currentTodo;
@override final  Category? currentCategory;
@override@JsonKey() final  int currentlySelectedIndex;

/// Create a copy of CurrentTodoState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrentTodoStateCopyWith<_CurrentTodoState> get copyWith => __$CurrentTodoStateCopyWithImpl<_CurrentTodoState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CurrentTodoStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrentTodoState&&(identical(other.currentTodoFile, currentTodoFile) || other.currentTodoFile == currentTodoFile)&&(identical(other.currentTodo, currentTodo) || other.currentTodo == currentTodo)&&(identical(other.currentCategory, currentCategory) || other.currentCategory == currentCategory)&&(identical(other.currentlySelectedIndex, currentlySelectedIndex) || other.currentlySelectedIndex == currentlySelectedIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentTodoFile,currentTodo,currentCategory,currentlySelectedIndex);

@override
String toString() {
  return 'CurrentTodoState(currentTodoFile: $currentTodoFile, currentTodo: $currentTodo, currentCategory: $currentCategory, currentlySelectedIndex: $currentlySelectedIndex)';
}


}

/// @nodoc
abstract mixin class _$CurrentTodoStateCopyWith<$Res> implements $CurrentTodoStateCopyWith<$Res> {
  factory _$CurrentTodoStateCopyWith(_CurrentTodoState value, $Res Function(_CurrentTodoState) _then) = __$CurrentTodoStateCopyWithImpl;
@override @useResult
$Res call({
 TodoFile? currentTodoFile, Todo? currentTodo, Category? currentCategory, int currentlySelectedIndex
});


@override $TodoFileCopyWith<$Res>? get currentTodoFile;@override $TodoCopyWith<$Res>? get currentTodo;@override $CategoryCopyWith<$Res>? get currentCategory;

}
/// @nodoc
class __$CurrentTodoStateCopyWithImpl<$Res>
    implements _$CurrentTodoStateCopyWith<$Res> {
  __$CurrentTodoStateCopyWithImpl(this._self, this._then);

  final _CurrentTodoState _self;
  final $Res Function(_CurrentTodoState) _then;

/// Create a copy of CurrentTodoState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentTodoFile = freezed,Object? currentTodo = freezed,Object? currentCategory = freezed,Object? currentlySelectedIndex = null,}) {
  return _then(_CurrentTodoState(
currentTodoFile: freezed == currentTodoFile ? _self.currentTodoFile : currentTodoFile // ignore: cast_nullable_to_non_nullable
as TodoFile?,currentTodo: freezed == currentTodo ? _self.currentTodo : currentTodo // ignore: cast_nullable_to_non_nullable
as Todo?,currentCategory: freezed == currentCategory ? _self.currentCategory : currentCategory // ignore: cast_nullable_to_non_nullable
as Category?,currentlySelectedIndex: null == currentlySelectedIndex ? _self.currentlySelectedIndex : currentlySelectedIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of CurrentTodoState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TodoFileCopyWith<$Res>? get currentTodoFile {
    if (_self.currentTodoFile == null) {
    return null;
  }

  return $TodoFileCopyWith<$Res>(_self.currentTodoFile!, (value) {
    return _then(_self.copyWith(currentTodoFile: value));
  });
}/// Create a copy of CurrentTodoState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TodoCopyWith<$Res>? get currentTodo {
    if (_self.currentTodo == null) {
    return null;
  }

  return $TodoCopyWith<$Res>(_self.currentTodo!, (value) {
    return _then(_self.copyWith(currentTodo: value));
  });
}/// Create a copy of CurrentTodoState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryCopyWith<$Res>? get currentCategory {
    if (_self.currentCategory == null) {
    return null;
  }

  return $CategoryCopyWith<$Res>(_self.currentCategory!, (value) {
    return _then(_self.copyWith(currentCategory: value));
  });
}
}

// dart format on
