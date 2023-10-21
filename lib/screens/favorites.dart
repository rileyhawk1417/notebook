import 'package:flutter/material.dart';
import 'package:note_book/components/drawer.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Favorites'),
      ),
      drawer: const SideDrawer(),
      body: const Center(
        child: Text('Favourites'),
      ),
    );
  }
}
