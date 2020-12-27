import 'package:flutter/material.dart';
import 'package:page_trasitions_flutter/page_2.dart';
import 'package:page_trasitions_flutter/routes/slide_from_bottom_page_route.dart';
import 'package:page_trasitions_flutter/routes/slide_from_left_page_route.dart';
import 'package:page_trasitions_flutter/routes/slide_from_right_page_route.dart';
import 'package:page_trasitions_flutter/routes/slide_from_top_page_route.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home'),),
      body: Center(child: Text('This is the home page'),),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            SlideFromBottomPageRoute(
              widget: Page2()
            )
          );
        }
      ),
    );
  }
}