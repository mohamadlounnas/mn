

import 'package:mn/features/todos/data/models/todo_model.dart';
import 'package:dio/dio.dart';

class TodosRepository {
    final Dio dio;

    TodosRepository(this.dio);
    List<TodoModel> todos = [];


    // get all todos
    Future<List<TodoModel>> getTodos() async {
      var response = await dio.get('https://jsonplaceholder.typicode.com/todos');

      List<TodoModel> todos = [];

      for (var todo in response.data as List<dynamic>) {
        todos.add(TodoModel.fromJson(todo));
      }
      
      return todos;
    }

    // get todo by 
    TodoModel getTodoById(String id) {
        return todos.firstWhere((todo) => todo.id == id);
    }

    // create todo
    TodoModel createTodo(TodoModel todo) {
        todos.add(todo);
        return todo;
    }

    // mark as done
    TodoModel markAsDone(String id) {
        var todo = getTodoById(id);
        var newTodo = TodoModel(
          id: todo.id,
          title: todo.title,
          createdAt: todo.createdAt,
          doneAt: DateTime.now(),
        );
        todos.remove(todo);
        todos.add(newTodo);
        return newTodo;
    }

    // delete todo
    void deleteTodo(String id) {
        todos.removeWhere((todo) => todo.id == id);
    }
}