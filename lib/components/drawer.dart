import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_book/main.dart';
import 'package:note_book/screens/about.dart';
import 'package:note_book/screens/archived.dart';
import 'package:note_book/screens/favorites.dart';
import 'package:note_book/screens/settings.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
          color: Colors.blue.shade200,
          child: ListView(
            children: [
              const DrawerHeader(child: Icon(Icons.notes)),
              ListTile(
                leading: const Icon(Icons.notes),
                title: const Text('Notes'),
                onTap: () => Get.to(() => const MyHomePage(title: 'Notes')),
              ),
              ListTile(
                  leading: const Icon(Icons.favorite),
                  title: const Text('Favourites'),
                  onTap: () => Get.to(() => const FavouritesScreen())),
              ListTile(
                  leading: const Icon(Icons.archive),
                  title: const Text('Archived'),
                  onTap: () => Get.to(() => const ArchivedScreen())),
              ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () => Get.to(() => const SettingsScreen())),
              ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('About'),
                  onTap: () => Get.to(() => const AboutScreen())),
            ],
          )),
    );
  }
}
