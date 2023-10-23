import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_book/data/default_note.dart';
import 'package:note_book/data/models/notes_model.dart';

String noteBox = 'notebook_hive_box';
String noteBookLabel = 'notes';

class NoteClass {
  final _noteBookBox = Hive.box<NoteBookModel>(noteBox);
  Box<NoteBookModel> get noteBookBox => _noteBookBox;

  Future<void> prepData() async {
    if (_noteBookBox.isEmpty) {
      createSampleData();
    } else {
      loadNoteBookKeys();
    }
  }

  Future<void> createSampleData() async {
    NoteModel note1 = NoteModel(noteTitle: 'First Note', document: noteExample);
    NoteModel note2 =
        NoteModel(noteTitle: 'Second Note', document: note2Example);
    NoteBookModel notebook1 =
        NoteBookModel(noteTitle: 'First Notebook', noteBooks: [note1, note2]);
    _noteBookBox.add(notebook1);
  }

  List<int> loadNoteBookKeys() {
    return _noteBookBox.keys.cast<int>().toList();
  }

  List<NoteModel>? loadNotes(int noteBookID) {
    return _noteBookBox.get(noteBookID)?.noteBooks;
  }

  void addNoteBook(NoteBookModel notebook) {
    _noteBookBox.add(notebook);
  }

  void addNote(NoteModel note, String notebookName, int? index) {
    _noteBookBox.values.where((notebook) {
      if (notebook.noteTitle == notebookName) {
        notebook.noteBooks?.add(note);
        _noteBookBox.putAt(index!, notebook);
        //TODO: Figure out how to get current notebook then add
        // _noteBookBox.add(notebook);
        return true;
      } else {
        NoteBookModel untitledNoteBook =
            NoteBookModel(noteTitle: 'untitled', noteBooks: [note]);
        _noteBookBox.add(untitledNoteBook);
      }
      return false;
    });
  }

  void editNote(
      NoteBookModel noteBook, NoteModel note, int noteBookIndex, String title) {
    var specifiedNoteBook = _noteBookBox.getAt(noteBookIndex);
    specifiedNoteBook?.noteBooks?.where((notes) {
      if (notes.noteTitle == title) {
        notes.document = note.document;
        //TODO: Insert at a specific index
        return true;
      }
      return false;
    });
  }

  void deleteNote(int noteBookIndex, int noteIndex) {
    var notebook = _noteBookBox.getAt(noteBookIndex)?.noteBooks;
    notebook?.removeAt(noteIndex);
  }

  void deleteNoteBook(int noteBookIndex) {
    _noteBookBox.deleteAt(noteBookIndex);
  }
}
