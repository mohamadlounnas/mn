

import 'package:flutter/material.dart';
import 'package:mn/features/auth/data/repositries/users_repositry.dart';
import 'package:mn/features/auth/views/auth_provider.dart';
import 'package:mn/features/todos/data/repositires/todos_repositry.dart';

class SigninForm extends StatelessWidget {
  const SigninForm({super.key});
  @override
  Widget build(BuildContext context) {
    var dataProvider = DataProvider.of(context);
    var usersRepository = dataProvider.usersRepository;
    var todosRepository = dataProvider.todosRepository;
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