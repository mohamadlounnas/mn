import 'package:mn/features/todos/domain/todo_entity.dart';

class TodoModel extends TodoEntity {
  TodoModel({required super.id, required super.title, required super.createdAt, super.doneAt});

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'].toString(),
      title: json['title'],
      createdAt: DateTime.now(),
      doneAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'createdAt': createdAt, 'doneAt': doneAt};
  }
}
