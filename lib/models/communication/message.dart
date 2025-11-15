import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  final int id;
  final int senderId;
  final int receiverId;
  final String message;
  @JsonKey(name: 'attachment_url')
  final String? attachmentUrl;
  @JsonKey(name: 'is_read')
  final bool isRead;
  final DateTime createdAt;

  Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    this.attachmentUrl,
    required this.isRead,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}