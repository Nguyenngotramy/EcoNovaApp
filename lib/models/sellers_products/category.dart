import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  final int id;
  final String name;
  final String slug;
  final int? parentId;
  final int sortOrder;
  final DateTime createdAt;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    this.parentId,
    required this.sortOrder,
    required this.createdAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}