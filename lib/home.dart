import 'package:flutter/material.dart';
import 'package:mn/features/auth/data/repositries/users_repositry.dart';
import 'package:mn/features/todos/data/models/todo_model.dart';
import 'package:mn/features/todos/data/repositires/todos_repositry.dart';
import 'package:mn/features/todos/views/todos_view.dart';

class HomePage extends StatefulWidget {
  final TodosRepository todosRepository;
  final UsersRepository usersRepository;
  const HomePage({super.key, required this.todosRepository, required this.usersRepository});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return TodosView(todosRepository: widget.todosRepository, usersRepository: widget.usersRepository);
  }
}
