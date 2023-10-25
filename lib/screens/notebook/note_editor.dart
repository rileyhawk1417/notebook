import 'dart:async';
import 'dart:convert';

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_book/data/riverpod/notes_state.dart';
import 'package:note_book/data/utils/date_convertor.dart';

class NoteEditor extends ConsumerWidget {
  const NoteEditor(
      {super.key,
      required this.doc,
      required this.title,
      this.dateModified,
      required this.noteBookID,
      required this.noteId});
  final Map<String, dynamic> doc;
  final String title;
  final String? dateModified;
  final int noteBookID;
  final int noteId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _encodedNote = jsonEncode(doc);
    final editorState = EditorState(
        document: Document.fromJson(
            Map<String, dynamic>.from(json.decode(_encodedNote))));
    final editorScrollController =
        EditorScrollController(editorState: editorState);
    //NOTE: Trigger timer only when widget is open
    //NOTE: Figure out a way to use the auto dispose function
    /*
    var _autoSave = Timer.periodic(const Duration(seconds: 5), (timer) {
      print('hi');
      FutureProvider.autoDispose((ref) async {
        ref.onDispose(() {
          timer.cancel();
        });

        ref.keepAlive();
      });
    });
    */
    void autoSave() {
      ref
          .watch(noteBookController)
          .saveNote(noteBookID, noteId, editorState.document.toJson());
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Edit Note'),
        actions: [
          //TODO: Sort out the menu button
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: MaterialButton(
                        onPressed: () {},
                        child: const Text('Edit'),
                      ),
                    ),
                    PopupMenuItem(
                      child: MaterialButton(
                        onPressed: () {},
                        child: const Text('Share'),
                      ),
                    ),
                  ])
        ],
      ),
      body: AppFlowyEditor(
          editorState: editorState,
          editorScrollController: editorScrollController,
          //TODO: Pass in the title of the document
          header: Text(title),
          //TODO: Add date modification
          footer: Text('Modified on: ${representDateTime(dateModified!)}')),
    );
  }
}
