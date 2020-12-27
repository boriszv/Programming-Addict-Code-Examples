import 'package:flutter/material.dart';
import 'package:notes/inherited_widgets/note_inherited_widget.dart';
import 'package:notes/views/note.dart';

class NoteList extends StatefulWidget {

  @override
  NoteListState createState() {
    return new NoteListState();
  }
}

class NoteListState extends State<NoteList> {

  List<Map<String, String>> get _notes => NoteInheritedWidget.of(context).notes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Note(NoteMode.Editing, index))
              );
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 30, left: 13.0, right: 22.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _NoteTitle(_notes[index]['title']),
                    Container(height: 4,),
                    _NoteText(_notes[index]['text'])
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: _notes.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Note(NoteMode.Adding, null))
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _NoteTitle extends StatelessWidget {
  final String _title;

  _NoteTitle(this._title);
  
  @override
  Widget build(BuildContext context) {
    return Text(
      _title,
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold
      ),
    );
  }
}

class _NoteText extends StatelessWidget {
  final String _text;

  _NoteText(this._text);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: TextStyle(
          color: Colors.grey.shade600
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
