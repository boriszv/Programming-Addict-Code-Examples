import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notes/models/api_response.dart';
import 'package:notes/models/note_for_listing.dart';
import 'package:notes/services/notes_service.dart';
import 'package:notes/views/note_delete.dart';

import 'note_modify.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  NotesService get service => GetIt.I<NotesService>();

  Response<List<NoteForListing>> _apiResponse;
  bool _isLoading = false;

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  void initState() {
    _fetchNotes();
    super.initState();
  }

  _fetchNotes() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getNotesList();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('List of notes')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => NoteModify()))
                .then((_) {
                  _fetchNotes();
                });
          },
          child: Icon(Icons.add),
        ),
        body: Builder(
          builder: (_) {
            if (_isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (!_apiResponse.isSuccessful) {
              return Center(child: Text('An error occurred'));
            }

            return ListView.separated(
              separatorBuilder: (_, __) => Divider(height: 1, color: Colors.green),
              itemBuilder: (context, index) {
                return Dismissible(
                  key: ValueKey(_apiResponse.body[index].noteID),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {},
                  confirmDismiss: (direction) async {
                    final result = await showDialog(context: context, builder: (_) => NoteDelete());
                    
                    if (result) {
                      final deleteResult = await service.deleteNote(_apiResponse.body[index].noteID);
                      var message = '';

                      if (deleteResult != null && deleteResult.isSuccessful) {
                        message = 'The note was deleted successfully';
                      } else {
                        message = 'An error occrued';
                      }
                      Scaffold.of(context).showSnackBar(SnackBar(content: Text(message),duration: new Duration(milliseconds: 1000)));

                      return deleteResult.isSuccessful;
                    } 
                    print(result);
                    return result;
                  },
                  background: Container(
                    color: Colors.red,
                    padding: EdgeInsets.only(left: 16),
                    child: Align(
                      child: Icon(Icons.delete, color: Colors.white),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      _apiResponse.body[index].noteTitle,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    subtitle: Text(
                        'Last edited on ${formatDateTime(_apiResponse.body[index].latestEditDateTime ?? _apiResponse.body[index].createDateTime)}'),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => NoteModify(
                              noteID: _apiResponse.body[index].noteID))).then((data) {
                                _fetchNotes();
                              });
                    },
                  ),
                );
              },
              itemCount: _apiResponse.body.length,
            );
          },
        ));
  }
}
