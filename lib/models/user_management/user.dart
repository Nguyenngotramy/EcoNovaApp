import 'package:json_annotation/json_annotation.dart';
import '../enums.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String email;
  final String phone;
  final String passwordHash; // Không lưu plain text trong app
  final UserRole role;
  final String fullName;
  final String? avatarUrl;
  final DateTime? birthDate;
  final Gender? gender;
  final bool isVerified;
  final bool twoFactorEnabled;
  final String? twoFactorSecret;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.email,
    required this.phone,
    required this.passwordHash,
    required this.role,
    required this.fullName,
    this.avatarUrl,
    this.birthDate,
    this.gender,
    required this.isVerified,
    required this.twoFactorEnabled,
    this.twoFactorSecret,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}