import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:note_book/data/riverpod/notes_state.dart';
import 'package:note_book/data/utils/date_convertor.dart';
import 'package:note_book/screens/notebook/note_editor.dart';

class NoteList extends ConsumerWidget {
  const NoteList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
        itemCount: ref.watch(noteBookController).getNotes()!.length,
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemBuilder: (context, index) {
          var note = ref.watch(noteBookController).getNotes();
          var singleNote = note?[index];
          return ListTile(
            title: Row(children: [
              const Icon(Icons.notes),
              const SizedBox(width: 10),
              Text(singleNote!.noteTitle)
            ]),
            subtitle:
                //TODO: Fix the chip to use a list builder as well but horizontally
                Column(
              children: [
                Text(
                    'Date created: ${representDateTime(singleNote.dateCreated)}'),
                Text(
                    'Date modified: ${representDateTime(singleNote.dateModified)}'),
                Chip(label: Text(singleNote.tags.toString())),
              ],
            ),
            onTap: () => Get.to(() => NoteEditor(
                // noteBookID: noteBookID,
                noteId: index,
                doc: singleNote.document,
                title: singleNote.noteTitle,
                dateModified: singleNote.dateModified)),
          );
        });
  }
}
