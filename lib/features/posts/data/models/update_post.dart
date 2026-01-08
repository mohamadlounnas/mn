


class UpdatePost {
  String? title;
  String? description;
  String? body;

  UpdatePost({
    this.title,
    this.description,
    this.body,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (title != null) data['title'] = title;
    if (description != null) data['description'] = description;
    if (body != null) data['body'] = body;
    return data;
  }
}