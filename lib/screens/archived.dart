import 'package:flutter/material.dart';
import 'package:note_book/components/drawer.dart';

class ArchivedScreen extends StatelessWidget {
  const ArchivedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('Archived')),
        drawer: const SideDrawer(),
        body: const Center(
          child: Text('Archived'),
        ));
  }
}
