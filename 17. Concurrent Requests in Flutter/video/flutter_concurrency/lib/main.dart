import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Map<String, dynamic> post;
  List<dynamic> comments;

  bool _showLoading = true;
  bool _showComments = true;

  @override
  void initState() {
    super.initState();


    _fetchData();
  }

  Future _fetchData() async {
    setState(() { _showLoading = true; });

    final results = await Future.wait([
      http.get('http://jsonplaceholder.typicode.com/posts/1'),
      http.get('http://jsonplaceholder.typicode.com/comments?postId=1')
    ]);

    setState(() {
      post = json.decode(results[0].body);
      comments = json.decode(results[1].body);
    });

    setState(() { _showLoading = false; });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("JSON Placeholder Blog post"),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 70),
              if (_showLoading)
                Center(child: CupertinoActivityIndicator(animating: true)),

              if (!_showLoading) ... [
                Text(post['title'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),

                SizedBox(height: 10),

                _showCommentsToggle(),

                SizedBox(height: 10),

                if (!_showComments)
                  Text(post['body'], style: TextStyle(fontSize: 14)),

                if (_showComments)
                  ..._commentList()
              ]
            ],
          ),
        ),
      ),
    );
  }

  _showCommentsToggle() {
    return Row(
      children: [
        Text('Show comments', style: TextStyle(fontWeight: FontWeight.bold),),
        GestureDetector(
          child: CupertinoSwitch(
            value: _showComments,
            onChanged: (bool value) { setState(() { _showComments = value; }); },
          ),
          onTap: () { setState(() { _showComments = !_showComments; }); },
        ),
      ],
    );
  }

  _commentList() {
    return comments.map((comment) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(comment['email'], style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
        Text(comment['body'],  style: TextStyle(fontSize: 14)),
        SizedBox(height: 15)
      ],
    )).toList();
  }
}