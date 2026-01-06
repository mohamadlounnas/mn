


import 'package:mn/features/auth/data/models/user_model.dart';

class UsersRepository {
  List<UserModel> users = [];

  // current user
  UserModel? currentUser;

  // sign up
  UserModel signUp(UserModel user) {
    users.add(user);
    currentUser = user;
    return user;
  }

  // sign in
  UserModel signIn(String email, String password) {
    var user = users.firstWhere((user) => user.email == email && user.password == password);
    currentUser = user;
    return user;
  }
}