

import 'package:mn/features/todos/data/models/todo_model.dart';

class TodosRepository {
    List<TodoModel> todos = [];


    // get all todos
    List<TodoModel> getTodos() {
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