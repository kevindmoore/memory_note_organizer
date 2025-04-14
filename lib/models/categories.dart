import 'todos.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'categories.freezed.dart';
part 'categories.g.dart';

List<Map<String, dynamic>> categoryToDatabaseJson(
    Category category, int todoFileId, String userId) {
  final categories = <Map<String, dynamic>>[];
  final updatedCategory = category.copyWith(todoFileId: todoFileId, userId: userId);
  categories.add(updatedCategory.toJson());
  return categories;
}

@Freezed(makeCollectionsUnmodifiable: false)
abstract class Category with _$Category {
  @JsonSerializable(explicitToJson: true)
  const factory Category({
    required String name,
    @JsonKey(includeIfNull: false) int? id,
    @JsonKey(includeIfNull: false) int? todoFileId,
    @JsonKey(name: 'user_id', includeIfNull: false) String? userId,
    @JsonKey(name: 'last_updated', includeIfNull: false) DateTime? lastUpdated,
    @JsonKey(name: 'created_at', includeIfNull: false) DateTime? createdAt,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(<Todo>[]) List<Todo> todos,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}
