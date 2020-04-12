import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable()
class Note {
  
  String noteID;
  String noteTitle;
  String noteContent;
  DateTime createDateTime;
  DateTime latestEditDateTime;
  
  Note({this.noteID, this.noteTitle, this.noteContent, this.createDateTime, this.latestEditDateTime});

  factory Note.fromJson(Map<String, dynamic> item) => _$NoteFromJson(item);
}