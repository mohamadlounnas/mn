

class CreatePost {
  String title;
  String description;
  String body;

  CreatePost({
    required this.title,
    required this.description,
    required this.body,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'body': body,
    };
  }
}