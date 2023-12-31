import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:note_book/data/isar/adapters.dart';
import 'package:note_book/data/isar/note.dart';
import 'package:note_book/data/riverpod/isar_riverpod_notes.dart';
import 'package:note_book/screens/notebook/note_editor.dart';

class NoteList extends ConsumerWidget {
  const NoteList({super.key, this.noteList});
  final AsyncValue<List<Note>>? noteList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncNotes = ref.watch(notesProvider);
    return switch (asyncNotes) {
      AsyncData(:final value) => NotesListView(noteData: value),
      AsyncError(:final error) => Text('Error: $error'),
      _ => const Center(
          child: CircularProgressIndicator.adaptive(),
        )
    };
  }
}

class NotesListView extends ConsumerWidget {
  const NotesListView({
    super.key,
    required this.noteData,
  });
  final List<Note> noteData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (noteData.isEmpty) {
      return const Text('No Notes To Display');
    }
    return ListView.separated(
        itemCount: noteData.length,
        separatorBuilder: (ctx, index) => const Divider(
              indent: 44.0,
              endIndent: 44.0,
            ),
        itemBuilder: (ctx, index) {
          var singleNote = noteData[index];
          return Slidable(
            key: ValueKey(singleNote.id),
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
              title: Row(children: [
                const Icon(Icons.notes),
                const SizedBox(width: 10),
                Text(singleNote.title)
              ]),
              subtitle:
                  //TODO: Fix the chip to use a list builder as well but horizontally
                  SizedBox(
                width: 50.0,
                height: 94.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Date created: ${singleNote.dateCreated}'),
                    Text('Date modified: ${singleNote.dateModified}'),
                    singleNote.tags.isEmpty
                        ? const SizedBox.shrink()
                        : Chip(
                            label: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: singleNote.tags.length,
                                itemBuilder: (ctx, index) {
                                  final tag = singleNote.tags.toList();
                                  return Text(tag[index].title);
                                })),
                  ],
                ),
              ),
              onTap: () => Get.to(
                () => NoteEditor(
                  noteId: singleNote.id,
                  doc: MapStringAdapter.stringDocToMap(singleNote.content),
                  title: singleNote.title,
                  dateModified: singleNote.dateModified,
                  tagList: singleNote.tags.toList(),
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.more_horiz),
                onPressed: () =>
(),
              ),
            ),
          );
        });
  }
}
