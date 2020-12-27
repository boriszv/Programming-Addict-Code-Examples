import 'package:easy_preferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences().init();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
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

  String data;

  @override
  void initState() {
    data = UserPreferences().data;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test app'),
      ),
      body: Column(
        children: <Widget>[
          Text(data ?? '', style: TextStyle(fontSize: 33)),
          RaisedButton(
            child: Text('Change data'),
            onPressed: () {
              UserPreferences().data = data + 'a';
              setState(() {
                data = UserPreferences().data;
              });
            },
          )
        ],
      ),
    );
  }
}