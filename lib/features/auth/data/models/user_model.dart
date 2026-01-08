

import 'package:mn/features/auth/domain/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id, required super.name, required super.phone, required super.image_url, required super.role});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json['id'], name: json['name'], phone: json['phone'], image_url: json['image_url'], role: json['role']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'phone': phone, 'image_url': image_url, 'role': role};
  }
}