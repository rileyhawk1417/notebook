import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NoteModel {
  String title;
  String? desc;
  String date;
  String note;
  NoteModel({
    required this.title,
    this.desc,
    required this.date,
    required this.note,
  });
}

List notesList = [
  NoteModel(title: 'H', note: 'Hello World', date: '20/10/23'),
  NoteModel(title: 'H', note: 'Hello World', date: '20/10/23'),
  NoteModel(title: 'H', note: 'Hello World', date: '20/10/23'),
  NoteModel(title: 'H', note: 'Hello World', date: '20/10/23'),
  NoteModel(title: 'H', note: 'Hello World', date: '20/10/23'),
  NoteModel(title: 'H', note: 'Hello World', date: '20/10/23'),
  NoteModel(title: 'H', note: 'Hello World', date: '20/10/23'),
  NoteModel(title: 'H', note: 'Hello World', date: '20/10/23'),
  NoteModel(title: 'H', note: 'Hello World', date: '20/10/23'),
  NoteModel(title: 'H', note: 'Hello World', date: '20/10/23'),
  NoteModel(title: 'H', note: 'Hello World', date: '20/10/23'),
  NoteModel(title: 'H', note: 'Hello World', date: '20/10/23'),
  NoteModel(title: 'H', note: 'Hello World', date: '20/10/23'),
];

class NotesList extends ConsumerWidget {
  const NotesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
        itemCount: notesList.length,
        separatorBuilder: (context, idx) =>
            const SizedBox(width: 50, height: 8),
        itemBuilder: (context, count) {
          return Slidable(
            startActionPane: ActionPane(
              motion: const StretchMotion(),
              children: [
                SlidableAction(onPressed: (context) {}, icon: Icons.archive)
              ],
            ),
            endActionPane: ActionPane(
              motion: const StretchMotion(),
              children: [
                SlidableAction(onPressed: (context) {}, icon: Icons.edit),
                SlidableAction(onPressed: (context) {}, icon: Icons.delete)
              ],
            ),
            child: ListTile(
                tileColor: Colors.blue.shade400,
                title: Text(notesList[count].title),
                subtitle: Text(notesList[count].date),
                trailing: const Icon(Icons.more_horiz),
                onTap: () => {}),
          );
        });
  }
}
