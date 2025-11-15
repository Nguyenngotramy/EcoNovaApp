// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginHistory _$LoginHistoryFromJson(Map<String, dynamic> json) => LoginHistory(
  id: (json['id'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  ipAddress: json['ipAddress'] as String?,
  userAgent: json['userAgent'] as String?,
  deviceFingerprint: json['deviceFingerprint'] as String?,
  loginAt: DateTime.parse(json['loginAt'] as String),
);

Map<String, dynamic> _$LoginHistoryToJson(LoginHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'ipAddress': instance.ipAddress,
      'userAgent': instance.userAgent,
      'deviceFingerprint': instance.deviceFingerprint,
      'loginAt': instance.loginAt.toIso8601String(),
    };
