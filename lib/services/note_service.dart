import 'dart:convert';

import 'package:notetaker/models/api_response.dart';
import 'package:notetaker/models/note.dart';
import 'package:notetaker/models/note_for_listing.dart';
import 'package:http/http.dart' as http;

class NoteService {
  static const API = 'http://api.notes.programmingaddict.com';
  static const headers = {"apiKey": "c2492abf-0515-4673-ac2c-5abde7c9b1c7"};

  Future<APIResponse<List<NoteForListing>>> getNotesList() {
    return http.get(API + '/notes', headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final notes = <NoteForListing>[];
        for (var item in jsonData) {
          notes.add(
            NoteForListing.fromJson(item),
          );
        }
        return APIResponse<List<NoteForListing>>(
          data: notes,
        );
      }
      return APIResponse<List<NoteForListing>>(
          error: true, errorMessage: 'An error occurred');
    }).catchError((_) => APIResponse<List<NoteForListing>>(
        error: true, errorMessage: 'An error occurred'));
  }

  Future<APIResponse<Note>> getNote(String noteID) {
    return http.get(API + '/notes/' + noteID, headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);

        return APIResponse<Note>(
          data: Note.fromJson(jsonData),
        );
      }
      return APIResponse<Note>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) => APIResponse<List<NoteForListing>>(
        error: true, errorMessage: 'An error occurred'));
  }
}
