import 'package:flutter/material.dart';
import 'package:note_book/components/drawer.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Settings'),
        ),
        drawer: const SideDrawer(),
        body: const Center(child: Text('Settings')));
  }
}
