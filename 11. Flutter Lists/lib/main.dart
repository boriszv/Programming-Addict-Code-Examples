import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home()
    );
  }
}

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text('List view examples'),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(child: Text('Constructor'),),
                Tab(child: Text('Builder'),),
                Tab(child: Text('Separated'),),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ListViewConstructor(),
              ListViewBuilder(),
              ListViewSeparated(),
            ],
          ),
        ),
      )
    );
  }
}

class ListViewConstructor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(color: Colors.red, height: 200,),
        Container(height: 20,),
        Container(color: Colors.red, height: 200,),
        Container(height: 20,),
        Container(color: Colors.red, height: 200,),
        Container(height: 20,),
      ],
    );
  }
}

String _randomString(int length) {
  var rand = new Random();
  var codeUnits = new List.generate(
    length, 
    (index){
        return rand.nextInt(33)+89;
    }
  );
  
  return new String.fromCharCodes(codeUnits);
}

class ListViewBuilder extends StatelessWidget {

  final List<String> data = [];

  ListViewBuilder() {
    for (var i = 0; i < 100; i++) {
      data.add(_randomString(20));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            height: 50,
            color: Colors.blue,
            child: Center(
              child: Text(
                data[index],
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      },
      itemCount: data.length,
    );
  }
}


class ListViewSeparated extends StatelessWidget {

  final List<String> data = [];

  ListViewSeparated() {
    for (var i = 0; i < 100; i++) {
      data.add(_randomString(20));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(color: Colors.black,),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            height: 50,
            color: Colors.blue,
            child: Center(
              child: Text(
                data[index],
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      },
      itemCount: data.length,
    );
  }
}
