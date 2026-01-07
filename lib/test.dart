import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

// https://jsonplaceholder.typicode.com/todos/1
final dio = Dio();

class Test extends StatelessWidget {

  build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: dio.get('https://jsonplaceholder.typicode.com/todos/4'),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return Center(child: ListTile(title: Text(snapshot.data!.data["title"])));
        },
      ),
    );


  }

}
