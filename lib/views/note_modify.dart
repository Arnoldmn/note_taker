import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notetaker/models/note.dart';
import 'package:notetaker/models/note_inssert.dart';
import 'package:notetaker/services/note_service.dart';

class NoteModify extends StatefulWidget {
  String noteID;

  NoteModify({this.noteID});

  @override
  _NoteModifyState createState() => _NoteModifyState();
}

class _NoteModifyState extends State<NoteModify> {
  bool get isEditing => widget.noteID != null;

  NoteService get notesService => GetIt.I<NoteService>();
  String errorMessage;
  Note note;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      setState(() {
        _isLoading = true;
      });
      notesService.getNote(widget.noteID).then((response) {
        setState(() {
          _isLoading = false;
        });
        if (response.error) {
          errorMessage = response.errorMessage ?? 'An error occurred';
        }
        note = response.data;
        _titleController.text = note.noteTitle;
        _contentController.text = note.noteContent;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit note' : 'Create note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(hintText: 'Note title'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _contentController,
                    decoration: InputDecoration(hintText: 'Note content'),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 35,
                    child: RaisedButton(
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Theme.of(context).primaryColor,
                      onPressed: () async {
                        if (isEditing) {
                          setState(() {
                            _isLoading = true;
                          });
                          final note = NoteManipulation(
                              noteTitle: _titleController.text,
                              noteContent: _contentController.text);
                          final result = await notesService.updateNote(widget.noteID, note);
                          setState(() {
                            _isLoading = false;
                          });

                          final title = 'Done';
                          final text = result.error
                              ? (result.errorMessage ?? 'An error occurred')
                              : 'Your note was created';

                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text(title),
                              content: Text(text),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Ok'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            ),
                          );
                        } else {
                          setState(() {
                            _isLoading = true;
                          });
                          final note = NoteManipulation(
                              noteTitle: _titleController.text,
                              noteContent: _contentController.text);
                          final result = await notesService.createNote(note);
                          setState(() {
                            _isLoading = false;
                          });

                          final title = 'Done';
                          final text = result.error
                              ? (result.errorMessage ?? 'An error occurred')
                              : 'Your note was updated';

                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text(title),
                              content: Text(text),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Ok'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            ),
                          ).then((data) {
                            if (result.data) {
                              Navigator.of(context).pop();
                            }
                          });
                        }
                      },
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
