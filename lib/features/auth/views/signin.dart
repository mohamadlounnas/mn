

import 'package:flutter/material.dart';
import 'package:mn/features/auth/data/repositries/users_repositry.dart';
import 'package:mn/features/todos/data/repositires/todos_repositry.dart';

class SigninForm extends StatelessWidget {
  const SigninForm({super.key, required this.usersRepository, required this.todosRepository});
  final UsersRepository usersRepository;
  final TodosRepository todosRepository;
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(decoration: InputDecoration(labelText: 'Email'),),
          TextFormField(decoration: InputDecoration(labelText: 'Password'),),
        ],
      ),
    );
  }
}