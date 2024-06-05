
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notes1/models/note_model.dart';
import 'package:notes1/src/widgets.dart';

class NoteList extends StatefulWidget {
  const NoteList({
    super.key,
    required this.addNote,
    required this.notes,
    required this.onDeletePressed,
    required this.saveNote,
  });

  final FutureOr<void> Function(Note note) addNote;
  final List<Note> notes;
  final FutureOr<void> Function(Note note) onDeletePressed;
  final FutureOr<void> Function(Note note) saveNote;

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_NoteListState');
  final _controllerTitle = TextEditingController();
  final _controllerContent = TextEditingController();
  bool _isFormVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body :
        Column(
        children: [
          if (_isFormVisible) 
            FormCard(formKey: _formKey, controllerTitle: _controllerTitle, controllerContent: _controllerContent, addNote: widget.addNote, formHide:() {
          setState(() {
            _isFormVisible = !_isFormVisible;
          });
        }),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width < 600
                    ? 1
                    : MediaQuery.of(context).size.width < 1200
                        ? 2
                        : 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 3/2,
              ),
              itemCount: widget.notes.length ,
              itemBuilder: (context, index) {
                return ResponsiveNoteItem(
                  note: widget.notes[index],
                  onDeletePressed: widget.onDeletePressed,
                  saveNote: widget.saveNote,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isFormVisible = !_isFormVisible;
          });
        },
        child: Icon(_isFormVisible ? Icons.close : Icons.add),
      ),

    );

  }
}