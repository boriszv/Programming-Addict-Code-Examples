import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Internet connectivity',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Internet connectivity'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Check connectivity'),
          onPressed: _checkInternetConnectivity,
        )
      )
    );
  }

  _checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _showDialog(
        'No internet', 
        "You're not connected to a network"
      );
    } else if (result == ConnectivityResult.mobile) {
      _showDialog(
        'Internet access',
        "You're connected over mobile data"
      );
    } else if (result == ConnectivityResult.wifi) {
      _showDialog(
        'Internet access',
        "You're connected over wifi"
      );
    }
  }

  _showDialog(title, text) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(text),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }
}
