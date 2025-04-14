// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TodoFile {

 String get name;@JsonKey(includeIfNull: false) int? get id;@JsonKey(name: 'user_id', includeIfNull: false) String? get userId;@JsonKey(name: 'last_updated', includeIfNull: false) DateTime? get lastUpdated;@JsonKey(name: 'created_at', includeIfNull: false) DateTime? get createdAt;@JsonKey(includeFromJson: false, includeToJson: false) List<Category> get categories;
/// Create a copy of TodoFile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodoFileCopyWith<TodoFile> get copyWith => _$TodoFileCopyWithImpl<TodoFile>(this as TodoFile, _$identity);

  /// Serializes this TodoFile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoFile&&(identical(other.name, name) || other.name == name)&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.categories, categories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,id,userId,lastUpdated,createdAt,const DeepCollectionEquality().hash(categories));

@override
String toString() {
  return 'TodoFile(name: $name, id: $id, userId: $userId, lastUpdated: $lastUpdated, createdAt: $createdAt, categories: $categories)';
}


}

/// @nodoc
abstract mixin class $TodoFileCopyWith<$Res>  {
  factory $TodoFileCopyWith(TodoFile value, $Res Function(TodoFile) _then) = _$TodoFileCopyWithImpl;
@useResult
$Res call({
 String name,@JsonKey(includeIfNull: false) int? id,@JsonKey(name: 'user_id', includeIfNull: false) String? userId,@JsonKey(name: 'last_updated', includeIfNull: false) DateTime? lastUpdated,@JsonKey(name: 'created_at', includeIfNull: false) DateTime? createdAt,@JsonKey(includeFromJson: false, includeToJson: false) List<Category> categories
});




}
/// @nodoc
class _$TodoFileCopyWithImpl<$Res>
    implements $TodoFileCopyWith<$Res> {
  _$TodoFileCopyWithImpl(this._self, this._then);

  final TodoFile _self;
  final $Res Function(TodoFile) _then;

/// Create a copy of TodoFile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? id = freezed,Object? userId = freezed,Object? lastUpdated = freezed,Object? createdAt = freezed,Object? categories = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _TodoFile implements TodoFile {
  const _TodoFile({required this.name, @JsonKey(includeIfNull: false) this.id, @JsonKey(name: 'user_id', includeIfNull: false) this.userId, @JsonKey(name: 'last_updated', includeIfNull: false) this.lastUpdated, @JsonKey(name: 'created_at', includeIfNull: false) this.createdAt, @JsonKey(includeFromJson: false, includeToJson: false) this.categories = const <Category>[]});
  factory _TodoFile.fromJson(Map<String, dynamic> json) => _$TodoFileFromJson(json);

@override final  String name;
@override@JsonKey(includeIfNull: false) final  int? id;
@override@JsonKey(name: 'user_id', includeIfNull: false) final  String? userId;
@override@JsonKey(name: 'last_updated', includeIfNull: false) final  DateTime? lastUpdated;
@override@JsonKey(name: 'created_at', includeIfNull: false) final  DateTime? createdAt;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  List<Category> categories;

/// Create a copy of TodoFile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodoFileCopyWith<_TodoFile> get copyWith => __$TodoFileCopyWithImpl<_TodoFile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TodoFileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodoFile&&(identical(other.name, name) || other.name == name)&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.categories, categories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,id,userId,lastUpdated,createdAt,const DeepCollectionEquality().hash(categories));

@override
String toString() {
  return 'TodoFile(name: $name, id: $id, userId: $userId, lastUpdated: $lastUpdated, createdAt: $createdAt, categories: $categories)';
}


}

/// @nodoc
abstract mixin class _$TodoFileCopyWith<$Res> implements $TodoFileCopyWith<$Res> {
  factory _$TodoFileCopyWith(_TodoFile value, $Res Function(_TodoFile) _then) = __$TodoFileCopyWithImpl;
@override @useResult
$Res call({
 String name,@JsonKey(includeIfNull: false) int? id,@JsonKey(name: 'user_id', includeIfNull: false) String? userId,@JsonKey(name: 'last_updated', includeIfNull: false) DateTime? lastUpdated,@JsonKey(name: 'created_at', includeIfNull: false) DateTime? createdAt,@JsonKey(includeFromJson: false, includeToJson: false) List<Category> categories
});




}
/// @nodoc
class __$TodoFileCopyWithImpl<$Res>
    implements _$TodoFileCopyWith<$Res> {
  __$TodoFileCopyWithImpl(this._self, this._then);

  final _TodoFile _self;
  final $Res Function(_TodoFile) _then;

/// Create a copy of TodoFile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? id = freezed,Object? userId = freezed,Object? lastUpdated = freezed,Object? createdAt = freezed,Object? categories = null,}) {
  return _then(_TodoFile(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,
  ));
}


}


/// @nodoc
mixin _$Todo {

 bool get done; bool get visible; bool get expanded; int get order; String get name;//  ids
@JsonKey(includeIfNull: false) int? get id;// TODO: Check to makes sure this is generated as 'user_id' and not userId
@JsonKey(name: 'user_id', includeIfNull: false) String? get userId;@JsonKey(includeIfNull: false) int? get todoFileId;@JsonKey(includeIfNull: false) int? get categoryId;@JsonKey(includeIfNull: false) int? get parentTodoId; String get notes;@JsonKey(name: 'last_updated', includeIfNull: false) DateTime? get lastUpdated;@JsonKey(name: 'created_at', includeIfNull: false) DateTime? get createdAt;@JsonKey(includeFromJson: false, includeToJson: false) List<Todo> get children;
/// Create a copy of Todo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodoCopyWith<Todo> get copyWith => _$TodoCopyWithImpl<Todo>(this as Todo, _$identity);

  /// Serializes this Todo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Todo&&(identical(other.done, done) || other.done == done)&&(identical(other.visible, visible) || other.visible == visible)&&(identical(other.expanded, expanded) || other.expanded == expanded)&&(identical(other.order, order) || other.order == order)&&(identical(other.name, name) || other.name == name)&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.todoFileId, todoFileId) || other.todoFileId == todoFileId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.parentTodoId, parentTodoId) || other.parentTodoId == parentTodoId)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.children, children));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,done,visible,expanded,order,name,id,userId,todoFileId,categoryId,parentTodoId,notes,lastUpdated,createdAt,const DeepCollectionEquality().hash(children));

@override
String toString() {
  return 'Todo(done: $done, visible: $visible, expanded: $expanded, order: $order, name: $name, id: $id, userId: $userId, todoFileId: $todoFileId, categoryId: $categoryId, parentTodoId: $parentTodoId, notes: $notes, lastUpdated: $lastUpdated, createdAt: $createdAt, children: $children)';
}


}

/// @nodoc
abstract mixin class $TodoCopyWith<$Res>  {
  factory $TodoCopyWith(Todo value, $Res Function(Todo) _then) = _$TodoCopyWithImpl;
@useResult
$Res call({
 bool done, bool visible, bool expanded, int order, String name,@JsonKey(includeIfNull: false) int? id,@JsonKey(name: 'user_id', includeIfNull: false) String? userId,@JsonKey(includeIfNull: false) int? todoFileId,@JsonKey(includeIfNull: false) int? categoryId,@JsonKey(includeIfNull: false) int? parentTodoId, String notes,@JsonKey(name: 'last_updated', includeIfNull: false) DateTime? lastUpdated,@JsonKey(name: 'created_at', includeIfNull: false) DateTime? createdAt,@JsonKey(includeFromJson: false, includeToJson: false) List<Todo> children
});




}
/// @nodoc
class _$TodoCopyWithImpl<$Res>
    implements $TodoCopyWith<$Res> {
  _$TodoCopyWithImpl(this._self, this._then);

  final Todo _self;
  final $Res Function(Todo) _then;

/// Create a copy of Todo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? done = null,Object? visible = null,Object? expanded = null,Object? order = null,Object? name = null,Object? id = freezed,Object? userId = freezed,Object? todoFileId = freezed,Object? categoryId = freezed,Object? parentTodoId = freezed,Object? notes = null,Object? lastUpdated = freezed,Object? createdAt = freezed,Object? children = null,}) {
  return _then(_self.copyWith(
done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as bool,visible: null == visible ? _self.visible : visible // ignore: cast_nullable_to_non_nullable
as bool,expanded: null == expanded ? _self.expanded : expanded // ignore: cast_nullable_to_non_nullable
as bool,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,todoFileId: freezed == todoFileId ? _self.todoFileId : todoFileId // ignore: cast_nullable_to_non_nullable
as int?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,parentTodoId: freezed == parentTodoId ? _self.parentTodoId : parentTodoId // ignore: cast_nullable_to_non_nullable
as int?,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,children: null == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as List<Todo>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Todo implements Todo {
  const _Todo({this.done = false, this.visible = true, this.expanded = false, this.order = 0, required this.name, @JsonKey(includeIfNull: false) this.id, @JsonKey(name: 'user_id', includeIfNull: false) this.userId, @JsonKey(includeIfNull: false) this.todoFileId, @JsonKey(includeIfNull: false) this.categoryId, @JsonKey(includeIfNull: false) this.parentTodoId, this.notes = '', @JsonKey(name: 'last_updated', includeIfNull: false) this.lastUpdated, @JsonKey(name: 'created_at', includeIfNull: false) this.createdAt, @JsonKey(includeFromJson: false, includeToJson: false) this.children = const <Todo>[]});
  factory _Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

@override@JsonKey() final  bool done;
@override@JsonKey() final  bool visible;
@override@JsonKey() final  bool expanded;
@override@JsonKey() final  int order;
@override final  String name;
//  ids
@override@JsonKey(includeIfNull: false) final  int? id;
// TODO: Check to makes sure this is generated as 'user_id' and not userId
@override@JsonKey(name: 'user_id', includeIfNull: false) final  String? userId;
@override@JsonKey(includeIfNull: false) final  int? todoFileId;
@override@JsonKey(includeIfNull: false) final  int? categoryId;
@override@JsonKey(includeIfNull: false) final  int? parentTodoId;
@override@JsonKey() final  String notes;
@override@JsonKey(name: 'last_updated', includeIfNull: false) final  DateTime? lastUpdated;
@override@JsonKey(name: 'created_at', includeIfNull: false) final  DateTime? createdAt;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  List<Todo> children;

/// Create a copy of Todo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodoCopyWith<_Todo> get copyWith => __$TodoCopyWithImpl<_Todo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TodoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Todo&&(identical(other.done, done) || other.done == done)&&(identical(other.visible, visible) || other.visible == visible)&&(identical(other.expanded, expanded) || other.expanded == expanded)&&(identical(other.order, order) || other.order == order)&&(identical(other.name, name) || other.name == name)&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.todoFileId, todoFileId) || other.todoFileId == todoFileId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.parentTodoId, parentTodoId) || other.parentTodoId == parentTodoId)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.children, children));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,done,visible,expanded,order,name,id,userId,todoFileId,categoryId,parentTodoId,notes,lastUpdated,createdAt,const DeepCollectionEquality().hash(children));

@override
String toString() {
  return 'Todo(done: $done, visible: $visible, expanded: $expanded, order: $order, name: $name, id: $id, userId: $userId, todoFileId: $todoFileId, categoryId: $categoryId, parentTodoId: $parentTodoId, notes: $notes, lastUpdated: $lastUpdated, createdAt: $createdAt, children: $children)';
}


}

/// @nodoc
abstract mixin class _$TodoCopyWith<$Res> implements $TodoCopyWith<$Res> {
  factory _$TodoCopyWith(_Todo value, $Res Function(_Todo) _then) = __$TodoCopyWithImpl;
@override @useResult
$Res call({
 bool done, bool visible, bool expanded, int order, String name,@JsonKey(includeIfNull: false) int? id,@JsonKey(name: 'user_id', includeIfNull: false) String? userId,@JsonKey(includeIfNull: false) int? todoFileId,@JsonKey(includeIfNull: false) int? categoryId,@JsonKey(includeIfNull: false) int? parentTodoId, String notes,@JsonKey(name: 'last_updated', includeIfNull: false) DateTime? lastUpdated,@JsonKey(name: 'created_at', includeIfNull: false) DateTime? createdAt,@JsonKey(includeFromJson: false, includeToJson: false) List<Todo> children
});




}
/// @nodoc
class __$TodoCopyWithImpl<$Res>
    implements _$TodoCopyWith<$Res> {
  __$TodoCopyWithImpl(this._self, this._then);

  final _Todo _self;
  final $Res Function(_Todo) _then;

/// Create a copy of Todo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? done = null,Object? visible = null,Object? expanded = null,Object? order = null,Object? name = null,Object? id = freezed,Object? userId = freezed,Object? todoFileId = freezed,Object? categoryId = freezed,Object? parentTodoId = freezed,Object? notes = null,Object? lastUpdated = freezed,Object? createdAt = freezed,Object? children = null,}) {
  return _then(_Todo(
done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as bool,visible: null == visible ? _self.visible : visible // ignore: cast_nullable_to_non_nullable
as bool,expanded: null == expanded ? _self.expanded : expanded // ignore: cast_nullable_to_non_nullable
as bool,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,todoFileId: freezed == todoFileId ? _self.todoFileId : todoFileId // ignore: cast_nullable_to_non_nullable
as int?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,parentTodoId: freezed == parentTodoId ? _self.parentTodoId : parentTodoId // ignore: cast_nullable_to_non_nullable
as int?,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,children: null == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as List<Todo>,
  ));
}


}

// dart format on
