import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

Stream<int> getNumbers() async* {
  for (var i = 1; i <= 3; i++) {
    yield i;
    await Future.delayed(Duration(seconds: 3));
  }
}

class HomeModel {
  final StreamController<int> _numbersController = StreamController<int>.broadcast();
  Stream<int> get outNumbers => _numbersController.stream;
  Sink<int> get inNumbers => _numbersController.sink;

  void dispose() {
    _numbersController.close();
  }
}

class Home extends StatelessWidget {

  final model = HomeModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Widget1(model),
            Widget2(model),
          ],
        )
      ),
    );
  }
}

class Widget1 extends StatelessWidget {
  
  final HomeModel _model;

  Widget1(this._model);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _model.outNumbers,
      builder: (context, snapshot) {
        return Text(snapshot.hasData ? snapshot.data.toString() : 'no data here', style: TextStyle(fontSize: 50),);
      },
    );
  }
}

class Widget2 extends StatelessWidget {

  final HomeModel _model;

  Widget2(this._model);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        _model.inNumbers.add(Random().nextInt(20000));
      },
      child: Text('press me'),
    );
  }
}
