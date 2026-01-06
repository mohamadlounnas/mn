


import 'package:flutter/material.dart';

import 'models/todo.dart';

void _onpressed() {
  print('Pressed');
}
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Todo> todos = [
    for (int i = 0; i < 10; i++)
      Todo(title: 'Buy milk $i', createdAt: DateTime.now()),
  ];

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: ListView(
        children: [
          if (todos.isEmpty) Center(child: Text('No todos yet')),
          for (var todo in todos)
            ListTile(
              leading: Icon(
                todo.doneAt != null ?
                  Icons.check_box 
                  : Icons.check_box_outline_blank,
              ),
              title: Text(todo.title),
              subtitle: Text(todo.createdAt.toString()),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // done button
                  IconButton(
                    onPressed: () {
                      setState(() {
                        todo.doneAt = DateTime.now();
                      });
                    },
                    icon: Icon(Icons.done),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        todos.remove(todo);
                      });
                    },
                    icon: Icon(Icons.delete),
                  ),
                ],
              ),
            ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onpressed,
        child: Text('Add'),
      ),
    );
  }
}