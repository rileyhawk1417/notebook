import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_book/data/isar/adapters.dart';
import 'package:note_book/data/isar/isar_service.dart';
import 'package:note_book/data/isar/note.dart';
import 'package:note_book/screens/notebook/note_editor.dart';
import 'package:note_book/data/isar/notebook.dart';

class NoteBookNoteList extends StatelessWidget {
  const NoteBookNoteList(
      {super.key, required this.noteBook, required this.noteBookID});
  final NoteBook noteBook;
  final int noteBookID;

  @override
  Widget build(BuildContext context) {
    final IsarService service = IsarService();
    Future<List<Note>?> fetchNoteBookNotes(int id) async {
      var data = await service.getNoteBookNotes(id);
      return data;
    }

    return FutureBuilder(
        future: fetchNoteBookNotes(noteBookID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (!snapshot.hasData) {
            return const Text('No Notes found');
          }
          if (snapshot.hasError) {
            return const Text('Theres an error!');
          } else {
            final data = snapshot.data!;
            return ListView.separated(
              itemCount: data.length,
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemBuilder: (context, index) {
                var note = data[index];
                return ListTile(
                  title: Row(children: [
                    const Icon(Icons.notes),
                    const SizedBox(width: 10),
                    Text(note.title)
                  ]),
                  subtitle:
                      //TODO: Fix the chip to use a list builder as well but horizontally
                      Column(
                    children: [
                      Text('Date created: ${note.dateCreated}'),
                      Text('Date modified: ${note.dateModified}'),
                      Chip(label: Text(note.tags.toString())),
                    ],
                  ),
                  onTap: () => Get.to(() => NoteEditor(
                      noteBookID: noteBookID,
                      noteId: note.id,
                      doc: MapStringAdapter.stringDocToMap(note.content),
                      title: note.title,
                      dateCreated: note.dateCreated,
                      dateModified: note.dateModified)),
                );
              },
            );
          }
        });
  }
}
