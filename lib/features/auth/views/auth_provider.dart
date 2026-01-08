// auth provider

import 'package:flutter/material.dart';
import 'package:mn/features/auth/data/repositries/users_repositry.dart';
import 'package:mn/features/posts/data/repositries/posts_repositry.dart';
import 'package:mn/features/todos/data/repositires/todos_repositry.dart';

class DataProvider extends InheritedWidget {
  final UsersRepository usersRepository;
  final TodosRepository todosRepository;
  final PostsRepositry postsRepositry;
  DataProvider({super.key, required this.usersRepository, required this.todosRepository, required this.postsRepositry, required super.child});

  @override
  bool updateShouldNotify(DataProvider oldWidget) {
    return true;
  }

  static DataProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DataProvider>()!;
  }
}