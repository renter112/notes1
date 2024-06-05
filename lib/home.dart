import 'package:firebase_ui_auth/firebase_ui_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:notes1/app_state.dart';
import 'package:notes1/note_list.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('A-Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<ProfileScreen>(
                  builder:(context) => ProfileScreen(
                    appBar: AppBar(
                      title: const Text('User Profile'),
                    ),
                    actions: [
                      SignedOutAction((context) {
                        Navigator.of(context).pop();
                      })
                    ],
                  ),
                )
              );
            },
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: Consumer<ApplicationState>(
              builder: (context, appState, _) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: NoteList(
                  addNote: (note) => appState.addNoteToNoteList(note),
                  notes: appState.noteListNotes,
                  onDeletePressed: (note) => appState.deleteNote(note),
                  saveNote: (note) => appState.saveNote(note),
                ),
              ),
            ),
    );
  }
}