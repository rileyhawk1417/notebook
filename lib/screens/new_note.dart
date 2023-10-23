import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';

//MIght just remove this class entirely?
class NewNote extends StatefulWidget {
  const NewNote({Key? key}) : super(key: key);

  @override
  NewNoteState createState() => NewNoteState();
}

class NewNoteState extends State<NewNote> {
  @override
  Widget build(BuildContext context) {
    final editorState = EditorState.blank();
    final editorScrollController =
        EditorScrollController(editorState: editorState);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('New Note'),
        actions: [
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
          //TODO Add date modified & title
          header: const Text('Title'),
          footer: const Text('Date Modified')),
    );
  }
}
