import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_book/data/models/notes_model.dart';
import 'package:note_book/screens/notebook/note_editor.dart';

class NoteList extends StatelessWidget {
  const NoteList({super.key, required this.noteBook, required this.noteBookID});
  final NoteBookModel noteBook;
  final int noteBookID;

  @override
  Widget build(BuildContext context) {
    var notesLength = noteBook.noteBooks?.length;
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(noteBook.noteBooks![index].noteTitle),
          subtitle:
              //TODO: Fix the chip to use a list builder as well but horizontally
              Chip(label: Text(noteBook.noteBooks![index].tags.toString())),
          onTap: () => Get.to(
              () => NoteEditor(doc: noteBook.noteBooks![index].document)),
        );
      },
      itemCount: notesLength,
    );
  }
}
