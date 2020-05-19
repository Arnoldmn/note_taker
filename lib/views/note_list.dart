import 'package:flutter/material.dart';
import 'package:notetaker/models/note_for_listing.dart';
import 'package:notetaker/views/note_delete.dart';
import 'package:notetaker/views/note_modify.dart';

class NoteList extends StatelessWidget {
  final notes = [
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

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of notes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => NoteModify(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: ListView.separated(
        separatorBuilder: (_, __) => Divider(
          height: 1,
          color: Colors.grey,
        ),
        itemBuilder: (_, index) {
          return Dismissible(
            key: ValueKey(notes[index].noteID),
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) {},
            confirmDismiss: (direction) async {
              final result = await showDialog(
                  context: context, builder: (_) => NoteDelete());
              return result;
            },
            child: (ListTile(
              title: Text(
                notes[index].noteTitle,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              subtitle: Text(
                  'Last edited on ${formatDateTime(notes[index].lastEditDateTime)}'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => NoteModify(
                      noteID: notes[index].noteID,
                    ),
                  ),
                );
              },
            )),
          );
        },
        itemCount: notes.length,
      ),
    );
  }
}
