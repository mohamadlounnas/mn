import 'package:flutter/material.dart';
import 'package:mn/features/auth/data/repositries/users_repositry.dart';
import 'package:mn/features/todos/data/models/todo_model.dart';
import 'package:mn/features/todos/data/repositires/todos_repositry.dart';

class TodosView extends StatefulWidget {
  final TodosRepository todosRepository;
  final UsersRepository usersRepository;
  const TodosView({super.key, required this.todosRepository, required this.usersRepository});

  @override
  State<TodosView> createState() => _TodosViewState();
}

class _TodosViewState extends State<TodosView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo List: ${widget.usersRepository.currentUser?.name}')),
      body: FutureBuilder(
        future: widget.todosRepository.getTodos(),
        builder: (context, asyncSnapshot) {
          return ListView(
            children: [
              for (var todo in asyncSnapshot.data ?? [])
          
                ListTile(
                  leading: Icon(todo.doneAt != null ? Icons.check_box : Icons.check_box_outline_blank),
                  title: Text(todo.title),
                  subtitle: Text(todo.createdAt.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // done button
                      IconButton(
                        onPressed: () {
                          setState(() {
                            widget.todosRepository.markAsDone(todo.id);
                          });
                        },
                        icon: Icon(Icons.done),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            widget.todosRepository.deleteTodo(todo.id);
                          });
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
            ],
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog<String>(
            context: context,
            builder: (context) {
              var _todoTitle = '';
              return AlertDialog(
                title: Text('Add todo'),
                content: TextField(onChanged: (value) => _todoTitle = value),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(context, _todoTitle), child: Text('Add')),
                  TextButton(onPressed: () => Navigator.pop(context, null), child: Text('Cancel')),
                ],
              );
            },
          );

          if (result != null) {
            widget.todosRepository.createTodo(
              TodoModel(id: DateTime.now().microsecondsSinceEpoch.toString(), title: result, createdAt: DateTime.now()),
            );
            setState(() {});
          }
        },
        child: Text('Add'),
      ),
   
    );
  }
}