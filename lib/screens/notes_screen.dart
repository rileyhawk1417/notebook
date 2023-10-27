import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_book/components/drawer.dart';
import 'package:note_book/components/notes_list.dart';

class NotesScreen extends ConsumerWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('NoteBooks')),
        drawer: const SideDrawer(),
        body: const Center(
          child: NoteList(),
        ));
  }
}
