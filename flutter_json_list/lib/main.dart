import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_listview_json/entities/note.dart';
import 'package:http/http.dart' as http;

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  
  List<Note> _notes = List<Note>();

  Future<List<Note>> fetchNotes() async {
    var url = 'https://raw.githubusercontent.com/boriszv/json/master/random_example.json';
    var response = await http.get(url);
    
    var notes = List<Note>();
    
    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(Note.fromJson(noteJson));
      }
    }
    return notes;
  }

  @override
  void initState() {
    fetchNotes().then((value) {
      setState(() {
        _notes.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter listview with json'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.only(top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _notes[index].title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    _notes[index].text,
                    style: TextStyle(
                      color: Colors.grey.shade600
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: _notes.length,
      )
    );
  }
}
