

class Todo {
   final String title;
   final DateTime createdAt;
   final DateTime? doneAt;

   Todo({
    required this.title,
    required this.createdAt,
    this.doneAt,
   }); 
}