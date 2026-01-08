


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mn/features/posts/data/models/create_post.dart';
import 'package:mn/features/posts/data/models/post.dart';

class PostsRepositry {
  final Dio dio;

  PostsRepositry(this.dio);

  final posts = ValueNotifier<List<Post>>([]);


  // get all posts
  Future<List<Post>> getPosts() async {
    var response = await dio.get('/api/posts');
    // parse response
    List<Post> p = [];
    for (var postJson in response.data as List<dynamic>) {
      p.add(Post.fromJson(postJson));
    }
    posts.value = p;
    return posts.value;
  }

  // createPost
  Future<Post> createPost(CreatePost createPost) async {
    var response = await dio.post('/api/posts', data: createPost.toJson());
    var post = Post.fromJson(response.data);
    posts.value = [
      post,
      ...posts.value,
    ];
    return post;
  }
}