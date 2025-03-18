// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'categories.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Category {

 String get name;@JsonKey(includeIfNull: false) int? get id;@JsonKey(includeIfNull: false) int? get todoFileId;@JsonKey(name: 'user_id', includeIfNull: false) String? get userId;@JsonKey(name: 'last_updated', includeIfNull: false) DateTime? get lastUpdated;@JsonKey(includeFromJson: false, includeToJson: false) List<Todo> get todos;
/// Create a copy of Category
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryCopyWith<Category> get copyWith => _$CategoryCopyWithImpl<Category>(this as Category, _$identity);

  /// Serializes this Category to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Category&&(identical(other.name, name) || other.name == name)&&(identical(other.id, id) || other.id == id)&&(identical(other.todoFileId, todoFileId) || other.todoFileId == todoFileId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&const DeepCollectionEquality().equals(other.todos, todos));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,id,todoFileId,userId,lastUpdated,const DeepCollectionEquality().hash(todos));

@override
String toString() {
  return 'Category(name: $name, id: $id, todoFileId: $todoFileId, userId: $userId, lastUpdated: $lastUpdated, todos: $todos)';
}


}

/// @nodoc
abstract mixin class $CategoryCopyWith<$Res>  {
  factory $CategoryCopyWith(Category value, $Res Function(Category) _then) = _$CategoryCopyWithImpl;
@useResult
$Res call({
 String name,@JsonKey(includeIfNull: false) int? id,@JsonKey(includeIfNull: false) int? todoFileId,@JsonKey(name: 'user_id', includeIfNull: false) String? userId,@JsonKey(name: 'last_updated', includeIfNull: false) DateTime? lastUpdated,@JsonKey(includeFromJson: false, includeToJson: false) List<Todo> todos
});




}
/// @nodoc
class _$CategoryCopyWithImpl<$Res>
    implements $CategoryCopyWith<$Res> {
  _$CategoryCopyWithImpl(this._self, this._then);

  final Category _self;
  final $Res Function(Category) _then;

/// Create a copy of Category
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? id = freezed,Object? todoFileId = freezed,Object? userId = freezed,Object? lastUpdated = freezed,Object? todos = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,todoFileId: freezed == todoFileId ? _self.todoFileId : todoFileId // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,todos: null == todos ? _self.todos : todos // ignore: cast_nullable_to_non_nullable
as List<Todo>,
  ));
}

}


/// @nodoc

@JsonSerializable(explicitToJson: true)
class _Category implements Category {
  const _Category({required this.name, @JsonKey(includeIfNull: false) this.id, @JsonKey(includeIfNull: false) this.todoFileId, @JsonKey(name: 'user_id', includeIfNull: false) this.userId, @JsonKey(name: 'last_updated', includeIfNull: false) this.lastUpdated, @JsonKey(includeFromJson: false, includeToJson: false) this.todos = const <Todo>[]});
  factory _Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

@override final  String name;
@override@JsonKey(includeIfNull: false) final  int? id;
@override@JsonKey(includeIfNull: false) final  int? todoFileId;
@override@JsonKey(name: 'user_id', includeIfNull: false) final  String? userId;
@override@JsonKey(name: 'last_updated', includeIfNull: false) final  DateTime? lastUpdated;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  List<Todo> todos;

/// Create a copy of Category
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryCopyWith<_Category> get copyWith => __$CategoryCopyWithImpl<_Category>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CategoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Category&&(identical(other.name, name) || other.name == name)&&(identical(other.id, id) || other.id == id)&&(identical(other.todoFileId, todoFileId) || other.todoFileId == todoFileId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&const DeepCollectionEquality().equals(other.todos, todos));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,id,todoFileId,userId,lastUpdated,const DeepCollectionEquality().hash(todos));

@override
String toString() {
  return 'Category(name: $name, id: $id, todoFileId: $todoFileId, userId: $userId, lastUpdated: $lastUpdated, todos: $todos)';
}


}

/// @nodoc
abstract mixin class _$CategoryCopyWith<$Res> implements $CategoryCopyWith<$Res> {
  factory _$CategoryCopyWith(_Category value, $Res Function(_Category) _then) = __$CategoryCopyWithImpl;
@override @useResult
$Res call({
 String name,@JsonKey(includeIfNull: false) int? id,@JsonKey(includeIfNull: false) int? todoFileId,@JsonKey(name: 'user_id', includeIfNull: false) String? userId,@JsonKey(name: 'last_updated', includeIfNull: false) DateTime? lastUpdated,@JsonKey(includeFromJson: false, includeToJson: false) List<Todo> todos
});




}
/// @nodoc
class __$CategoryCopyWithImpl<$Res>
    implements _$CategoryCopyWith<$Res> {
  __$CategoryCopyWithImpl(this._self, this._then);

  final _Category _self;
  final $Res Function(_Category) _then;

/// Create a copy of Category
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? id = freezed,Object? todoFileId = freezed,Object? userId = freezed,Object? lastUpdated = freezed,Object? todos = null,}) {
  return _then(_Category(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,todoFileId: freezed == todoFileId ? _self.todoFileId : todoFileId // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,todos: null == todos ? _self.todos : todos // ignore: cast_nullable_to_non_nullable
as List<Todo>,
  ));
}


}

// dart format on
