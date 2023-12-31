import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:note_book/data/default_note.dart';
import 'package:note_book/data/isar/adapters.dart';
import 'package:note_book/data/isar/isar_service.dart';
import 'package:note_book/data/isar/note.dart';
import 'package:note_book/data/isar/notebook.dart';
import 'package:note_book/screens/notebook/notes.dart';

class NoteBookList extends ConsumerWidget {
  const NoteBookList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /*
    ref.read(noteController).saveNoteBook(NoteBook()
      ..title = 'Sample'
      ..dateCreated = ''
      ..dateModified = '');
      */
    /*
    ref.read(noteController).saveNote(Note()
      ..title = 'Sample'
      ..content = MapStringAdapter.mapDocToString(noteExample)
      ..dateCreated = ''
      ..dateModified = '');
      */
    // ref.read(noteController).watchNoteBooks();
    final noteBooks = [];

    if (noteBooks.isEmpty) {
      return const Center(child: Text('No notebooks found'));
    }

    return ListView.separated(
        itemCount: noteBooks.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final noteBook = noteBooks[index];
          return Slidable(
            key: ValueKey(noteBook.id),
            startActionPane: ActionPane(
              motion: const StretchMotion(),
              children: [
                SlidableAction(onPressed: (context) {}, icon: Icons.archive)
              ],
            ),
            endActionPane: ActionPane(
              motion: const StretchMotion(),
              children: [
                SlidableAction(onPressed: (context) {}, icon: Icons.edit),
                SlidableAction(onPressed: (context) {}, icon: Icons.delete)
              ],
            ),
            child: ListTile(
                title: Row(
                  children: [
                    const Icon(Icons.folder),
                    const SizedBox(width: 10),
                    Text('${noteBook.title}$index')
                  ],
                ),
                subtitle: Column(children: [
                  Text('Date Created: ${noteBook.dateCreated}'),
                  Text('Date Modified: ${noteBook.dateModified}')
                ]),
                /*
                subtitle: Text(_note),
                trailing: const Icon(Icons.more_horiz),
                */
                onTap: () => Get.to(() => NotesListScreen(
                    selectedNoteBook: noteBook, id: noteBook.id))),
          );
        });
  }
}
