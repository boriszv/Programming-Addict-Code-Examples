// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) {
  return Note(
    noteID: json['noteID'] as String,
    noteTitle: json['noteTitle'] as String,
    noteContent: json['noteContent'] as String,
    createDateTime: json['createDateTime'] == null
        ? null
        : DateTime.parse(json['createDateTime'] as String),
    latestEditDateTime: json['latestEditDateTime'] == null
        ? null
        : DateTime.parse(json['latestEditDateTime'] as String),
  );
}

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'noteID': instance.noteID,
      'noteTitle': instance.noteTitle,
      'noteContent': instance.noteContent,
      'createDateTime': instance.createDateTime?.toIso8601String(),
      'latestEditDateTime': instance.latestEditDateTime?.toIso8601String(),
    };
