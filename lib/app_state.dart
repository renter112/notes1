import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes1/models/note_model.dart';

import 'firebase_options.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  StreamSubscription<QuerySnapshot>? _noteListSubscription;
  List<Note> _noteListNotes = [];
  List<Note> get noteListNotes => _noteListNotes;

  Future<void> init() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user != null) {
        _loggedIn = true;
        _noteListSubscription = FirebaseFirestore.instance
            .collection('users') // Change this to your desired collection name
            .doc(user.uid) // Use user's UID to create a user-specific folder
            .collection('notes') // Subcollection for user's notes
            .orderBy('date', descending: true)
            .snapshots()
            .listen((snapshot) {
          _noteListNotes = [];
          for (final document in snapshot.docs) {
            _noteListNotes.add(
              Note(
                id: document.id,
                title: document.data()['title'],
                content: document.data()['content'],
                date: (document.data()['date'] as Timestamp).toDate(),
              ),
            );
          }
          notifyListeners();
        });
      } else {
        _loggedIn = false;
        _noteListSubscription?.cancel();
        _noteListNotes = [];
        notifyListeners();
      }
    });
  }

  Future<void> addNoteToNoteList(Note note) async {
    if (!_loggedIn) {
      throw Exception('Must be logged in');
    }
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('notes')
          .add(<String, dynamic>{
            'id' : '',
            'title': note.title,
            'content': note.content,
            'date': note.date,
      }).then((docRef) {
        return docRef.update({'id': docRef.id}).then((_) { return docRef;});
      });
    } catch (error) {
      log('Failed to add note: $error');
      rethrow; // Rethrow the error to handle it in the UI if needed
    }
  }

  Future<void> deleteNote(Note note) async {
    try {
      if (!_loggedIn) {
        throw Exception('Must be logged in');
      }
      final user = FirebaseAuth.instance.currentUser!;
      await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('notes')
        .doc(note.id)
        .delete(); 
    }catch (error) {
      log('Failed to delete note: $error');
      rethrow; // Rethrow the error to handle it in the UI if needed
    }
  }

  Future<void> saveNote(Note note) async {
    try {
      if (!_loggedIn) {
        throw Exception('Must be logged in');
      }
      final user = FirebaseAuth.instance.currentUser!;
      await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('notes')
        .doc(note.id)
        .update({
          'title': note.title,
          'content': note.content,
          'date': note.date,
        });
    }catch (error) {
      log('Failed to save note: $error');
      rethrow; // Rethrow the error to handle it in the UI if needed
    }
  }
}