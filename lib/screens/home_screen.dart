import 'package:flutter/material.dart';
import 'package:note_book/components/header.dart';
import 'package:note_book/components/notebook_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        HeaderBar(),
        Expanded(
          child: NoteBookList(),
        ),
      ],
    );
  }
}
