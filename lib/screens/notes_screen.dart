import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:note_book/components/drawer.dart';
import 'package:note_book/components/notes_list.dart';
import 'package:note_book/data/riverpod/isar_riverpod_notes.dart';
import 'package:note_book/screens/notebook/note_editor.dart';

class NotesScreen extends ConsumerWidget {
  const NotesScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncNotes = ref.watch(notesProvider);
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('Notes')),
        drawer: const SideDrawer(),
        body: Center(
          child: switch (asyncNotes) {
            AsyncData(:final value) => NotesListView(noteData: value),
            AsyncError(:final error) => Text('Error: $error'),
            _ => const CircularProgressIndicator.adaptive()
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.to(() => const NoteEditor()),
          tooltip: 'Add new note',
          child: const Icon(Icons.add),
        ));
  }
}
