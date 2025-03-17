// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TodoFile _$TodoFileFromJson(Map<String, dynamic> json) {
  return _TodoFile.fromJson(json);
}

/// @nodoc
mixin _$TodoFile {
  String get name => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  @JsonKey(name: 'user_id', includeIfNull: false)
  String? get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_updated', includeIfNull: false)
  DateTime? get lastUpdated => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<Category> get categories => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TodoFileCopyWith<TodoFile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoFileCopyWith<$Res> {
  factory $TodoFileCopyWith(TodoFile value, $Res Function(TodoFile) then) =
      _$TodoFileCopyWithImpl<$Res, TodoFile>;
  @useResult
  $Res call(
      {String name,
      @JsonKey(includeIfNull: false) int? id,
      @JsonKey(includeIfNull: false)
      @JsonKey(name: 'user_id', includeIfNull: false)
      String? userId,
      @JsonKey(name: 'last_updated', includeIfNull: false)
      DateTime? lastUpdated,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<Category> categories});
}

/// @nodoc
class _$TodoFileCopyWithImpl<$Res, $Val extends TodoFile>
    implements $TodoFileCopyWith<$Res> {
  _$TodoFileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = freezed,
    Object? userId = freezed,
    Object? lastUpdated = freezed,
    Object? categories = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<Category>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TodoFileImplCopyWith<$Res>
    implements $TodoFileCopyWith<$Res> {
  factory _$$TodoFileImplCopyWith(
          _$TodoFileImpl value, $Res Function(_$TodoFileImpl) then) =
      __$$TodoFileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      @JsonKey(includeIfNull: false) int? id,
      @JsonKey(includeIfNull: false)
      @JsonKey(name: 'user_id', includeIfNull: false)
      String? userId,
      @JsonKey(name: 'last_updated', includeIfNull: false)
      DateTime? lastUpdated,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<Category> categories});
}

/// @nodoc
class __$$TodoFileImplCopyWithImpl<$Res>
    extends _$TodoFileCopyWithImpl<$Res, _$TodoFileImpl>
    implements _$$TodoFileImplCopyWith<$Res> {
  __$$TodoFileImplCopyWithImpl(
      _$TodoFileImpl _value, $Res Function(_$TodoFileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = freezed,
    Object? userId = freezed,
    Object? lastUpdated = freezed,
    Object? categories = null,
  }) {
    return _then(_$TodoFileImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<Category>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$TodoFileImpl implements _TodoFile {
  const _$TodoFileImpl(
      {required this.name,
      @JsonKey(includeIfNull: false) this.id,
      @JsonKey(includeIfNull: false)
      @JsonKey(name: 'user_id', includeIfNull: false)
      this.userId,
      @JsonKey(name: 'last_updated', includeIfNull: false) this.lastUpdated,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.categories = const <Category>[]});

  factory _$TodoFileImpl.fromJson(Map<String, dynamic> json) =>
      _$$TodoFileImplFromJson(json);

  @override
  final String name;
  @override
  @JsonKey(includeIfNull: false)
  final int? id;
  @override
  @JsonKey(includeIfNull: false)
  @JsonKey(name: 'user_id', includeIfNull: false)
  final String? userId;
  @override
  @JsonKey(name: 'last_updated', includeIfNull: false)
  final DateTime? lastUpdated;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final List<Category> categories;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodoFileImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            const DeepCollectionEquality()
                .equals(other.categories, categories));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, id, userId, lastUpdated,
      const DeepCollectionEquality().hash(categories));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoFileImplCopyWith<_$TodoFileImpl> get copyWith =>
      __$$TodoFileImplCopyWithImpl<_$TodoFileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TodoFileImplToJson(
      this,
    );
  }
}

abstract class _TodoFile implements TodoFile {
  const factory _TodoFile(
      {required final String name,
      @JsonKey(includeIfNull: false) final int? id,
      @JsonKey(includeIfNull: false)
      @JsonKey(name: 'user_id', includeIfNull: false)
      final String? userId,
      @JsonKey(name: 'last_updated', includeIfNull: false)
      final DateTime? lastUpdated,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final List<Category> categories}) = _$TodoFileImpl;

  factory _TodoFile.fromJson(Map<String, dynamic> json) =
      _$TodoFileImpl.fromJson;

  @override
  String get name;
  @override
  @JsonKey(includeIfNull: false)
  int? get id;
  @override
  @JsonKey(includeIfNull: false)
  @JsonKey(name: 'user_id', includeIfNull: false)
  String? get userId;
  @override
  @JsonKey(name: 'last_updated', includeIfNull: false)
  DateTime? get lastUpdated;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<Category> get categories;
  @override
  @JsonKey(ignore: true)
  _$$TodoFileImplCopyWith<_$TodoFileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Todo _$TodoFromJson(Map<String, dynamic> json) {
  return _Todo.fromJson(json);
}

/// @nodoc
mixin _$Todo {
/*
    DateTime? startDate,
    DateTime? endDate,
    DateTime? dateFinished,
    @Default(STATUS.NOT_STARTED) STATUS status,
    @Default(PRIORITY.LOW) PRIORITY priority,

*/
// List<UserField> userFields = <UserField>[];
// Category parent;
  bool get done => throw _privateConstructorUsedError;
  bool get visible => throw _privateConstructorUsedError;
  bool get expanded => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError; // Reminder reminder,
// Action action,
  String get name => throw _privateConstructorUsedError; //  ids
  @JsonKey(includeIfNull: false)
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  @JsonKey(name: 'user_id', includeIfNull: false)
  String? get userId => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  int? get todoFileId => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  int? get categoryId => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  int? get parentTodoId => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_updated', includeIfNull: false)
  DateTime? get lastUpdated => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<Todo> get children => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TodoCopyWith<Todo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoCopyWith<$Res> {
  factory $TodoCopyWith(Todo value, $Res Function(Todo) then) =
      _$TodoCopyWithImpl<$Res, Todo>;
  @useResult
  $Res call(
      {bool done,
      bool visible,
      bool expanded,
      int order,
      String name,
      @JsonKey(includeIfNull: false) int? id,
      @JsonKey(includeIfNull: false)
      @JsonKey(name: 'user_id', includeIfNull: false)
      String? userId,
      @JsonKey(includeIfNull: false) int? todoFileId,
      @JsonKey(includeIfNull: false) int? categoryId,
      @JsonKey(includeIfNull: false) int? parentTodoId,
      String notes,
      @JsonKey(name: 'last_updated', includeIfNull: false)
      DateTime? lastUpdated,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<Todo> children});
}

/// @nodoc
class _$TodoCopyWithImpl<$Res, $Val extends Todo>
    implements $TodoCopyWith<$Res> {
  _$TodoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? done = null,
    Object? visible = null,
    Object? expanded = null,
    Object? order = null,
    Object? name = null,
    Object? id = freezed,
    Object? userId = freezed,
    Object? todoFileId = freezed,
    Object? categoryId = freezed,
    Object? parentTodoId = freezed,
    Object? notes = null,
    Object? lastUpdated = freezed,
    Object? children = null,
  }) {
    return _then(_value.copyWith(
      done: null == done
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as bool,
      visible: null == visible
          ? _value.visible
          : visible // ignore: cast_nullable_to_non_nullable
              as bool,
      expanded: null == expanded
          ? _value.expanded
          : expanded // ignore: cast_nullable_to_non_nullable
              as bool,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      todoFileId: freezed == todoFileId
          ? _value.todoFileId
          : todoFileId // ignore: cast_nullable_to_non_nullable
              as int?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int?,
      parentTodoId: freezed == parentTodoId
          ? _value.parentTodoId
          : parentTodoId // ignore: cast_nullable_to_non_nullable
              as int?,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      children: null == children
          ? _value.children
          : children // ignore: cast_nullable_to_non_nullable
              as List<Todo>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TodoImplCopyWith<$Res> implements $TodoCopyWith<$Res> {
  factory _$$TodoImplCopyWith(
          _$TodoImpl value, $Res Function(_$TodoImpl) then) =
      __$$TodoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool done,
      bool visible,
      bool expanded,
      int order,
      String name,
      @JsonKey(includeIfNull: false) int? id,
      @JsonKey(includeIfNull: false)
      @JsonKey(name: 'user_id', includeIfNull: false)
      String? userId,
      @JsonKey(includeIfNull: false) int? todoFileId,
      @JsonKey(includeIfNull: false) int? categoryId,
      @JsonKey(includeIfNull: false) int? parentTodoId,
      String notes,
      @JsonKey(name: 'last_updated', includeIfNull: false)
      DateTime? lastUpdated,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<Todo> children});
}

/// @nodoc
class __$$TodoImplCopyWithImpl<$Res>
    extends _$TodoCopyWithImpl<$Res, _$TodoImpl>
    implements _$$TodoImplCopyWith<$Res> {
  __$$TodoImplCopyWithImpl(_$TodoImpl _value, $Res Function(_$TodoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? done = null,
    Object? visible = null,
    Object? expanded = null,
    Object? order = null,
    Object? name = null,
    Object? id = freezed,
    Object? userId = freezed,
    Object? todoFileId = freezed,
    Object? categoryId = freezed,
    Object? parentTodoId = freezed,
    Object? notes = null,
    Object? lastUpdated = freezed,
    Object? children = null,
  }) {
    return _then(_$TodoImpl(
      done: null == done
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as bool,
      visible: null == visible
          ? _value.visible
          : visible // ignore: cast_nullable_to_non_nullable
              as bool,
      expanded: null == expanded
          ? _value.expanded
          : expanded // ignore: cast_nullable_to_non_nullable
              as bool,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      todoFileId: freezed == todoFileId
          ? _value.todoFileId
          : todoFileId // ignore: cast_nullable_to_non_nullable
              as int?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int?,
      parentTodoId: freezed == parentTodoId
          ? _value.parentTodoId
          : parentTodoId // ignore: cast_nullable_to_non_nullable
              as int?,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      children: null == children
          ? _value.children
          : children // ignore: cast_nullable_to_non_nullable
              as List<Todo>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$TodoImpl implements _Todo {
  const _$TodoImpl(
      {this.done = false,
      this.visible = true,
      this.expanded = false,
      this.order = 0,
      required this.name,
      @JsonKey(includeIfNull: false) this.id,
      @JsonKey(includeIfNull: false)
      @JsonKey(name: 'user_id', includeIfNull: false)
      this.userId,
      @JsonKey(includeIfNull: false) this.todoFileId,
      @JsonKey(includeIfNull: false) this.categoryId,
      @JsonKey(includeIfNull: false) this.parentTodoId,
      this.notes = '',
      @JsonKey(name: 'last_updated', includeIfNull: false) this.lastUpdated,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.children = const <Todo>[]});

  factory _$TodoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TodoImplFromJson(json);

/*
    DateTime? startDate,
    DateTime? endDate,
    DateTime? dateFinished,
    @Default(STATUS.NOT_STARTED) STATUS status,
    @Default(PRIORITY.LOW) PRIORITY priority,

*/
// List<UserField> userFields = <UserField>[];
// Category parent;
  @override
  @JsonKey()
  final bool done;
  @override
  @JsonKey()
  final bool visible;
  @override
  @JsonKey()
  final bool expanded;
  @override
  @JsonKey()
  final int order;
// Reminder reminder,
// Action action,
  @override
  final String name;
//  ids
  @override
  @JsonKey(includeIfNull: false)
  final int? id;
  @override
  @JsonKey(includeIfNull: false)
  @JsonKey(name: 'user_id', includeIfNull: false)
  final String? userId;
  @override
  @JsonKey(includeIfNull: false)
  final int? todoFileId;
  @override
  @JsonKey(includeIfNull: false)
  final int? categoryId;
  @override
  @JsonKey(includeIfNull: false)
  final int? parentTodoId;
  @override
  @JsonKey()
  final String notes;
  @override
  @JsonKey(name: 'last_updated', includeIfNull: false)
  final DateTime? lastUpdated;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final List<Todo> children;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodoImpl &&
            (identical(other.done, done) || other.done == done) &&
            (identical(other.visible, visible) || other.visible == visible) &&
            (identical(other.expanded, expanded) ||
                other.expanded == expanded) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.todoFileId, todoFileId) ||
                other.todoFileId == todoFileId) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.parentTodoId, parentTodoId) ||
                other.parentTodoId == parentTodoId) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            const DeepCollectionEquality().equals(other.children, children));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      done,
      visible,
      expanded,
      order,
      name,
      id,
      userId,
      todoFileId,
      categoryId,
      parentTodoId,
      notes,
      lastUpdated,
      const DeepCollectionEquality().hash(children));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoImplCopyWith<_$TodoImpl> get copyWith =>
      __$$TodoImplCopyWithImpl<_$TodoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TodoImplToJson(
      this,
    );
  }
}

abstract class _Todo implements Todo {
  const factory _Todo(
      {final bool done,
      final bool visible,
      final bool expanded,
      final int order,
      required final String name,
      @JsonKey(includeIfNull: false) final int? id,
      @JsonKey(includeIfNull: false)
      @JsonKey(name: 'user_id', includeIfNull: false)
      final String? userId,
      @JsonKey(includeIfNull: false) final int? todoFileId,
      @JsonKey(includeIfNull: false) final int? categoryId,
      @JsonKey(includeIfNull: false) final int? parentTodoId,
      final String notes,
      @JsonKey(name: 'last_updated', includeIfNull: false)
      final DateTime? lastUpdated,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final List<Todo> children}) = _$TodoImpl;

  factory _Todo.fromJson(Map<String, dynamic> json) = _$TodoImpl.fromJson;

  @override /*
    DateTime? startDate,
    DateTime? endDate,
    DateTime? dateFinished,
    @Default(STATUS.NOT_STARTED) STATUS status,
    @Default(PRIORITY.LOW) PRIORITY priority,

*/
// List<UserField> userFields = <UserField>[];
// Category parent;
  bool get done;
  @override
  bool get visible;
  @override
  bool get expanded;
  @override
  int get order;
  @override // Reminder reminder,
// Action action,
  String get name;
  @override //  ids
  @JsonKey(includeIfNull: false)
  int? get id;
  @override
  @JsonKey(includeIfNull: false)
  @JsonKey(name: 'user_id', includeIfNull: false)
  String? get userId;
  @override
  @JsonKey(includeIfNull: false)
  int? get todoFileId;
  @override
  @JsonKey(includeIfNull: false)
  int? get categoryId;
  @override
  @JsonKey(includeIfNull: false)
  int? get parentTodoId;
  @override
  String get notes;
  @override
  @JsonKey(name: 'last_updated', includeIfNull: false)
  DateTime? get lastUpdated;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<Todo> get children;
  @override
  @JsonKey(ignore: true)
  _$$TodoImplCopyWith<_$TodoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
