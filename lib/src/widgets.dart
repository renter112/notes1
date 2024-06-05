import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:notes1/models/note_model.dart';
import 'package:notes1/note_edit.dart';
import 'package:share_plus/share_plus.dart';


class NoteItem extends StatelessWidget {
  final Note note;
  final FutureOr<void> Function(Note note) onDeletePressed;
  final FutureOr<void> Function(Note note) saveNote;

  const NoteItem({
    super.key,
    required this.note,
    required this.onDeletePressed,
    required this.saveNote,
  });

  void onDeletePressedConfirm(BuildContext context, Note note) {
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this note?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                onDeletePressed(note);
                Navigator.of(context).pop();
              },

            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM dd, yyyy');
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NoteEdit(note: note, saveNote: saveNote)
          ),
        );
      },
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: SelectableText(
                          note.title,
                          style: Theme.of(context).textTheme.bodyLarge,
                          maxLines: 1,
                          scrollPhysics: const ClampingScrollPhysics(),
                        ),
                      ),
                      Text(
                        dateFormat.format(note.date),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SelectableText(
                        note.content,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 8,
                        scrollPhysics: const ClampingScrollPhysics(),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.share),
                        onPressed: () => Share.share('${note.title}\n${note.content}'),
                      ),
                      IconButton(
                        onPressed: () async => await Clipboard.setData(ClipboardData(text: '${note.title}\n${note.content}')),
                        icon: const Icon(Icons.copy),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => onDeletePressedConfirm(context, note),
                      ),
                    ],
                  ),
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
    
  }
}


class ResponsiveNoteItem extends StatelessWidget {
  final Note note;
  final FutureOr<void> Function(Note note) onDeletePressed;
  final FutureOr<void> Function(Note note) saveNote;

  const ResponsiveNoteItem({
    super.key,
    required this.note,
    required this.onDeletePressed,
    required this.saveNote,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;

        if (width < 600) {
          // Mobile layout: full width
          return SizedBox(
            width: double.infinity,
            child: NoteItem(note: note, onDeletePressed: onDeletePressed, saveNote: saveNote,),
          );
        } else if (width < 1200) {
          // Tablet layout: half width
          return SizedBox(
            width: constraints.maxWidth / 2,
            child: NoteItem(note: note, onDeletePressed: onDeletePressed, saveNote: saveNote,),
          );
        } else {
          // Desktop layout: one-third width
          return SizedBox(
            width: constraints.maxWidth / 3,
            child: NoteItem(note: note, onDeletePressed: onDeletePressed, saveNote: saveNote,),
          );
        }
      },
    );
  }
}
class FormCard extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controllerTitle;
  final TextEditingController controllerContent;
  final FutureOr<void> Function(Note) addNote;
  final Function() formHide;
  
  const FormCard({
    super.key,
    required this.formKey,
    required this.controllerTitle,
    required this.controllerContent,
    required this.addNote,
     required this.formHide,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: controllerTitle,
                decoration: const InputDecoration(hintText: 'Title'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: controllerContent,
                decoration: const InputDecoration(hintText: 'Content'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter content';
                  }
                  return null;
                },
                maxLines: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: StyledButton(
                  child: const Text('Save'),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await addNote(Note(
                        id: '',
                        title: controllerTitle.text,
                        content: controllerContent.text,
                        date: DateTime.now(),
                      ));
                      controllerTitle.clear();
                      controllerContent.clear();
                      formHide();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



class Header extends StatelessWidget {
  const Header(this.heading, {super.key});
  final String heading;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      heading,
      style: const TextStyle(fontSize: 24),
    ),
  );
}

class Paragraph extends StatelessWidget {
  const Paragraph(this.content, {super.key});
  final String content;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          content,
          style: const TextStyle(fontSize: 18),
        ),
      );
}

class IconAndDetail extends StatelessWidget {
  const IconAndDetail(this.icon, this.detail, {super.key});
  final IconData icon;
  final String detail;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 8),
            Text(
              detail,
              style: const TextStyle(fontSize: 18),
            )
          ],
        ),
      );
}

class StyledButton extends StatelessWidget {
  const StyledButton({required this.child, required this.onPressed, super.key});
  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.deepPurple)),
        onPressed: onPressed,
        child: child,
      );
}