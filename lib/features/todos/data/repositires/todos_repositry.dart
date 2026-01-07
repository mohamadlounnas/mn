import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mn/features/todos/data/models/todo_model.dart';

class TodosRepository {
  List<TodoModel> todos = [];
  
  static const String _todosKey = 'todos';

  Future<void> init() async {
    await _loadTodos();
  }

  Future<void> _loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = prefs.getStringList(_todosKey);
    
    if (todosJson != null) {
      todos = todosJson
          .map((json) => TodoModel.fromJson(jsonDecode(json)))
          .toList();
    }
  }

  Future<void> _saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = todos.map((todo) => jsonEncode(todo.toJson())).toList();
    await prefs.setStringList(_todosKey, todosJson);
  }

  List<TodoModel> getTodos() => todos;

  Future<void> createTodo(TodoModel todo) async {
    todos.add(todo);
    await _saveTodos();
  }

  Future<void> markAsDone(String id) async {
    final index = todos.indexWhere((t) => t.id == id);
    if (index != -1) {
      final todo = todos[index];
      todos[index] = todo.copyWith(
        doneAt: todo.doneAt == null ? DateTime.now() : null,
      );
      await _saveTodos();
    }
  }

  Future<void> deleteTodo(String id) async {
    todos.removeWhere((t) => t.id == id);
    await _saveTodos();
  }
}