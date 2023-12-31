import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_book/data/isar/adapters.dart';
import 'package:note_book/data/isar/note.dart';
import 'package:note_book/data/isar/tags.dart';
import 'package:note_book/data/riverpod/isar_riverpod_notes.dart';
import 'package:note_book/data/utils/date_convertor.dart';

class SetEditorStyle {
  EditorStyle setEditorStyle() {
    if (Platform.isAndroid) {
      return const EditorStyle.mobile();
    }
    return const EditorStyle.desktop();
  }
}

class NoteEditor extends ConsumerWidget {
  const NoteEditor(
      {super.key,
      this.doc,
      this.title,
      this.dateModified,
      this.dateCreated,
      this.noteBookID,
      this.noteId,
      this.tagList});
  final Map<String, dynamic>? doc;
  final String? title;
  final String? dateModified;
  final String? dateCreated;
  final int? noteBookID;
  final int? noteId;
  final List<Tags>? tagList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    EditorState editorState;
    if (doc == null) {
      editorState = EditorState.blank();
    } else {
      final _encodedNote = jsonEncode(doc);
      editorState = EditorState(
          document: Document.fromJson(
              Map<String, dynamic>.from(json.decode(_encodedNote))));
    }
    final editorScrollController =
        EditorScrollController(editorState: editorState);
    TextEditingController titleTextController = TextEditingController();
    titleTextController.text = title ?? 'New Note';

    Timer? _autoSave;
    void autoSave() async {
      if (noteId != null && title != null) {
        print('Existing note');

        ref.read(notesProvider.notifier).saveExistingNote(Note()
          ..id = noteId!
          ..title = titleTextController.value.text
          ..content =
              MapStringAdapter.mapDocToString(editorState.document.toJson())
          ..dateCreated = dateModified!
          ..dateModified = todaysDateFormatted());
      } else {
        print('New note');
        ref.read(notesProvider.notifier).saveNote(Note()
          ..title = titleTextController.value.text
          ..content =
              MapStringAdapter.mapDocToString(editorState.document.toJson())
          ..dateCreated = todaysDateFormatted()
          ..dateModified = todaysDateFormatted());
      }
    }

/*
//NOTE: This would be something to add later
    _autoSave = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (context.mounted) {
        autoSave();
      } else {
        timer.cancel();
      }
    });
    */

    return PopScope(
      onPopInvoked: (boolean) => autoSave(),
      child: Scaffold(
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppFlowyEditor(
            editorStyle: SetEditorStyle().setEditorStyle(),
            editorState: editorState,
            editorScrollController: editorScrollController,
            //TODO: Pass in the title of the document
            header: TextField(
              decoration: const InputDecoration(
                  disabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none),
              controller: titleTextController,
            ),
            footer: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                      'Created on: ${dateCreated != null ? representDateTime(dateCreated!) : todaysDateFormatted()}'),
                  Text(
                      'Modified on: ${dateModified != null ? representDateTime(dateModified!) : todaysDateFormatted()}'),
                  tagList == null
                      ? const SizedBox.shrink()
                      : SizedBox(
                          height: 40.0,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: tagList?.length,
                              itemBuilder: (ctx, index) =>
                                  Text('# ${tagList![index].title}')),
                        ),
                ]),
          ),
        ),
      ),
    );
  }
}
