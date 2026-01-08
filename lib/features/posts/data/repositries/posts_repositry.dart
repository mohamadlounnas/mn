


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mn/features/posts/data/models/create_post.dart';
import 'package:mn/features/posts/data/models/post.dart';
import 'package:mn/features/posts/data/models/update_post.dart';

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

  // update post
  Future<Post> updatePost(int id, UpdatePost updatePost) async {
    var response = await dio.put('/api/posts/$id', data: updatePost.toJson());
    var updatedPost = Post.fromJson(response.data);

    for (int i = 0; i < posts.value.length; i++) {
      if (posts.value[i].id == id) {
        posts.value[i] = updatedPost;
        break;
      }
    }
    posts.notifyListeners();
    return updatedPost;
  }

}