import 'package:flutter/material.dart';
import 'package:mn/features/auth/data/repositries/users_repositry.dart';
import 'package:mn/features/auth/views/auth.dart';
import 'package:mn/features/orders/data/repositries/orders_repositry.dart';
import 'package:mn/features/todos/data/repositires/todos_repositry.dart';
import 'package:mn/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize repositories
  final usersRepository = UsersRepository();
  final todosRepository = TodosRepository();
  final ordersRepository = OrdersRepository();
  
  await usersRepository.init();
  await todosRepository.init();
  await ordersRepository.init();

  runApp(MyApp(
    usersRepository: usersRepository,
    todosRepository: todosRepository,
    ordersRepository: ordersRepository,
  ));
}

class MyApp extends StatelessWidget {
  final UsersRepository usersRepository;
  final TodosRepository todosRepository;
  final OrdersRepository ordersRepository;

  const MyApp({
    super.key,
    required this.usersRepository,
    required this.todosRepository,
    required this.ordersRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: usersRepository.isLoggedIn
          ? HomePage(
              usersRepository: usersRepository,
              todosRepository: todosRepository,
              ordersRepository: ordersRepository,
            )
          : AuthView(
              usersRepository: usersRepository,
              todosRepository: todosRepository,
              ordersRepository: ordersRepository,
            ),
    );
  }
}