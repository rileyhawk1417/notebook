import 'package:flutter/material.dart';
import 'package:note_book/components/notebook_notes_list.dart';
import 'package:note_book/data/isar/notebook.dart';

class NotesListScreen extends StatelessWidget {
  const NotesListScreen(
      {super.key, required this.selectedNoteBook, required this.id});
  final NoteBook selectedNoteBook;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('NoteBooks'),
      ),
      body: NoteBookNoteList(
        noteBook: selectedNoteBook,
        noteBookID: id,
      ),
    );
  }
}
