

class Todo {
   String title;
   DateTime createdAt;
   DateTime? doneAt;

   Todo({
    required this.title,
    required this.createdAt,
    this.doneAt,
   }); 
}