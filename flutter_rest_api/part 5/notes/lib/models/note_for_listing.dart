class NoteForListing {
  String noteID;
  String noteTitle;
  DateTime createDateTime;
  DateTime latestEditDateTime;
  
  NoteForListing({this.noteID, this.noteTitle, this.createDateTime, this.latestEditDateTime});

  factory NoteForListing.fromJson(Map<String, dynamic> item) {
    return NoteForListing(
      noteID: item['noteID'],
      noteTitle: item['noteTitle'],
      createDateTime: DateTime.parse(item['createDateTime']),
      latestEditDateTime: item['latestEditDateTime'] != null
          ? DateTime.parse(item['latestEditDateTime'])
          : null,
    );
  }
}