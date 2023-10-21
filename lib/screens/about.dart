import 'package:flutter/material.dart';
import 'package:note_book/components/drawer.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('About')),
        drawer: const SideDrawer(),
        body: const Center(child: Text('About')));
  }
}
