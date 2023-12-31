import 'package:note_book/data/isar/isar_service.dart';
import 'package:note_book/data/isar/notebook.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'isar_riverpod_notebooks.g.dart';

@riverpod
class NoteBookRp extends _$NoteBookRp {
  final IsarService isar = IsarService();

  @override
  FutureOr<List<NoteBook>> build() {
    return isar.getAllNoteBooks();
  }

  Future<void> saveNoteBook(NoteBook noteBook) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await isar.saveNoteBook(noteBook);
      return isar.getAllNoteBooks();
    });
  }

  Future<void> saveExistingNoteBoo(NoteBook noteBook) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await isar.saveExistingNoteBook(noteBook);
      return isar.getAllNoteBooks();
    });
  }

  Future<void> deleteNoteBook(int id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await isar.deleteNoteBook(id);
      return isar.getAllNoteBooks();
    });
  }
/*
  FutureOr<NoteBook> getNoteBookByName(String name, int? id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final noteBooks = await isar.getNoteBookByName(name);
      return state;
    });
    return state;
  }

  FutureOr<Note> getNoteBooksByName(String name) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final noteBooks = await isar.getNoteBooksByName(name);
      return noteBooks;
    });
    return state;
  }
  */
}
