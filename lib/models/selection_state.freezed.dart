// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'selection_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SelectionState {

 int? get todoFileId; int get fileIndex; int? get categoryId; int get categoryIndex; int? get todoId;
/// Create a copy of SelectionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectionStateCopyWith<SelectionState> get copyWith => _$SelectionStateCopyWithImpl<SelectionState>(this as SelectionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectionState&&(identical(other.todoFileId, todoFileId) || other.todoFileId == todoFileId)&&(identical(other.fileIndex, fileIndex) || other.fileIndex == fileIndex)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.categoryIndex, categoryIndex) || other.categoryIndex == categoryIndex)&&(identical(other.todoId, todoId) || other.todoId == todoId));
}


@override
int get hashCode => Object.hash(runtimeType,todoFileId,fileIndex,categoryId,categoryIndex,todoId);

@override
String toString() {
  return 'SelectionState(todoFileId: $todoFileId, fileIndex: $fileIndex, categoryId: $categoryId, categoryIndex: $categoryIndex, todoId: $todoId)';
}


}

/// @nodoc
abstract mixin class $SelectionStateCopyWith<$Res>  {
  factory $SelectionStateCopyWith(SelectionState value, $Res Function(SelectionState) _then) = _$SelectionStateCopyWithImpl;
@useResult
$Res call({
 int? todoFileId, int fileIndex, int? categoryId, int categoryIndex, int? todoId
});




}
/// @nodoc
class _$SelectionStateCopyWithImpl<$Res>
    implements $SelectionStateCopyWith<$Res> {
  _$SelectionStateCopyWithImpl(this._self, this._then);

  final SelectionState _self;
  final $Res Function(SelectionState) _then;

/// Create a copy of SelectionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? todoFileId = freezed,Object? fileIndex = null,Object? categoryId = freezed,Object? categoryIndex = null,Object? todoId = freezed,}) {
  return _then(_self.copyWith(
todoFileId: freezed == todoFileId ? _self.todoFileId : todoFileId // ignore: cast_nullable_to_non_nullable
as int?,fileIndex: null == fileIndex ? _self.fileIndex : fileIndex // ignore: cast_nullable_to_non_nullable
as int,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,categoryIndex: null == categoryIndex ? _self.categoryIndex : categoryIndex // ignore: cast_nullable_to_non_nullable
as int,todoId: freezed == todoId ? _self.todoId : todoId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// @nodoc


class _SelectionState implements SelectionState {
  const _SelectionState({this.todoFileId = null, this.fileIndex = -1, this.categoryId = null, this.categoryIndex = -1, this.todoId = null});
  

@override@JsonKey() final  int? todoFileId;
@override@JsonKey() final  int fileIndex;
@override@JsonKey() final  int? categoryId;
@override@JsonKey() final  int categoryIndex;
@override@JsonKey() final  int? todoId;

/// Create a copy of SelectionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectionStateCopyWith<_SelectionState> get copyWith => __$SelectionStateCopyWithImpl<_SelectionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectionState&&(identical(other.todoFileId, todoFileId) || other.todoFileId == todoFileId)&&(identical(other.fileIndex, fileIndex) || other.fileIndex == fileIndex)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.categoryIndex, categoryIndex) || other.categoryIndex == categoryIndex)&&(identical(other.todoId, todoId) || other.todoId == todoId));
}


@override
int get hashCode => Object.hash(runtimeType,todoFileId,fileIndex,categoryId,categoryIndex,todoId);

@override
String toString() {
  return 'SelectionState(todoFileId: $todoFileId, fileIndex: $fileIndex, categoryId: $categoryId, categoryIndex: $categoryIndex, todoId: $todoId)';
}


}

/// @nodoc
abstract mixin class _$SelectionStateCopyWith<$Res> implements $SelectionStateCopyWith<$Res> {
  factory _$SelectionStateCopyWith(_SelectionState value, $Res Function(_SelectionState) _then) = __$SelectionStateCopyWithImpl;
@override @useResult
$Res call({
 int? todoFileId, int fileIndex, int? categoryId, int categoryIndex, int? todoId
});




}
/// @nodoc
class __$SelectionStateCopyWithImpl<$Res>
    implements _$SelectionStateCopyWith<$Res> {
  __$SelectionStateCopyWithImpl(this._self, this._then);

  final _SelectionState _self;
  final $Res Function(_SelectionState) _then;

/// Create a copy of SelectionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? todoFileId = freezed,Object? fileIndex = null,Object? categoryId = freezed,Object? categoryIndex = null,Object? todoId = freezed,}) {
  return _then(_SelectionState(
todoFileId: freezed == todoFileId ? _self.todoFileId : todoFileId // ignore: cast_nullable_to_non_nullable
as int?,fileIndex: null == fileIndex ? _self.fileIndex : fileIndex // ignore: cast_nullable_to_non_nullable
as int,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,categoryIndex: null == categoryIndex ? _self.categoryIndex : categoryIndex // ignore: cast_nullable_to_non_nullable
as int,todoId: freezed == todoId ? _self.todoId : todoId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
