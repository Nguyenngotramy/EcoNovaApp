// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
  id: (json['id'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
  title: json['title'] as String,
  content: json['content'] as String?,
  dataJson: json['data_json'] as Map<String, dynamic>?,
  isRead: json['is_read'] as bool,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': _$NotificationTypeEnumMap[instance.type]!,
      'title': instance.title,
      'content': instance.content,
      'data_json': instance.dataJson,
      'is_read': instance.isRead,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$NotificationTypeEnumMap = {
  NotificationType.order: 'order',
  NotificationType.promotion: 'promotion',
  NotificationType.message: 'message',
  NotificationType.system: 'system',
  NotificationType.priceAlert: 'priceAlert',
};
