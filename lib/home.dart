


import 'package:flutter/material.dart';

void _onpressed() {
  print('Pressed');
}
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Buy milk'),
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