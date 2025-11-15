// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_recommendation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AiRecommendation _$AiRecommendationFromJson(Map<String, dynamic> json) =>
    AiRecommendation(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      productId: (json['productId'] as num).toInt(),
      score: (json['score'] as num).toDouble(),
      reason: json['reason'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$AiRecommendationToJson(AiRecommendation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'productId': instance.productId,
      'score': instance.score,
      'reason': instance.reason,
      'createdAt': instance.createdAt.toIso8601String(),
    };
