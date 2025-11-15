import 'package:json_annotation/json_annotation.dart';

part 'login_history.g.dart';

@JsonSerializable()
class LoginHistory {
  final int id;
  final int userId;
  final String? ipAddress;
  final String? userAgent;
  final String? deviceFingerprint;
  final DateTime loginAt;

  LoginHistory({
    required this.id,
    required this.userId,
    this.ipAddress,
    this.userAgent,
    this.deviceFingerprint,
    required this.loginAt,
  });

  factory LoginHistory.fromJson(Map<String, dynamic> json) => _$LoginHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$LoginHistoryToJson(this);
}