class Note {
  
  String noteID;
  String noteTitle;
  String noteContent;
  DateTime createDateTime;
  DateTime latestEditDateTime;
  
  Note({this.noteID, this.noteTitle, this.noteContent, this.createDateTime, this.latestEditDateTime});

  factory Note.fromJson(Map<String, dynamic> item) {
    return Note(
      noteID: item['noteID'],
      noteTitle: item['noteTitle'],
      noteContent: item['noteContent'],
      createDateTime: DateTime.parse(item['createDateTime']),
      latestEditDateTime: item['latestEditDateTime'] != null
          ? DateTime.parse(item['latestEditDateTime'])
          : null,
    );
  }
}