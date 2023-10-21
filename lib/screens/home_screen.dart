import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_book/components/header.dart';
import 'package:note_book/components/notes_list.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        HeaderBar(),
        Expanded(
          child: NotesList(),
        ),
      ],
    );
  }
}
