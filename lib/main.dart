import 'package:flutter/material.dart';
import 'package:mn/features/todos/data/repositires/todos_repositry.dart';
import 'package:mn/home.dart';

void main() {
  var todosRepository = TodosRepository();
  runApp(MainApp(todosRepository: todosRepository));
}

class MainApp extends StatelessWidget {
  final TodosRepository todosRepository;
  const MainApp({super.key, required this.todosRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(todosRepository: todosRepository),
    );
  }
}
