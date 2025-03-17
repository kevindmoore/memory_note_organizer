// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'path.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TodoPath {
  String get name => throw _privateConstructorUsedError;
  String get todoId => throw _privateConstructorUsedError;
  List<TodoPath> get children => throw _privateConstructorUsedError;
  TodoPath? get parent => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TodoPathCopyWith<TodoPath> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoPathCopyWith<$Res> {
  factory $TodoPathCopyWith(TodoPath value, $Res Function(TodoPath) then) =
      _$TodoPathCopyWithImpl<$Res, TodoPath>;
  @useResult
  $Res call(
      {String name, String todoId, List<TodoPath> children, TodoPath? parent});

  $TodoPathCopyWith<$Res>? get parent;
}

/// @nodoc
class _$TodoPathCopyWithImpl<$Res, $Val extends TodoPath>
    implements $TodoPathCopyWith<$Res> {
  _$TodoPathCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? todoId = null,
    Object? children = null,
    Object? parent = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      todoId: null == todoId
          ? _value.todoId
          : todoId // ignore: cast_nullable_to_non_nullable
              as String,
      children: null == children
          ? _value.children
          : children // ignore: cast_nullable_to_non_nullable
              as List<TodoPath>,
      parent: freezed == parent
          ? _value.parent
          : parent // ignore: cast_nullable_to_non_nullable
              as TodoPath?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TodoPathCopyWith<$Res>? get parent {
    if (_value.parent == null) {
      return null;
    }

    return $TodoPathCopyWith<$Res>(_value.parent!, (value) {
      return _then(_value.copyWith(parent: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TodoPathImplCopyWith<$Res>
    implements $TodoPathCopyWith<$Res> {
  factory _$$TodoPathImplCopyWith(
          _$TodoPathImpl value, $Res Function(_$TodoPathImpl) then) =
      __$$TodoPathImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name, String todoId, List<TodoPath> children, TodoPath? parent});

  @override
  $TodoPathCopyWith<$Res>? get parent;
}

/// @nodoc
class __$$TodoPathImplCopyWithImpl<$Res>
    extends _$TodoPathCopyWithImpl<$Res, _$TodoPathImpl>
    implements _$$TodoPathImplCopyWith<$Res> {
  __$$TodoPathImplCopyWithImpl(
      _$TodoPathImpl _value, $Res Function(_$TodoPathImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? todoId = null,
    Object? children = null,
    Object? parent = freezed,
  }) {
    return _then(_$TodoPathImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      todoId: null == todoId
          ? _value.todoId
          : todoId // ignore: cast_nullable_to_non_nullable
              as String,
      children: null == children
          ? _value._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<TodoPath>,
      parent: freezed == parent
          ? _value.parent
          : parent // ignore: cast_nullable_to_non_nullable
              as TodoPath?,
    ));
  }
}

/// @nodoc

class _$TodoPathImpl implements _TodoPath {
  const _$TodoPathImpl(
      {required this.name,
      required this.todoId,
      required final List<TodoPath> children,
      this.parent})
      : _children = children;

  @override
  final String name;
  @override
  final String todoId;
  final List<TodoPath> _children;
  @override
  List<TodoPath> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  @override
  final TodoPath? parent;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodoPathImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.todoId, todoId) || other.todoId == todoId) &&
            const DeepCollectionEquality().equals(other._children, _children) &&
            (identical(other.parent, parent) || other.parent == parent));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, todoId,
      const DeepCollectionEquality().hash(_children), parent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoPathImplCopyWith<_$TodoPathImpl> get copyWith =>
      __$$TodoPathImplCopyWithImpl<_$TodoPathImpl>(this, _$identity);
}

abstract class _TodoPath implements TodoPath {
  const factory _TodoPath(
      {required final String name,
      required final String todoId,
      required final List<TodoPath> children,
      final TodoPath? parent}) = _$TodoPathImpl;

  @override
  String get name;
  @override
  String get todoId;
  @override
  List<TodoPath> get children;
  @override
  TodoPath? get parent;
  @override
  @JsonKey(ignore: true)
  _$$TodoPathImplCopyWith<_$TodoPathImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CategoryPath {
  String get name => throw _privateConstructorUsedError;
  String get categoryId => throw _privateConstructorUsedError;
  List<TodoPath> get todos => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CategoryPathCopyWith<CategoryPath> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryPathCopyWith<$Res> {
  factory $CategoryPathCopyWith(
          CategoryPath value, $Res Function(CategoryPath) then) =
      _$CategoryPathCopyWithImpl<$Res, CategoryPath>;
  @useResult
  $Res call({String name, String categoryId, List<TodoPath> todos});
}

/// @nodoc
class _$CategoryPathCopyWithImpl<$Res, $Val extends CategoryPath>
    implements $CategoryPathCopyWith<$Res> {
  _$CategoryPathCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? categoryId = null,
    Object? todos = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      todos: null == todos
          ? _value.todos
          : todos // ignore: cast_nullable_to_non_nullable
              as List<TodoPath>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CategoryPathImplCopyWith<$Res>
    implements $CategoryPathCopyWith<$Res> {
  factory _$$CategoryPathImplCopyWith(
          _$CategoryPathImpl value, $Res Function(_$CategoryPathImpl) then) =
      __$$CategoryPathImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String categoryId, List<TodoPath> todos});
}

/// @nodoc
class __$$CategoryPathImplCopyWithImpl<$Res>
    extends _$CategoryPathCopyWithImpl<$Res, _$CategoryPathImpl>
    implements _$$CategoryPathImplCopyWith<$Res> {
  __$$CategoryPathImplCopyWithImpl(
      _$CategoryPathImpl _value, $Res Function(_$CategoryPathImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? categoryId = null,
    Object? todos = null,
  }) {
    return _then(_$CategoryPathImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      todos: null == todos
          ? _value._todos
          : todos // ignore: cast_nullable_to_non_nullable
              as List<TodoPath>,
    ));
  }
}

/// @nodoc

class _$CategoryPathImpl implements _CategoryPath {
  const _$CategoryPathImpl(
      {required this.name,
      required this.categoryId,
      required final List<TodoPath> todos})
      : _todos = todos;

  @override
  final String name;
  @override
  final String categoryId;
  final List<TodoPath> _todos;
  @override
  List<TodoPath> get todos {
    if (_todos is EqualUnmodifiableListView) return _todos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_todos);
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryPathImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            const DeepCollectionEquality().equals(other._todos, _todos));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, categoryId,
      const DeepCollectionEquality().hash(_todos));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryPathImplCopyWith<_$CategoryPathImpl> get copyWith =>
      __$$CategoryPathImplCopyWithImpl<_$CategoryPathImpl>(this, _$identity);
}

abstract class _CategoryPath implements CategoryPath {
  const factory _CategoryPath(
      {required final String name,
      required final String categoryId,
      required final List<TodoPath> todos}) = _$CategoryPathImpl;

  @override
  String get name;
  @override
  String get categoryId;
  @override
  List<TodoPath> get todos;
  @override
  @JsonKey(ignore: true)
  _$$CategoryPathImplCopyWith<_$CategoryPathImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FilePath {
  String get name => throw _privateConstructorUsedError;
  String get todoFileId => throw _privateConstructorUsedError;
  List<CategoryPath> get categories => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FilePathCopyWith<FilePath> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilePathCopyWith<$Res> {
  factory $FilePathCopyWith(FilePath value, $Res Function(FilePath) then) =
      _$FilePathCopyWithImpl<$Res, FilePath>;
  @useResult
  $Res call({String name, String todoFileId, List<CategoryPath> categories});
}

/// @nodoc
class _$FilePathCopyWithImpl<$Res, $Val extends FilePath>
    implements $FilePathCopyWith<$Res> {
  _$FilePathCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? todoFileId = null,
    Object? categories = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      todoFileId: null == todoFileId
          ? _value.todoFileId
          : todoFileId // ignore: cast_nullable_to_non_nullable
              as String,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryPath>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FilePathImplCopyWith<$Res>
    implements $FilePathCopyWith<$Res> {
  factory _$$FilePathImplCopyWith(
          _$FilePathImpl value, $Res Function(_$FilePathImpl) then) =
      __$$FilePathImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String todoFileId, List<CategoryPath> categories});
}

/// @nodoc
class __$$FilePathImplCopyWithImpl<$Res>
    extends _$FilePathCopyWithImpl<$Res, _$FilePathImpl>
    implements _$$FilePathImplCopyWith<$Res> {
  __$$FilePathImplCopyWithImpl(
      _$FilePathImpl _value, $Res Function(_$FilePathImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? todoFileId = null,
    Object? categories = null,
  }) {
    return _then(_$FilePathImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      todoFileId: null == todoFileId
          ? _value.todoFileId
          : todoFileId // ignore: cast_nullable_to_non_nullable
              as String,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryPath>,
    ));
  }
}

/// @nodoc

class _$FilePathImpl implements _FilePath {
  const _$FilePathImpl(
      {required this.name,
      required this.todoFileId,
      required final List<CategoryPath> categories})
      : _categories = categories;

  @override
  final String name;
  @override
  final String todoFileId;
  final List<CategoryPath> _categories;
  @override
  List<CategoryPath> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilePathImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.todoFileId, todoFileId) ||
                other.todoFileId == todoFileId) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, todoFileId,
      const DeepCollectionEquality().hash(_categories));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FilePathImplCopyWith<_$FilePathImpl> get copyWith =>
      __$$FilePathImplCopyWithImpl<_$FilePathImpl>(this, _$identity);
}

abstract class _FilePath implements FilePath {
  const factory _FilePath(
      {required final String name,
      required final String todoFileId,
      required final List<CategoryPath> categories}) = _$FilePathImpl;

  @override
  String get name;
  @override
  String get todoFileId;
  @override
  List<CategoryPath> get categories;
  @override
  @JsonKey(ignore: true)
  _$$FilePathImplCopyWith<_$FilePathImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Path {
  String get name => throw _privateConstructorUsedError;
  String get todoId => throw _privateConstructorUsedError;
  Path? get child => throw _privateConstructorUsedError;
  Path? get parent => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PathCopyWith<Path> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PathCopyWith<$Res> {
  factory $PathCopyWith(Path value, $Res Function(Path) then) =
      _$PathCopyWithImpl<$Res, Path>;
  @useResult
  $Res call({String name, String todoId, Path? child, Path? parent});

  $PathCopyWith<$Res>? get child;
  $PathCopyWith<$Res>? get parent;
}

/// @nodoc
class _$PathCopyWithImpl<$Res, $Val extends Path>
    implements $PathCopyWith<$Res> {
  _$PathCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? todoId = null,
    Object? child = freezed,
    Object? parent = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      todoId: null == todoId
          ? _value.todoId
          : todoId // ignore: cast_nullable_to_non_nullable
              as String,
      child: freezed == child
          ? _value.child
          : child // ignore: cast_nullable_to_non_nullable
              as Path?,
      parent: freezed == parent
          ? _value.parent
          : parent // ignore: cast_nullable_to_non_nullable
              as Path?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PathCopyWith<$Res>? get child {
    if (_value.child == null) {
      return null;
    }

    return $PathCopyWith<$Res>(_value.child!, (value) {
      return _then(_value.copyWith(child: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PathCopyWith<$Res>? get parent {
    if (_value.parent == null) {
      return null;
    }

    return $PathCopyWith<$Res>(_value.parent!, (value) {
      return _then(_value.copyWith(parent: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PathImplCopyWith<$Res> implements $PathCopyWith<$Res> {
  factory _$$PathImplCopyWith(
          _$PathImpl value, $Res Function(_$PathImpl) then) =
      __$$PathImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String todoId, Path? child, Path? parent});

  @override
  $PathCopyWith<$Res>? get child;
  @override
  $PathCopyWith<$Res>? get parent;
}

/// @nodoc
class __$$PathImplCopyWithImpl<$Res>
    extends _$PathCopyWithImpl<$Res, _$PathImpl>
    implements _$$PathImplCopyWith<$Res> {
  __$$PathImplCopyWithImpl(_$PathImpl _value, $Res Function(_$PathImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? todoId = null,
    Object? child = freezed,
    Object? parent = freezed,
  }) {
    return _then(_$PathImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      todoId: null == todoId
          ? _value.todoId
          : todoId // ignore: cast_nullable_to_non_nullable
              as String,
      child: freezed == child
          ? _value.child
          : child // ignore: cast_nullable_to_non_nullable
              as Path?,
      parent: freezed == parent
          ? _value.parent
          : parent // ignore: cast_nullable_to_non_nullable
              as Path?,
    ));
  }
}

/// @nodoc

class _$PathImpl extends _Path {
  const _$PathImpl(
      {required this.name, required this.todoId, this.child, this.parent})
      : super._();

  @override
  final String name;
  @override
  final String todoId;
  @override
  final Path? child;
  @override
  final Path? parent;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PathImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.todoId, todoId) || other.todoId == todoId) &&
            (identical(other.child, child) || other.child == child) &&
            (identical(other.parent, parent) || other.parent == parent));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, todoId, child, parent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PathImplCopyWith<_$PathImpl> get copyWith =>
      __$$PathImplCopyWithImpl<_$PathImpl>(this, _$identity);
}

abstract class _Path extends Path {
  const factory _Path(
      {required final String name,
      required final String todoId,
      final Path? child,
      final Path? parent}) = _$PathImpl;
  const _Path._() : super._();

  @override
  String get name;
  @override
  String get todoId;
  @override
  Path? get child;
  @override
  Path? get parent;
  @override
  @JsonKey(ignore: true)
  _$$PathImplCopyWith<_$PathImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UIPath {
  String get name => throw _privateConstructorUsedError;
  PathType get type => throw _privateConstructorUsedError;
  String? get todoFileId => throw _privateConstructorUsedError;
  String? get categoryId => throw _privateConstructorUsedError;
  String? get todoId => throw _privateConstructorUsedError;
  Path? get todoPath => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UIPathCopyWith<UIPath> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UIPathCopyWith<$Res> {
  factory $UIPathCopyWith(UIPath value, $Res Function(UIPath) then) =
      _$UIPathCopyWithImpl<$Res, UIPath>;
  @useResult
  $Res call(
      {String name,
      PathType type,
      String? todoFileId,
      String? categoryId,
      String? todoId,
      Path? todoPath});

  $PathCopyWith<$Res>? get todoPath;
}

/// @nodoc
class _$UIPathCopyWithImpl<$Res, $Val extends UIPath>
    implements $UIPathCopyWith<$Res> {
  _$UIPathCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
    Object? todoFileId = freezed,
    Object? categoryId = freezed,
    Object? todoId = freezed,
    Object? todoPath = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PathType,
      todoFileId: freezed == todoFileId
          ? _value.todoFileId
          : todoFileId // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      todoId: freezed == todoId
          ? _value.todoId
          : todoId // ignore: cast_nullable_to_non_nullable
              as String?,
      todoPath: freezed == todoPath
          ? _value.todoPath
          : todoPath // ignore: cast_nullable_to_non_nullable
              as Path?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PathCopyWith<$Res>? get todoPath {
    if (_value.todoPath == null) {
      return null;
    }

    return $PathCopyWith<$Res>(_value.todoPath!, (value) {
      return _then(_value.copyWith(todoPath: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UIPathImplCopyWith<$Res> implements $UIPathCopyWith<$Res> {
  factory _$$UIPathImplCopyWith(
          _$UIPathImpl value, $Res Function(_$UIPathImpl) then) =
      __$$UIPathImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      PathType type,
      String? todoFileId,
      String? categoryId,
      String? todoId,
      Path? todoPath});

  @override
  $PathCopyWith<$Res>? get todoPath;
}

/// @nodoc
class __$$UIPathImplCopyWithImpl<$Res>
    extends _$UIPathCopyWithImpl<$Res, _$UIPathImpl>
    implements _$$UIPathImplCopyWith<$Res> {
  __$$UIPathImplCopyWithImpl(
      _$UIPathImpl _value, $Res Function(_$UIPathImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
    Object? todoFileId = freezed,
    Object? categoryId = freezed,
    Object? todoId = freezed,
    Object? todoPath = freezed,
  }) {
    return _then(_$UIPathImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PathType,
      todoFileId: freezed == todoFileId
          ? _value.todoFileId
          : todoFileId // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      todoId: freezed == todoId
          ? _value.todoId
          : todoId // ignore: cast_nullable_to_non_nullable
              as String?,
      todoPath: freezed == todoPath
          ? _value.todoPath
          : todoPath // ignore: cast_nullable_to_non_nullable
              as Path?,
    ));
  }
}

/// @nodoc

class _$UIPathImpl extends _UIPath {
  const _$UIPathImpl(
      {required this.name,
      required this.type,
      this.todoFileId,
      this.categoryId,
      this.todoId,
      this.todoPath})
      : super._();

  @override
  final String name;
  @override
  final PathType type;
  @override
  final String? todoFileId;
  @override
  final String? categoryId;
  @override
  final String? todoId;
  @override
  final Path? todoPath;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UIPathImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.todoFileId, todoFileId) ||
                other.todoFileId == todoFileId) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.todoId, todoId) || other.todoId == todoId) &&
            (identical(other.todoPath, todoPath) ||
                other.todoPath == todoPath));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, name, type, todoFileId, categoryId, todoId, todoPath);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UIPathImplCopyWith<_$UIPathImpl> get copyWith =>
      __$$UIPathImplCopyWithImpl<_$UIPathImpl>(this, _$identity);
}

abstract class _UIPath extends UIPath {
  const factory _UIPath(
      {required final String name,
      required final PathType type,
      final String? todoFileId,
      final String? categoryId,
      final String? todoId,
      final Path? todoPath}) = _$UIPathImpl;
  const _UIPath._() : super._();

  @override
  String get name;
  @override
  PathType get type;
  @override
  String? get todoFileId;
  @override
  String? get categoryId;
  @override
  String? get todoId;
  @override
  Path? get todoPath;
  @override
  @JsonKey(ignore: true)
  _$$UIPathImplCopyWith<_$UIPathImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
