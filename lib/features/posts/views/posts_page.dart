



import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mn/features/auth/views/auth_provider.dart';
import 'package:mn/features/posts/data/models/create_post.dart';
import 'package:mn/features/posts/data/models/post.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final postsRepositry = DataProvider.of(context).postsRepositry;
    final usersRepository = DataProvider.of(context).usersRepository;

    postsRepositry.getPosts();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts')
        // refresh button
        , actions: [
          IconButton(
            onPressed: () async {
              await postsRepositry.getPosts();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: ValueListenableBuilder<List<Post>>(
        valueListenable: postsRepositry.posts,
        builder: (context, postsList, _) {
          if (postsList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: [
              for (var post in postsList)
                ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.description),
                ),
            ],
          );
        }

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await showDialog<CreatePost>(
            context: context,
            builder: (context) {
              var titleController = TextEditingController();
              var descriptionController = TextEditingController();

              return AlertDialog(
                title: const Text('Add Post'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      ),
                    ),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Add post logic
                      Navigator.of(context).pop(CreatePost(
                        title: titleController.text,
                        description: descriptionController.text,
                        body: "Sample body content",
                      ));
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );

          if (result != null) {
            await postsRepositry.createPost(result);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}