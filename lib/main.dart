import 'package:flutter/material.dart';
import 'package:mn/features/auth/data/repositries/users_repositry.dart';
import 'package:mn/features/auth/views/auth.dart';
import 'package:mn/features/todos/data/repositires/todos_repositry.dart';
import 'package:mn/home.dart';

void main() {
  var todosRepository = TodosRepository();
  var usersRepository = UsersRepository();
  runApp(MainApp(todosRepository: todosRepository, usersRepository: usersRepository));
}

class MainApp extends StatelessWidget {
  final TodosRepository todosRepository;
  final UsersRepository usersRepository;
  const MainApp({super.key, required this.todosRepository, required this.usersRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthView(usersRepository: usersRepository, todosRepository: todosRepository),
    );
  }
}
