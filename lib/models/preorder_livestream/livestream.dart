import 'package:json_annotation/json_annotation.dart';
import '../enums.dart';

part 'livestream.g.dart';

@JsonSerializable()
class Livestream {
  final int id;
  final int sellerId;
  final String title;
  final String? description;
  @JsonKey(name: 'stream_url')
  final String? streamUrl;
  @JsonKey(name: 'thumbnail_url')
  final String? thumbnailUrl;
  @JsonKey(name: 'scheduled_at')
  final DateTime scheduledAt;
  @JsonKey(name: 'started_at')
  final DateTime? startedAt;
  @JsonKey(name: 'ended_at')
  final DateTime? endedAt;
  @JsonKey(name: 'viewer_count')
  final int viewerCount;
  final LivestreamStatus status;
  final DateTime createdAt;

  Livestream({
    required this.id,
    required this.sellerId,
    required this.title,
    this.description,
    this.streamUrl,
    this.thumbnailUrl,
    required this.scheduledAt,
    this.startedAt,
    this.endedAt,
    required this.viewerCount,
    required this.status,
    required this.createdAt,
  });

  factory Livestream.fromJson(Map<String, dynamic> json) => _$LivestreamFromJson(json);
  Map<String, dynamic> toJson() => _$LivestreamToJson(this);
}