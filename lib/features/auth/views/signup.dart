
import 'package:flutter/material.dart';
import 'package:mn/features/auth/data/models/user_model.dart';
import 'package:mn/features/auth/data/repositries/users_repositry.dart';
import 'package:mn/features/todos/data/repositires/todos_repositry.dart';
import 'package:mn/home.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key, required this.usersRepository, required this.todosRepository});
  final UsersRepository usersRepository;
  final TodosRepository todosRepository;
  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                controller: name,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                controller: email,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                controller: password,
              ),
              TextButton(onPressed: () {
                widget.usersRepository.signUp(
                  UserModel(id: '', name: name.text, email: email.text, password: password.text)
                );
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(todosRepository: widget.todosRepository, usersRepository: widget.usersRepository)));
              }, child: Text('Signup')),
            ],
          ),
        ),
      ),
    );
  }
}