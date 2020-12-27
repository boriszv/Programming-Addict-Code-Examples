import 'package:flutter/material.dart';
import 'package:notes/views/note.dart';

class NoteList extends StatelessWidget {

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
                MaterialPageRoute(builder: (context) => Note(NoteMode.Editing))
              );
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 30, left: 13.0, right: 22.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _NoteTitle(),
                    Container(height: 4,),
                    _NoteText()
                  ],
                ),
              ),
            ),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Note(NoteMode.Adding))
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _NoteTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Some title',
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold
      ),
    );
  }
}

class _NoteText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      style: TextStyle(
          color: Colors.grey.shade600
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
