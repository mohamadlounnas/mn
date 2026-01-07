import 'package:flutter/material.dart';
import 'package:mn/features/auth/data/repositries/users_repositry.dart';
import 'package:mn/features/auth/views/auth.dart';
import 'package:mn/features/auth/views/auth_provider.dart';
import 'package:mn/features/todos/data/repositires/todos_repositry.dart';
import 'package:dio/dio.dart';

void main() {
  var dio = Dio();

  var todosRepository = TodosRepository(dio);
  var usersRepository = UsersRepository(dio);

  runApp(MainApp(todosRepository: todosRepository, usersRepository: usersRepository));
}

class MainApp extends StatelessWidget {
  final TodosRepository todosRepository;
  final UsersRepository usersRepository;
  const MainApp({super.key, required this.todosRepository, required this.usersRepository});

  @override
  Widget build(BuildContext context) {
    return DataProvider(
      usersRepository: usersRepository,
      todosRepository: todosRepository,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthView(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          cardTheme: CardThemeData(
            color: Colors.green,
          ),
          textTheme: TextTheme(
            bodyLarge: TextStyle(color: Colors.green),
            bodyMedium: TextStyle(color: Colors.green),
            bodySmall: TextStyle(color: Colors.green),
            titleLarge: TextStyle(color: Colors.green),
            titleMedium: TextStyle(color: Colors.green),
            titleSmall: TextStyle(color: Colors.green),
          ),
        ),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.light,
        // home: Test(),
      ),
    );
  }
}
