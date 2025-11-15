import 'package:json_annotation/json_annotation.dart';
import '../enums.dart';

part 'complaint.g.dart';

@JsonSerializable()
class Complaint {
  final int id;
  final int orderId;
  final int userId;
  final ComplaintType type;
  final String description;
  @JsonKey(name: 'evidence_urls')
  final List<String>? evidenceUrls; // JSON array từ SQL
  final ComplaintStatus status;
  @JsonKey(name: 'admin_note')
  final String? adminNote;
  final DateTime createdAt;
  @JsonKey(name: 'resolved_at')
  final DateTime? resolvedAt;

  Complaint({
    required this.id,
    required this.orderId,
    required this.userId,
    required this.type,
    required this.description,
    this.evidenceUrls,
    required this.status,
    this.adminNote,
    required this.createdAt,
    this.resolvedAt,
  });

  factory Complaint.fromJson(Map<String, dynamic> json) => _$ComplaintFromJson(json);
  Map<String, dynamic> toJson() => _$ComplaintToJson(this);
}