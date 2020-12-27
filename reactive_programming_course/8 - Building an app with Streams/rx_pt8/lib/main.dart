import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rx_pt8/pages/blog_post_list.dart';
import 'package:rx_pt8/viewmodels/blog_post_vm.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => BlogPostViewModel());
}

void main() {
  setupLocator();
  runApp(App());
}

class App extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: BlogPostList(),
    );
  }
}
