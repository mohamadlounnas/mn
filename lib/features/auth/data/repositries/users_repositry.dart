


import 'package:shared_preferences/shared_preferences.dart';

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

    // save token
    var prefs = await SharedPreferences.getInstance();

    await prefs.setString('auth_token', token);



    return user;
  }


  // load current user from shared preferences
  Future<void> loadCurrentUser() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('auth_token');

    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
      // fetch user info from api
      var response = await dio.get('/api/auth/me');
      var userJson = response.data;
      var user = UserModel.fromJson(userJson);
      currentUser.value = user;
    }
  }


  //  logout
  Future<void> logout() async {
    currentUser.value = null;
    dio.options.headers.remove('Authorization');

    var prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  // create user
  UserModel createUser(UserModel user) {
    users.add(user);
    currentUser.value = user;
    return user;
  }
}