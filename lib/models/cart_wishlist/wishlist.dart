import 'package:json_annotation/json_annotation.dart';

part 'wishlist.g.dart';

@JsonSerializable()
class Wishlist {
  final int id;
  final int userId;
  final int productId;
  final DateTime createdAt;

  Wishlist({
    required this.id,
    required this.userId,
    required this.productId,
    required this.createdAt,
  });

  factory Wishlist.fromJson(Map<String, dynamic> json) => _$WishlistFromJson(json);
  Map<String, dynamic> toJson() => _$WishlistToJson(this);
}