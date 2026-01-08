
import 'package:mn/features/auth/data/models/user_model.dart';

class Post {
  int id;
  String title;
  String description;
  UserModel author;

  Post({
    required this.id,
    required this.title,
    required this.description,
    required this.author,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      author: UserModel.fromJson(json['author']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'author': author.toJson(),
    };
  }
}