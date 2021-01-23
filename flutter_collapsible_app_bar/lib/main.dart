import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(title: 'Flutter Demo Home Page'),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = [];
    for (int i = 0; i < 1000; i++) {
      items.add(i);
    }

    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 150.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                    'https://wallpapercave.com/wp/rtj1HkC.jpg',
                    fit: BoxFit.cover),

                title: Text('App title'),
                centerTitle: true,
              ),
            ),

            SliverList(
              delegate: SliverChildListDelegate(items.map((e) => Text(e.toString())).toList()),
            )
          ],
      )));
  }
}
