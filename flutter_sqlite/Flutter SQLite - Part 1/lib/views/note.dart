import 'package:flutter/material.dart';

enum NoteMode {
  Editing,
  Adding
}

class Note extends StatelessWidget {

  final NoteMode _noteMode;

  Note(this._noteMode);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _noteMode == NoteMode.Adding ? 'Add note' : 'Edit note'
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                hintText: 'Note title'
              ),
            ),
            Container(height: 8,),
            TextField(
              decoration: InputDecoration(
                hintText: 'Note text'
              ),
            ),
            Container(height: 16.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _NoteButton('Save', Colors.blue, () {
                  Navigator.pop(context);
                }),
                Container(height: 16.0,),
                _NoteButton('Discard', Colors.grey, () {
                  Navigator.pop(context);
                }),
                _noteMode == NoteMode.Editing ?
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: _NoteButton('Delete', Colors.red, () {
                      Navigator.pop(context);
                    }),
                  )
                 : Container()
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _NoteButton extends StatelessWidget {

  final String _text;
  final Color _color;
  final Function _onPressed;

  _NoteButton(this._text, this._color, this._onPressed);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: _onPressed,
      child: Text(
        _text,
        style: TextStyle(color: Colors.white),
      ),
      height: 40,
      minWidth: 100,
      color: _color,
    );
  }
}

