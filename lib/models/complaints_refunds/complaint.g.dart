// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complaint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Complaint _$ComplaintFromJson(Map<String, dynamic> json) => Complaint(
  id: (json['id'] as num).toInt(),
  orderId: (json['orderId'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  type: $enumDecode(_$ComplaintTypeEnumMap, json['type']),
  description: json['description'] as String,
  evidenceUrls: (json['evidence_urls'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  status: $enumDecode(_$ComplaintStatusEnumMap, json['status']),
  adminNote: json['admin_note'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  resolvedAt: json['resolved_at'] == null
      ? null
      : DateTime.parse(json['resolved_at'] as String),
);

Map<String, dynamic> _$ComplaintToJson(Complaint instance) => <String, dynamic>{
  'id': instance.id,
  'orderId': instance.orderId,
  'userId': instance.userId,
  'type': _$ComplaintTypeEnumMap[instance.type]!,
  'description': instance.description,
  'evidence_urls': instance.evidenceUrls,
  'status': _$ComplaintStatusEnumMap[instance.status]!,
  'admin_note': instance.adminNote,
  'createdAt': instance.createdAt.toIso8601String(),
  'resolved_at': instance.resolvedAt?.toIso8601String(),
};

const _$ComplaintTypeEnumMap = {
  ComplaintType.wrongProduct: 'wrongProduct',
  ComplaintType.damaged: 'damaged',
  ComplaintType.lateDelivery: 'lateDelivery',
  ComplaintType.missingItems: 'missingItems',
  ComplaintType.other: 'other',
};

const _$ComplaintStatusEnumMap = {
  ComplaintStatus.pending: 'pending',
  ComplaintStatus.investigating: 'investigating',
  ComplaintStatus.resolved: 'resolved',
  ComplaintStatus.rejected: 'rejected',
};
