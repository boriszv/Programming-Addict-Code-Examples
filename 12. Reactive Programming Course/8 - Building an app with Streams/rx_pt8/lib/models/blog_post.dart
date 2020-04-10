import 'package:meta/meta.dart';

class BlogPost {
  int id;
  String title;
  String content;
  String author;
  DateTime publishDate;

  BlogPost({@required this.id, @required this.title, @required this.content, @required this.author, @required this.publishDate});
}