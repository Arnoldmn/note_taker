import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notetaker/services/note_service.dart';
import 'package:notetaker/views/note_list.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(
    () => NoteService(),
  );
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note Taker',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NoteList(),
    );
  }
}
