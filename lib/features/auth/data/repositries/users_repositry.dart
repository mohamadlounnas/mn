


import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:mn/features/auth/data/models/user_model.dart';
import 'package:dio/dio.dart';

class UsersRepository {
  final Dio dio;

  UsersRepository(this.dio);
  List<UserModel> users = [];

  // current user
  ValueNotifier<UserModel?> currentUser = ValueNotifier(null);

  // sign up
  UserModel signUp(UserModel user) {
    users.add(user);
    currentUser.value = user;
    return user;
  }

  // sign in
  // {message: Login successful, token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjIsInBob25lIjoiMDk4NzY1NDMyMSIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzY3ODY5ODE4LCJleHAiOjE3Njc5NTYyMTgsImlzcyI6ImZsdXR0ZXJfb25lX3NlcnZlciJ9.52-JDk5ZQwfJSbndpbnrGr6az2IikF9Dc4mA1wkxJu0, user: {id: 2, name: John Doe, phone: 0987654321, role: user, image_url: https://i.pravatar.cc/150?u=john}}
  Future<UserModel> signIn(String phone, String password) async {
    var response = await dio.post('/api/auth/login', 
      data: {
        "phone": phone,
        "password": password,
      }
    );

    var token = response.data['token'];
    var userJson = response.data['user'];
    var user = UserModel.fromJson(userJson);

    currentUser.value = user;
    dio.options.headers['Authorization'] = 'Bearer $token';

    return user;
  }

  // create user
  UserModel createUser(UserModel user) {
    users.add(user);
    currentUser.value = user;
    return user;
  }
}