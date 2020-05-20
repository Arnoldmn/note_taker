import 'package:notetaker/models/note_for_listing.dart';

class NoteService {
  List<NoteForListing> getNotesList() {
    return [
      new NoteForListing(
          noteID: '1',
          createdDateTime: DateTime.now(),
          lastEditDateTime: DateTime.now(),
          noteTitle: 'Note 1'),
      new NoteForListing(
          noteID: '2',
          createdDateTime: DateTime.now(),
          lastEditDateTime: DateTime.now(),
          noteTitle: 'Note 2'),
      new NoteForListing(
          noteID: '3',
          createdDateTime: DateTime.now(),
          lastEditDateTime: DateTime.now(),
          noteTitle: 'Note 3'),
    ];
  }
}
