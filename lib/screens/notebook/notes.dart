import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:note_book/components/notes_list.dart';
import 'package:note_book/data/models/notes_model.dart';
import 'package:note_book/data/riverpod/notes_state.dart';

class NotesListScreen extends StatelessWidget {
  const NotesListScreen(
      {super.key, required this.selectedNoteBook, required this.id});
  final NoteBookModel selectedNoteBook;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Notes'),
      ),
      body: NoteList(noteBook: selectedNoteBook, noteBookID: id),
    );
    // return ListView.separated(itemBuilder: (context, index), separatorBuilder: separatorBuilder: (context, idx) => const SizedBox(width: 50, height: 8), itemCount: );
  }
}
