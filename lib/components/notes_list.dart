import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_book/data/models/notes_model.dart';
import 'package:note_book/data/utils/date_convertor.dart';
import 'package:note_book/screens/notebook/note_editor.dart';

class NoteList extends StatelessWidget {
  const NoteList({super.key, required this.noteBook, required this.noteBookID});
  final NoteBookModel noteBook;
  final int noteBookID;

  @override
  Widget build(BuildContext context) {
    var notesLength = noteBook.noteBooks?.length;
    return ListView.separated(
      itemCount: notesLength!,
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        var _note = noteBook.noteBooks![index];
        return ListTile(
          title: Row(children: [
            const Icon(Icons.notes),
            const SizedBox(width: 10),
            Text(_note.noteTitle)
          ]),
          subtitle:
              //TODO: Fix the chip to use a list builder as well but horizontally
              Column(
            children: [
              Text('Date created: ${representDateTime(_note.dateCreated)}'),
              Text('Date modified: ${representDateTime(_note.dateModified)}'),
              Chip(label: Text(_note.tags.toString())),
            ],
          ),
          onTap: () => Get.to(() => NoteEditor(
              noteBookID: noteBookID,
              noteId: index,
              doc: _note.document,
              title: _note.noteTitle,
              dateModified: _note.dateModified)),
        );
      },
    );
  }
}
