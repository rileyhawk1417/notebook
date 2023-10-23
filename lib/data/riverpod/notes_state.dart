import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_book/data/models/notes_class.dart';
import 'package:note_book/data/models/notes_model.dart';

final noteBookController = ChangeNotifierProvider<NoteBookController>((ref) {
  final noteBookData = ref.watch(noteBookService);
  return NoteBookController(noteBookData);
});

class NoteBookController extends ChangeNotifier {
  NoteBookController(this._noteBookModel);
  late final NoteClass _noteBookModel;

  void prepData() {
    _noteBookModel.prepData();
  }

  void addNote(NoteModel note, int index, String notebookName) {
    _noteBookModel.addNote(note, notebookName, index);
    notifyListeners();
  }

  void addNoteBook(String noteBookTitle) {
    NoteBookModel newNoteBook = NoteBookModel(noteTitle: noteBookTitle);
    _noteBookModel.addNoteBook(newNoteBook);
    notifyListeners();
  }

  void deleteNote(int noteBookIndex, int noteIndex) {
    _noteBookModel.deleteNote(noteBookIndex, noteIndex);
    notifyListeners();
  }

  void deleteNoteBook(int noteBookIndex) {
    _noteBookModel.deleteNoteBook(noteBookIndex);
    notifyListeners();
  }

  List<int>? syncNoteBooks() {
    return _noteBookModel.loadNoteBookKeys();
  }

//TODO: Clean up this method might not be usedl
  List<NoteModel>? syncNotes(int noteBookID) {
    return _noteBookModel.loadNotes(noteBookID);
  }
//TODO: Same with the one above
  int getNoteBooksLength() {
    return _noteBookModel.noteBookBox.keys.length;
  }
}

final noteBookService = Provider<NoteClass>((_) => NoteClass());