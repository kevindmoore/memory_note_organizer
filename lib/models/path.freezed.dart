// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'path.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TodoPath {

 String get name; String get todoId; List<TodoPath> get children; TodoPath? get parent;
/// Create a copy of TodoPath
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodoPathCopyWith<TodoPath> get copyWith => _$TodoPathCopyWithImpl<TodoPath>(this as TodoPath, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoPath&&(identical(other.name, name) || other.name == name)&&(identical(other.todoId, todoId) || other.todoId == todoId)&&const DeepCollectionEquality().equals(other.children, children)&&(identical(other.parent, parent) || other.parent == parent));
}


@override
int get hashCode => Object.hash(runtimeType,name,todoId,const DeepCollectionEquality().hash(children),parent);



}

/// @nodoc
abstract mixin class $TodoPathCopyWith<$Res>  {
  factory $TodoPathCopyWith(TodoPath value, $Res Function(TodoPath) _then) = _$TodoPathCopyWithImpl;
@useResult
$Res call({
 String name, String todoId, List<TodoPath> children, TodoPath? parent
});


$TodoPathCopyWith<$Res>? get parent;

}
/// @nodoc
class _$TodoPathCopyWithImpl<$Res>
    implements $TodoPathCopyWith<$Res> {
  _$TodoPathCopyWithImpl(this._self, this._then);

  final TodoPath _self;
  final $Res Function(TodoPath) _then;

/// Create a copy of TodoPath
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? todoId = null,Object? children = null,Object? parent = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,todoId: null == todoId ? _self.todoId : todoId // ignore: cast_nullable_to_non_nullable
as String,children: null == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as List<TodoPath>,parent: freezed == parent ? _self.parent : parent // ignore: cast_nullable_to_non_nullable
as TodoPath?,
  ));
}
/// Create a copy of TodoPath
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TodoPathCopyWith<$Res>? get parent {
    if (_self.parent == null) {
    return null;
  }

  return $TodoPathCopyWith<$Res>(_self.parent!, (value) {
    return _then(_self.copyWith(parent: value));
  });
}
}


/// @nodoc


class _TodoPath implements TodoPath {
  const _TodoPath({required this.name, required this.todoId, required final  List<TodoPath> children, this.parent}): _children = children;
  

@override final  String name;
@override final  String todoId;
 final  List<TodoPath> _children;
@override List<TodoPath> get children {
  if (_children is EqualUnmodifiableListView) return _children;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_children);
}

@override final  TodoPath? parent;

/// Create a copy of TodoPath
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodoPathCopyWith<_TodoPath> get copyWith => __$TodoPathCopyWithImpl<_TodoPath>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodoPath&&(identical(other.name, name) || other.name == name)&&(identical(other.todoId, todoId) || other.todoId == todoId)&&const DeepCollectionEquality().equals(other._children, _children)&&(identical(other.parent, parent) || other.parent == parent));
}


@override
int get hashCode => Object.hash(runtimeType,name,todoId,const DeepCollectionEquality().hash(_children),parent);



}

/// @nodoc
abstract mixin class _$TodoPathCopyWith<$Res> implements $TodoPathCopyWith<$Res> {
  factory _$TodoPathCopyWith(_TodoPath value, $Res Function(_TodoPath) _then) = __$TodoPathCopyWithImpl;
@override @useResult
$Res call({
 String name, String todoId, List<TodoPath> children, TodoPath? parent
});


@override $TodoPathCopyWith<$Res>? get parent;

}
/// @nodoc
class __$TodoPathCopyWithImpl<$Res>
    implements _$TodoPathCopyWith<$Res> {
  __$TodoPathCopyWithImpl(this._self, this._then);

  final _TodoPath _self;
  final $Res Function(_TodoPath) _then;

/// Create a copy of TodoPath
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? todoId = null,Object? children = null,Object? parent = freezed,}) {
  return _then(_TodoPath(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,todoId: null == todoId ? _self.todoId : todoId // ignore: cast_nullable_to_non_nullable
as String,children: null == children ? _self._children : children // ignore: cast_nullable_to_non_nullable
as List<TodoPath>,parent: freezed == parent ? _self.parent : parent // ignore: cast_nullable_to_non_nullable
as TodoPath?,
  ));
}

/// Create a copy of TodoPath
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TodoPathCopyWith<$Res>? get parent {
    if (_self.parent == null) {
    return null;
  }

  return $TodoPathCopyWith<$Res>(_self.parent!, (value) {
    return _then(_self.copyWith(parent: value));
  });
}
}

/// @nodoc
mixin _$CategoryPath {

 String get name; String get categoryId; List<TodoPath> get todos;
/// Create a copy of CategoryPath
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryPathCopyWith<CategoryPath> get copyWith => _$CategoryPathCopyWithImpl<CategoryPath>(this as CategoryPath, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryPath&&(identical(other.name, name) || other.name == name)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&const DeepCollectionEquality().equals(other.todos, todos));
}


@override
int get hashCode => Object.hash(runtimeType,name,categoryId,const DeepCollectionEquality().hash(todos));



}

/// @nodoc
abstract mixin class $CategoryPathCopyWith<$Res>  {
  factory $CategoryPathCopyWith(CategoryPath value, $Res Function(CategoryPath) _then) = _$CategoryPathCopyWithImpl;
@useResult
$Res call({
 String name, String categoryId, List<TodoPath> todos
});




}
/// @nodoc
class _$CategoryPathCopyWithImpl<$Res>
    implements $CategoryPathCopyWith<$Res> {
  _$CategoryPathCopyWithImpl(this._self, this._then);

  final CategoryPath _self;
  final $Res Function(CategoryPath) _then;

/// Create a copy of CategoryPath
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? categoryId = null,Object? todos = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,todos: null == todos ? _self.todos : todos // ignore: cast_nullable_to_non_nullable
as List<TodoPath>,
  ));
}

}


/// @nodoc


class _CategoryPath implements CategoryPath {
  const _CategoryPath({required this.name, required this.categoryId, required final  List<TodoPath> todos}): _todos = todos;
  

@override final  String name;
@override final  String categoryId;
 final  List<TodoPath> _todos;
@override List<TodoPath> get todos {
  if (_todos is EqualUnmodifiableListView) return _todos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_todos);
}


/// Create a copy of CategoryPath
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryPathCopyWith<_CategoryPath> get copyWith => __$CategoryPathCopyWithImpl<_CategoryPath>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryPath&&(identical(other.name, name) || other.name == name)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&const DeepCollectionEquality().equals(other._todos, _todos));
}


@override
int get hashCode => Object.hash(runtimeType,name,categoryId,const DeepCollectionEquality().hash(_todos));



}

/// @nodoc
abstract mixin class _$CategoryPathCopyWith<$Res> implements $CategoryPathCopyWith<$Res> {
  factory _$CategoryPathCopyWith(_CategoryPath value, $Res Function(_CategoryPath) _then) = __$CategoryPathCopyWithImpl;
@override @useResult
$Res call({
 String name, String categoryId, List<TodoPath> todos
});




}
/// @nodoc
class __$CategoryPathCopyWithImpl<$Res>
    implements _$CategoryPathCopyWith<$Res> {
  __$CategoryPathCopyWithImpl(this._self, this._then);

  final _CategoryPath _self;
  final $Res Function(_CategoryPath) _then;

/// Create a copy of CategoryPath
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? categoryId = null,Object? todos = null,}) {
  return _then(_CategoryPath(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,todos: null == todos ? _self._todos : todos // ignore: cast_nullable_to_non_nullable
as List<TodoPath>,
  ));
}


}

/// @nodoc
mixin _$FilePath {

 String get name; String get todoFileId; List<CategoryPath> get categories;
/// Create a copy of FilePath
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FilePathCopyWith<FilePath> get copyWith => _$FilePathCopyWithImpl<FilePath>(this as FilePath, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FilePath&&(identical(other.name, name) || other.name == name)&&(identical(other.todoFileId, todoFileId) || other.todoFileId == todoFileId)&&const DeepCollectionEquality().equals(other.categories, categories));
}


@override
int get hashCode => Object.hash(runtimeType,name,todoFileId,const DeepCollectionEquality().hash(categories));



}

/// @nodoc
abstract mixin class $FilePathCopyWith<$Res>  {
  factory $FilePathCopyWith(FilePath value, $Res Function(FilePath) _then) = _$FilePathCopyWithImpl;
@useResult
$Res call({
 String name, String todoFileId, List<CategoryPath> categories
});




}
/// @nodoc
class _$FilePathCopyWithImpl<$Res>
    implements $FilePathCopyWith<$Res> {
  _$FilePathCopyWithImpl(this._self, this._then);

  final FilePath _self;
  final $Res Function(FilePath) _then;

/// Create a copy of FilePath
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? todoFileId = null,Object? categories = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,todoFileId: null == todoFileId ? _self.todoFileId : todoFileId // ignore: cast_nullable_to_non_nullable
as String,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryPath>,
  ));
}

}


/// @nodoc


class _FilePath implements FilePath {
  const _FilePath({required this.name, required this.todoFileId, required final  List<CategoryPath> categories}): _categories = categories;
  

@override final  String name;
@override final  String todoFileId;
 final  List<CategoryPath> _categories;
@override List<CategoryPath> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}


/// Create a copy of FilePath
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FilePathCopyWith<_FilePath> get copyWith => __$FilePathCopyWithImpl<_FilePath>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FilePath&&(identical(other.name, name) || other.name == name)&&(identical(other.todoFileId, todoFileId) || other.todoFileId == todoFileId)&&const DeepCollectionEquality().equals(other._categories, _categories));
}


@override
int get hashCode => Object.hash(runtimeType,name,todoFileId,const DeepCollectionEquality().hash(_categories));



}

/// @nodoc
abstract mixin class _$FilePathCopyWith<$Res> implements $FilePathCopyWith<$Res> {
  factory _$FilePathCopyWith(_FilePath value, $Res Function(_FilePath) _then) = __$FilePathCopyWithImpl;
@override @useResult
$Res call({
 String name, String todoFileId, List<CategoryPath> categories
});




}
/// @nodoc
class __$FilePathCopyWithImpl<$Res>
    implements _$FilePathCopyWith<$Res> {
  __$FilePathCopyWithImpl(this._self, this._then);

  final _FilePath _self;
  final $Res Function(_FilePath) _then;

/// Create a copy of FilePath
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? todoFileId = null,Object? categories = null,}) {
  return _then(_FilePath(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,todoFileId: null == todoFileId ? _self.todoFileId : todoFileId // ignore: cast_nullable_to_non_nullable
as String,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryPath>,
  ));
}


}

/// @nodoc
mixin _$Path {

 String get name; String get todoId; Path? get child; Path? get parent;
/// Create a copy of Path
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PathCopyWith<Path> get copyWith => _$PathCopyWithImpl<Path>(this as Path, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Path&&(identical(other.name, name) || other.name == name)&&(identical(other.todoId, todoId) || other.todoId == todoId)&&(identical(other.child, child) || other.child == child)&&(identical(other.parent, parent) || other.parent == parent));
}


@override
int get hashCode => Object.hash(runtimeType,name,todoId,child,parent);



}

/// @nodoc
abstract mixin class $PathCopyWith<$Res>  {
  factory $PathCopyWith(Path value, $Res Function(Path) _then) = _$PathCopyWithImpl;
@useResult
$Res call({
 String name, String todoId, Path? child, Path? parent
});


$PathCopyWith<$Res>? get child;$PathCopyWith<$Res>? get parent;

}
/// @nodoc
class _$PathCopyWithImpl<$Res>
    implements $PathCopyWith<$Res> {
  _$PathCopyWithImpl(this._self, this._then);

  final Path _self;
  final $Res Function(Path) _then;

/// Create a copy of Path
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? todoId = null,Object? child = freezed,Object? parent = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,todoId: null == todoId ? _self.todoId : todoId // ignore: cast_nullable_to_non_nullable
as String,child: freezed == child ? _self.child : child // ignore: cast_nullable_to_non_nullable
as Path?,parent: freezed == parent ? _self.parent : parent // ignore: cast_nullable_to_non_nullable
as Path?,
  ));
}
/// Create a copy of Path
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PathCopyWith<$Res>? get child {
    if (_self.child == null) {
    return null;
  }

  return $PathCopyWith<$Res>(_self.child!, (value) {
    return _then(_self.copyWith(child: value));
  });
}/// Create a copy of Path
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PathCopyWith<$Res>? get parent {
    if (_self.parent == null) {
    return null;
  }

  return $PathCopyWith<$Res>(_self.parent!, (value) {
    return _then(_self.copyWith(parent: value));
  });
}
}


/// @nodoc


class _Path extends Path {
  const _Path({required this.name, required this.todoId, this.child, this.parent}): super._();
  

@override final  String name;
@override final  String todoId;
@override final  Path? child;
@override final  Path? parent;

/// Create a copy of Path
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PathCopyWith<_Path> get copyWith => __$PathCopyWithImpl<_Path>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Path&&(identical(other.name, name) || other.name == name)&&(identical(other.todoId, todoId) || other.todoId == todoId)&&(identical(other.child, child) || other.child == child)&&(identical(other.parent, parent) || other.parent == parent));
}


@override
int get hashCode => Object.hash(runtimeType,name,todoId,child,parent);



}

/// @nodoc
abstract mixin class _$PathCopyWith<$Res> implements $PathCopyWith<$Res> {
  factory _$PathCopyWith(_Path value, $Res Function(_Path) _then) = __$PathCopyWithImpl;
@override @useResult
$Res call({
 String name, String todoId, Path? child, Path? parent
});


@override $PathCopyWith<$Res>? get child;@override $PathCopyWith<$Res>? get parent;

}
/// @nodoc
class __$PathCopyWithImpl<$Res>
    implements _$PathCopyWith<$Res> {
  __$PathCopyWithImpl(this._self, this._then);

  final _Path _self;
  final $Res Function(_Path) _then;

/// Create a copy of Path
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? todoId = null,Object? child = freezed,Object? parent = freezed,}) {
  return _then(_Path(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,todoId: null == todoId ? _self.todoId : todoId // ignore: cast_nullable_to_non_nullable
as String,child: freezed == child ? _self.child : child // ignore: cast_nullable_to_non_nullable
as Path?,parent: freezed == parent ? _self.parent : parent // ignore: cast_nullable_to_non_nullable
as Path?,
  ));
}

/// Create a copy of Path
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PathCopyWith<$Res>? get child {
    if (_self.child == null) {
    return null;
  }

  return $PathCopyWith<$Res>(_self.child!, (value) {
    return _then(_self.copyWith(child: value));
  });
}/// Create a copy of Path
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PathCopyWith<$Res>? get parent {
    if (_self.parent == null) {
    return null;
  }

  return $PathCopyWith<$Res>(_self.parent!, (value) {
    return _then(_self.copyWith(parent: value));
  });
}
}

/// @nodoc
mixin _$UIPath {

 String get name; PathType get type; String? get todoFileId; String? get categoryId; String? get todoId; Path? get todoPath;
/// Create a copy of UIPath
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UIPathCopyWith<UIPath> get copyWith => _$UIPathCopyWithImpl<UIPath>(this as UIPath, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UIPath&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.todoFileId, todoFileId) || other.todoFileId == todoFileId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.todoId, todoId) || other.todoId == todoId)&&(identical(other.todoPath, todoPath) || other.todoPath == todoPath));
}


@override
int get hashCode => Object.hash(runtimeType,name,type,todoFileId,categoryId,todoId,todoPath);



}

/// @nodoc
abstract mixin class $UIPathCopyWith<$Res>  {
  factory $UIPathCopyWith(UIPath value, $Res Function(UIPath) _then) = _$UIPathCopyWithImpl;
@useResult
$Res call({
 String name, PathType type, String? todoFileId, String? categoryId, String? todoId, Path? todoPath
});


$PathCopyWith<$Res>? get todoPath;

}
/// @nodoc
class _$UIPathCopyWithImpl<$Res>
    implements $UIPathCopyWith<$Res> {
  _$UIPathCopyWithImpl(this._self, this._then);

  final UIPath _self;
  final $Res Function(UIPath) _then;

/// Create a copy of UIPath
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? type = null,Object? todoFileId = freezed,Object? categoryId = freezed,Object? todoId = freezed,Object? todoPath = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PathType,todoFileId: freezed == todoFileId ? _self.todoFileId : todoFileId // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,todoId: freezed == todoId ? _self.todoId : todoId // ignore: cast_nullable_to_non_nullable
as String?,todoPath: freezed == todoPath ? _self.todoPath : todoPath // ignore: cast_nullable_to_non_nullable
as Path?,
  ));
}
/// Create a copy of UIPath
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PathCopyWith<$Res>? get todoPath {
    if (_self.todoPath == null) {
    return null;
  }

  return $PathCopyWith<$Res>(_self.todoPath!, (value) {
    return _then(_self.copyWith(todoPath: value));
  });
}
}


/// @nodoc


class _UIPath extends UIPath {
  const _UIPath({required this.name, required this.type, this.todoFileId, this.categoryId, this.todoId, this.todoPath}): super._();
  

@override final  String name;
@override final  PathType type;
@override final  String? todoFileId;
@override final  String? categoryId;
@override final  String? todoId;
@override final  Path? todoPath;

/// Create a copy of UIPath
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UIPathCopyWith<_UIPath> get copyWith => __$UIPathCopyWithImpl<_UIPath>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UIPath&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.todoFileId, todoFileId) || other.todoFileId == todoFileId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.todoId, todoId) || other.todoId == todoId)&&(identical(other.todoPath, todoPath) || other.todoPath == todoPath));
}


@override
int get hashCode => Object.hash(runtimeType,name,type,todoFileId,categoryId,todoId,todoPath);



}

/// @nodoc
abstract mixin class _$UIPathCopyWith<$Res> implements $UIPathCopyWith<$Res> {
  factory _$UIPathCopyWith(_UIPath value, $Res Function(_UIPath) _then) = __$UIPathCopyWithImpl;
@override @useResult
$Res call({
 String name, PathType type, String? todoFileId, String? categoryId, String? todoId, Path? todoPath
});


@override $PathCopyWith<$Res>? get todoPath;

}
/// @nodoc
class __$UIPathCopyWithImpl<$Res>
    implements _$UIPathCopyWith<$Res> {
  __$UIPathCopyWithImpl(this._self, this._then);

  final _UIPath _self;
  final $Res Function(_UIPath) _then;

/// Create a copy of UIPath
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? type = null,Object? todoFileId = freezed,Object? categoryId = freezed,Object? todoId = freezed,Object? todoPath = freezed,}) {
  return _then(_UIPath(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PathType,todoFileId: freezed == todoFileId ? _self.todoFileId : todoFileId // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,todoId: freezed == todoId ? _self.todoId : todoId // ignore: cast_nullable_to_non_nullable
as String?,todoPath: freezed == todoPath ? _self.todoPath : todoPath // ignore: cast_nullable_to_non_nullable
as Path?,
  ));
}

/// Create a copy of UIPath
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PathCopyWith<$Res>? get todoPath {
    if (_self.todoPath == null) {
    return null;
  }

  return $PathCopyWith<$Res>(_self.todoPath!, (value) {
    return _then(_self.copyWith(todoPath: value));
  });
}
}

// dart format on
