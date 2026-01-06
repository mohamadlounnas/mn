

import 'package:mn/features/auth/domain/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.id, required super.name, required super.email, required super.password});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json['id'], name: json['name'], email: json['email'], password: json['password']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email, 'password': password};
  }
}