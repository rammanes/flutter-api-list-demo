import 'dart:convert';

import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.username,
    required super.email,
    super.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: (json['name'] as String?) ?? '',
      username: (json['username'] as String?) ?? '',
      email: (json['email'] as String?) ?? '',
      phone: json['phone'] as String?,
    );
  }

  static List<UserModel> listFromJson(String source) {
    final list = jsonDecode(source) as List<dynamic>;
    return list
        .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
