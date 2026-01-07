import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mn/features/auth/data/models/user_model.dart';

class UsersRepository {
  List<UserModel> users = [];
  UserModel? currentUser;
  
  static const String _usersKey = 'users';
  static const String _currentUserKey = 'current_user';

  // Initialize - call this on app start
  Future<void> init() async {
    await _loadUsers();
    await _loadCurrentUser();
  }

  // Load users from storage
  Future<void> _loadUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getStringList(_usersKey);
    
    if (usersJson != null) {
      users = usersJson
          .map((json) => UserModel.fromJson(jsonDecode(json)))
          .toList();
    }
  }

  // Save users to storage
  Future<void> _saveUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = users.map((user) => jsonEncode(user.toJson())).toList();
    await prefs.setStringList(_usersKey, usersJson);
  }

  // Load current user from storage
  Future<void> _loadCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_currentUserKey);
    
    if (userJson != null) {
      currentUser = UserModel.fromJson(jsonDecode(userJson));
    }
  }

  // Save current user to storage
  Future<void> _saveCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    
    if (currentUser != null) {
      await prefs.setString(_currentUserKey, jsonEncode(currentUser!.toJson()));
    } else {
      await prefs.remove(_currentUserKey);
    }
  }

  // Sign up
  Future<UserModel> signUp(UserModel user) async {
    users.add(user);
    currentUser = user;
    await _saveUsers();
    await _saveCurrentUser();
    return user;
  }

  // Sign in
  Future<UserModel?> signIn(String email, String password) async {
    try {
      var user = users.firstWhere(
        (user) => user.email == email && user.password == password,
      );
      currentUser = user;
      await _saveCurrentUser();
      return user;
    } catch (e) {
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    currentUser = null;
    await _saveCurrentUser();
  }

  // Check if logged in
  bool get isLoggedIn => currentUser != null;
}