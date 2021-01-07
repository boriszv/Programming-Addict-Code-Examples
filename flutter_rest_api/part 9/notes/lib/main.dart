import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notes/services/notes_service.dart';
import 'package:notes/views/note_list.dart';

import 'json_serializable_converter.dart';
import 'models/note.dart';
import 'models/note_for_listing.dart';

Future<Request> authHeaderRequestInterceptor(Request request) async {
  final headers = Map<String, String>.from(request.headers);

  headers['apiKey'] = 'e5245278-ed86-4196-81d6-cdf608b02623';

  request = request.copyWith(headers: headers);
  return request;
}


void setupLocator() {
  GetIt.I.registerLazySingleton(() => NotesService.create(ChopperClient(
    baseUrl: NotesService.API,
    converter: JsonSerializableConverter({
      Note: Note.fromJson,
      NoteForListing: NoteForListing.fromJson
    }),
    interceptors: [
      authHeaderRequestInterceptor
    ],
  )));
}

void main() {
  setupLocator();
  runApp(App());
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NoteList(),
    );
  }
}
