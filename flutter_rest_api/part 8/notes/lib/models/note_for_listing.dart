import 'package:json_annotation/json_annotation.dart';

part 'note_for_listing.g.dart';

@JsonSerializable()
class NoteForListing {
  String noteID;
  String noteTitle;
  DateTime createDateTime;
  DateTime latestEditDateTime;
  
  NoteForListing({this.noteID, this.noteTitle, this.createDateTime, this.latestEditDateTime});

  factory NoteForListing.fromJson(Map<String, dynamic> item) => _$NoteForListingFromJson(item);
}