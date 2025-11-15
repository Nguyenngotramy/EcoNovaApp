// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_certification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductCertification _$ProductCertificationFromJson(
  Map<String, dynamic> json,
) => ProductCertification(
  id: (json['id'] as num).toInt(),
  productId: (json['productId'] as num).toInt(),
  certType: $enumDecode(_$CertTypeEnumMap, json['certType']),
  certNumber: json['certNumber'] as String?,
  certUrl: json['certUrl'] as String?,
  validFrom: json['validFrom'] == null
      ? null
      : DateTime.parse(json['validFrom'] as String),
  validTo: json['validTo'] == null
      ? null
      : DateTime.parse(json['validTo'] as String),
);

Map<String, dynamic> _$ProductCertificationToJson(
  ProductCertification instance,
) => <String, dynamic>{
  'id': instance.id,
  'productId': instance.productId,
  'certType': _$CertTypeEnumMap[instance.certType]!,
  'certNumber': instance.certNumber,
  'certUrl': instance.certUrl,
  'validFrom': instance.validFrom?.toIso8601String(),
  'validTo': instance.validTo?.toIso8601String(),
};

const _$CertTypeEnumMap = {
  CertType.vietGAP: 'vietGAP',
  CertType.organic: 'organic',
  CertType.globalGAP: 'globalGAP',
  CertType.other: 'other',
};
