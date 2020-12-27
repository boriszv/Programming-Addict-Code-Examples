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

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  RangeValues values = RangeValues(1, 100);
  RangeLabels labels = RangeLabels('1', '100');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RangeSlider(
          min: 1,
          max: 100,
          values: values,
          divisions: 5,
          labels: labels,
          onChanged: (value) {
            print('START: ${value.start}, END: ${value.end}');
            setState(() {
              values = value;
              labels = 
              RangeLabels('${value.start.toInt().toString()}\$', '${value.end.toInt().toString()}\$');
            });
          },
        ),
      ),
    );
  }
}
