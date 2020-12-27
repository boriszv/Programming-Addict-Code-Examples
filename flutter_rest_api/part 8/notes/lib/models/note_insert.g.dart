// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_insert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteManipulation _$NoteManipulationFromJson(Map<String, dynamic> json) {
  return NoteManipulation(
    noteTitle: json['noteTitle'] as String,
    noteContent: json['noteContent'] as String,
  );
}

Map<String, dynamic> _$NoteManipulationToJson(NoteManipulation instance) =>
    <String, dynamic>{
      'noteTitle': instance.noteTitle,
      'noteContent': instance.noteContent,
    };
