import 'package:notes/models/api_response.dart';
import 'package:notes/models/note.dart';
import 'package:notes/models/note_for_listing.dart';
import 'package:notes/models/note_insert.dart';
import 'package:chopper/chopper.dart';

part 'notes_service.chopper.dart';

@ChopperApi(baseUrl: "/notes")
abstract class NotesService extends ChopperService {

  static NotesService create([ChopperClient client]) => _$NotesService(client);

  static const API = 'https://tq-notes-api-jkrgrdggbq-el.a.run.app';

  @Get()
  Future<Response<List<NoteForListing>>> getNotesList();

  @Get(path: '{noteID}')
  Future<Response<Note>> getNote(@Path() String noteID);

  @Post()
  Future<Response<Note>> createNote(@Body() NoteManipulation item);

  @Put(path: '{noteID}')
  Future<Response> updateNote(@Path() String noteID, @Body() NoteManipulation item);

  @Delete(path: '{noteID}')
  Future<Response> deleteNote(@Path() String noteID);
}
