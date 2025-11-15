import 'package:json_annotation/json_annotation.dart';

part 'ai_recommendation.g.dart';

@JsonSerializable()
class AiRecommendation {
  final int id;
  final int userId;
  final int productId;
  final double score;
  final String? reason;
  final DateTime createdAt;

  AiRecommendation({
    required this.id,
    required this.userId,
    required this.productId,
    required this.score,
    this.reason,
    required this.createdAt,
  });

  factory AiRecommendation.fromJson(Map<String, dynamic> json) => _$AiRecommendationFromJson(json);
  Map<String, dynamic> toJson() => _$AiRecommendationToJson(this);
}