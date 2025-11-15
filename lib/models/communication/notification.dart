import 'package:json_annotation/json_annotation.dart';
import '../enums.dart';

part 'notification.g.dart';

@JsonSerializable()
class Notification {
  final int id;
  final int userId;
  final NotificationType type;
  final String title;
  final String? content;
  @JsonKey(name: 'data_json')
  final Map<String, dynamic>? dataJson; // JSON từ SQL
  @JsonKey(name: 'is_read')
  final bool isRead;
  final DateTime createdAt;

  Notification({
    required this.id,
    required this.userId,
    required this.type,
    required this.title,
    this.content,
    this.dataJson,
    required this.isRead,
    required this.createdAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => _$NotificationFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationToJson(this);
}