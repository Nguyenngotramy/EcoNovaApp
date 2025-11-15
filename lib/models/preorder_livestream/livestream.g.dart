// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'livestream.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Livestream _$LivestreamFromJson(Map<String, dynamic> json) => Livestream(
  id: (json['id'] as num).toInt(),
  sellerId: (json['sellerId'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String?,
  streamUrl: json['stream_url'] as String?,
  thumbnailUrl: json['thumbnail_url'] as String?,
  scheduledAt: DateTime.parse(json['scheduled_at'] as String),
  startedAt: json['started_at'] == null
      ? null
      : DateTime.parse(json['started_at'] as String),
  endedAt: json['ended_at'] == null
      ? null
      : DateTime.parse(json['ended_at'] as String),
  viewerCount: (json['viewer_count'] as num).toInt(),
  status: $enumDecode(_$LivestreamStatusEnumMap, json['status']),
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$LivestreamToJson(Livestream instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sellerId': instance.sellerId,
      'title': instance.title,
      'description': instance.description,
      'stream_url': instance.streamUrl,
      'thumbnail_url': instance.thumbnailUrl,
      'scheduled_at': instance.scheduledAt.toIso8601String(),
      'started_at': instance.startedAt?.toIso8601String(),
      'ended_at': instance.endedAt?.toIso8601String(),
      'viewer_count': instance.viewerCount,
      'status': _$LivestreamStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$LivestreamStatusEnumMap = {
  LivestreamStatus.scheduled: 'scheduled',
  LivestreamStatus.live: 'live',
  LivestreamStatus.ended: 'ended',
  LivestreamStatus.cancelled: 'cancelled',
};
