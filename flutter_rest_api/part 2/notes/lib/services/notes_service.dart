import 'package:notes/models/note_for_listing.dart';

class NotesService {

  List<NoteForListing> getNotesList() {
    return [
      new NoteForListing(
        noteID: "1",
        createDateTime: DateTime.now(),
        latestEditDateTime: DateTime.now(),
        noteTitle: "Note 1"
      ),
      new NoteForListing(
        noteID: "2",
        createDateTime: DateTime.now(),
        latestEditDateTime: DateTime.now(),
        noteTitle: "Note 2"
      ),
      new NoteForListing(
        noteID: "3",
        createDateTime: DateTime.now(),
        latestEditDateTime: DateTime.now(),
        noteTitle: "Note 3"
      ),
    ];
  }
}