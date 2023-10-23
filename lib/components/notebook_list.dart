import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_book/data/models/notes_class.dart';
import 'package:note_book/data/models/notes_model.dart';
import 'package:note_book/data/riverpod/notes_state.dart';
import 'package:note_book/screens/notebook/notes.dart';

class NoteBookList extends ConsumerWidget {
  const NoteBookList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noteBookLength = ref.watch(noteBookController).syncNoteBooks();
    final box = Hive.box<NoteBookModel>(noteBox);
    return ListView.separated(
        itemCount: noteBookLength!.length,
        separatorBuilder: (context, idx) =>
            const SizedBox(width: 50, height: 8),
        itemBuilder: (context, index) {
          print(noteBookLength.length);
          int keyList = noteBookLength[index];
          NoteBookModel? _noteBook = box.get(keyList);
          for (var i in _noteBook!.noteBooks!) {
            print(i.noteTitle);
          }
          return Slidable(
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
                tileColor: Colors.blue.shade400,
                title: Text(_noteBook.noteTitle),
                /*
                subtitle: Text(_note),
                trailing: const Icon(Icons.more_horiz),
                */
                onTap: () => Get.to(() =>
                    NotesListScreen(selectedNoteBook: _noteBook, id: index))),
          );
        });
  }
}
