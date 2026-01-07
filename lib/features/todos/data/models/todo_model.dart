import 'package:mn/features/todos/domain/todo_entity.dart';

class TodoModel extends TodoEntity {
  TodoModel({
    required super.id,
    required super.title,
    required super.createdAt,
    super.doneAt,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      createdAt: DateTime.parse(json['created_at']),
      doneAt: json['done_at'] != null ? DateTime.parse(json['done_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'created_at': createdAt.toIso8601String(),
      'done_at': doneAt?.toIso8601String(),
    };
  }

  // CopyWith method
  TodoModel copyWith({
    String? id,
    String? title,
    DateTime? createdAt,
    DateTime? doneAt,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      doneAt: doneAt ?? this.doneAt,
    );
  }
}