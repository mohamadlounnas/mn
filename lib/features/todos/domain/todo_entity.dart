

abstract class TodoEntity {
  final String id;
  final String title;
  final DateTime createdAt;
  final DateTime? doneAt;

  TodoEntity({required this.id, required this.title, required this.createdAt, this.doneAt});
}