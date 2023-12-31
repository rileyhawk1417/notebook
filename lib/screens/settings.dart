import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_book/components/drawer.dart';
import 'package:note_book/data/isar/isar_service.dart';
import 'package:note_book/data/riverpod/isar_riverpod_notes.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final IsarService service = IsarService();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Settings'),
        ),
        drawer: const SideDrawer(),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Settings Page'),
              const Text('Work In Progress'),
              MaterialButton(
                  onPressed: () => ref.read(notesProvider.notifier).clearDB(),
                  color: Colors.red,
                  child: const Text('Clear DB'))
            ],
          ),
        ));
  }
}
