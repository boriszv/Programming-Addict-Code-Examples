// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$NotesService extends NotesService {
  _$NotesService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = NotesService;

  Future<Response<List<NoteForListing>>> getNotesList() {
    final $url = '/notes';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<NoteForListing>, NoteForListing>($request);
  }

  Future<Response<Note>> getNote(String noteID) {
    final $url = '/notes/${noteID}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<Note, Note>($request);
  }

  Future<Response<Note>> createNote(NoteManipulation item) {
    final $url = '/notes';
    final $body = item;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Note, Note>($request);
  }

  Future<Response> updateNote(String noteID, NoteManipulation item) {
    final $url = '/notes/${noteID}';
    final $body = item;
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> deleteNote(String noteID) {
    final $url = '/notes/${noteID}';
    final $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
