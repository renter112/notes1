import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notes1/models/note_model.dart';

class NoteEdit extends StatelessWidget {
  const NoteEdit({required this.note, required this.saveNote, super.key});
  final Note note;
  final FutureOr<void> Function(Note note) saveNote;

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController(text: note.title);
    TextEditingController contentController = TextEditingController(text: note.content);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
      ),
      body: Center(
          child: Container(
            width:MediaQuery.of(context).size.width < 600 ? MediaQuery.of(context).size.width * .9 : MediaQuery.of(context).size.width * .8,
            height: MediaQuery.of(context).size.width < 600 ? MediaQuery.of(context).size.height * .9: MediaQuery.of(context).size.height * .8,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.3),
                  blurRadius: 10.0,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                  ),
                ),
                const SizedBox(height: 20.0),
                Expanded(
                  child: TextField(
                    controller: contentController,
                    decoration: const InputDecoration(
                      hintText: 'Content',
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    saveNote( Note(id: note.id, title: titleController.text, content:contentController.text, date: DateTime.now()));
                    Navigator.pop(context);
                    // Save button action
                    // Perform save operation here
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
    );
  }
}