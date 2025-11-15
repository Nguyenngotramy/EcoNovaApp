import 'package:json_annotation/json_annotation.dart';
import '../enums.dart';

part 'product_certification.g.dart';

@JsonSerializable()
class ProductCertification {
  final int id;
  final int productId;
  final CertType certType;
  final String? certNumber;
  final String? certUrl;
  final DateTime? validFrom;
  final DateTime? validTo;

  ProductCertification({
    required this.id,
    required this.productId,
    required this.certType,
    this.certNumber,
    this.certUrl,
    this.validFrom,
    this.validTo,
  });

  factory ProductCertification.fromJson(Map<String, dynamic> json) => _$ProductCertificationFromJson(json);
  Map<String, dynamic> toJson() => _$ProductCertificationToJson(this);
}