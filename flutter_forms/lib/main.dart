import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forms',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forms flutter'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email'
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'This field must not be empty';
                  }
                  if (!value.contains('@')) {
                    return 'Invalid email';
                  }
                },
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password'
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'This field must not be empty';
                  }
                  if (!value.contains(RegExp('[0-9]')) || 
                    !value.contains(RegExp('[a-z]'))) {
                    return 'Password must contain letters and nubmers';
                  }
                  if (value.length < 8) {
                    return 'Password must not have less than 8 characters';
                  }
                },
              ),
              FlatButton(
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    //do what we have to do
                  }
                },
                color: Colors.blue,
              )
          ],
        ),
      ),
    );
  }
}
