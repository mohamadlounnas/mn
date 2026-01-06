import 'package:flutter/material.dart';
import 'package:mn/features/todos/data/models/todo_model.dart';
import 'package:mn/features/todos/data/repositires/todos_repositry.dart';

class TodosView extends StatefulWidget {
  final TodosRepository todosRepository;
  const TodosView({super.key, required this.todosRepository});

  @override
  State<TodosView> createState() => _TodosViewState();
}

class _TodosViewState extends State<TodosView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo List')),
      body: ListView(
        children: [
          for (var todo in widget.todosRepository.getTodos())
            ListTile(
              title: Text(todo.title),
            ),
        ],
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