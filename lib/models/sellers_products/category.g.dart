// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  slug: json['slug'] as String,
  parentId: (json['parentId'] as num?)?.toInt(),
  sortOrder: (json['sortOrder'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'slug': instance.slug,
  'parentId': instance.parentId,
  'sortOrder': instance.sortOrder,
  'createdAt': instance.createdAt.toIso8601String(),
};
