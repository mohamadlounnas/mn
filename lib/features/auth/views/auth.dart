

import 'package:flutter/material.dart';
import 'package:mn/features/auth/data/repositries/users_repositry.dart';
import 'package:mn/features/auth/views/signin.dart';
import 'package:mn/features/auth/views/signup.dart';
import 'package:mn/features/todos/data/repositires/todos_repositry.dart';

class AuthView extends StatefulWidget {
  final UsersRepository usersRepository;
  final TodosRepository todosRepository;
  const AuthView({super.key, required this.usersRepository, required this.todosRepository});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {

  bool isSignup = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Auth')),
      body: isSignup ? SignupForm(usersRepository: widget.usersRepository, todosRepository: widget.todosRepository) : SigninForm(usersRepository: widget.usersRepository, todosRepository: widget.todosRepository),
    );
  }
}