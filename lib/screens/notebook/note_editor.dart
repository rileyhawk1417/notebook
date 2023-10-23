import 'dart:convert';

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoteEditor extends ConsumerWidget {
  const NoteEditor({super.key, required this.doc});
  final Map<String, dynamic> doc;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _encodedNote = jsonEncode(doc);
    final editorState = EditorState(
        document: Document.fromJson(
            Map<String, dynamic>.from(json.decode(_encodedNote))));
    final editorScrollController =
        EditorScrollController(editorState: editorState);

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
          header: const Text('Title'),
          //TODO: Add date modification
          footer: const Text('Date Modified')),
    );
  }
}
