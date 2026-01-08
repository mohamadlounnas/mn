import 'package:flutter/material.dart';
import 'package:mn/features/auth/data/repositries/users_repositry.dart';
import 'package:mn/features/auth/views/auth_provider.dart';
import 'package:mn/features/posts/views/posts_page.dart';
import 'package:mn/features/todos/data/repositires/todos_repositry.dart';

class SigninForm extends StatelessWidget {
  const SigninForm({super.key});

  @override
  Widget build(BuildContext context) {
    var dataProvider = DataProvider.of(context);
    var usersRepository = dataProvider.usersRepository;
    var todosRepository = dataProvider.todosRepository;

    var phone = TextEditingController();
    var password = TextEditingController();

    return Form(
      child: Center(
        child: SizedBox(
          width: 300,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: .min,
                children: [
                  ValueListenableBuilder(
                    valueListenable: usersRepository.currentUser,
                    builder: (context, user, _) {

                      if (usersRepository.currentUser.value != null) {
                        return Text(
                          'Current User: ${usersRepository.currentUser.value!.name}',
                        );
                      } else {
                        return Text('No user signed in');
                      }

                    },
                  ),

                  // logout button
                  ValueListenableBuilder(
                    valueListenable: usersRepository.currentUser,
                    builder: (context, user, _) {
                      if (usersRepository.currentUser.value != null) {
                        return ElevatedButton(
                          onPressed: () {
                            usersRepository.logout();
                          },
                          child: Text('Sign Out'),
                        );
                      } else {
                        return Text("not signed in");
                      }
                    },
                  ),

                  TextFormField(
                    controller: phone,
                    decoration: InputDecoration(labelText: 'Phone'),
                  ),
                  TextFormField(
                    controller: password,
                    decoration: InputDecoration(labelText: 'Password'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      var user = await usersRepository.signIn(
                        phone.text,
                        password.text,
                      );
                      if (user != null) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PostsPage(),
                          ),
                        );
                      }
                    },
                    child: Text('Sign In'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
