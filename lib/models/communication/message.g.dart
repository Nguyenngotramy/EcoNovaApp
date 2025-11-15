// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
  id: (json['id'] as num).toInt(),
  senderId: (json['senderId'] as num).toInt(),
  receiverId: (json['receiverId'] as num).toInt(),
  message: json['message'] as String,
  attachmentUrl: json['attachment_url'] as String?,
  isRead: json['is_read'] as bool,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
  'id': instance.id,
  'senderId': instance.senderId,
  'receiverId': instance.receiverId,
  'message': instance.message,
  'attachment_url': instance.attachmentUrl,
  'is_read': instance.isRead,
  'createdAt': instance.createdAt.toIso8601String(),
};
