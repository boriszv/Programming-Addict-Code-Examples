import 'dart:async';

import 'package:rx_pt8/models/blog_post.dart';
/*

      ];

*/
class BlogPostViewModel {
  
  StreamController<List<BlogPost>> _blogPostListController = StreamController.broadcast();
  Stream<List<BlogPost>> get outBlogPostList => _blogPostListController.stream;
  Sink<List<BlogPost>> get _inBlogPostList => _blogPostListController.sink;

  List<BlogPost> _blogPosts;

  BlogPostViewModel() {
    outBlogPostList.listen((data) {
      _blogPosts = data;
    });

    Future.delayed(Duration(seconds: 3))
      .then((_) {
        _inBlogPostList.add([
              new BlogPost(
                  id: 1,
                  author: 'Author',
                  content:
                      'AuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthor',
                  publishDate: DateTime.now(),
                  title: 'Blog Post 1'),
              new BlogPost(
                  id: 2,
                  author: 'Author',
                  content:
                      'AuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthor',
                  publishDate: DateTime.now(),
                  title: 'Blog Post 2'),
              new BlogPost(
                  id: 3,
                  author: 'Author',
                  content:
                      'AuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthor',
                  publishDate: DateTime.now(),
                  title: 'Blog Post 3'),
              new BlogPost(
                  id: 4,
                  author: 'Author',
                  content:
                      'AuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthor',
                  publishDate: DateTime.now(),
                  title: 'Blog Post 4'),
              new BlogPost(
                  id: 5,
                  author: 'Author',
                  content:
                      'AuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthor',
                  publishDate: DateTime.now(),
                  title: 'Blog Post 5'),
              new BlogPost(
                  id: 6,
                  author: 'Author',
                  content:
                      'AuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthor',
                  publishDate: DateTime.now(),
                  title: 'Blog Post 6'),
              new BlogPost(
                  id: 7,
                  author: 'Author',
                  content:
                      'AuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthor',
                  publishDate: DateTime.now(),
                  title: 'Blog Post 7'),
              new BlogPost(
                  id: 8,
                  author: 'Author',
                  content:
                      'AuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthorAuthor',
                  publishDate: DateTime.now(),
                  title: 'Blog Post 8')
        ]);
      });
  }

  void addBlogPost(BlogPost blogPost) {
    _blogPosts.add(blogPost);
    _inBlogPostList.add(_blogPosts);
  }

  void updateBlogPost(BlogPost blogPost) {
    final index = _blogPosts.indexOf(
      _blogPosts.where((bp) => bp.id == blogPost.id).first
    );
    _blogPosts[index] = blogPost;
    _inBlogPostList.add(_blogPosts);
  }

  void deleteBlogPost(int id) {
    _blogPosts.removeWhere((bp) => bp.id == id);
    _inBlogPostList.add(_blogPosts);
  }
}