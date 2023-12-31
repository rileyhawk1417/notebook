import 'package:note_book/data/isar/isar_service.dart';
import 'package:note_book/data/isar/note.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'isar_riverpod_notes.g.dart';

@riverpod
class Notes extends _$Notes {
  final IsarService isar = IsarService();
  List<Note> newList = [];

  Future<List<Note>> _fetchNotes() async {
    return isar.getAllNotes();
  }

  @override
  FutureOr<List<Note>> build() async {
    print('Built the list');
    return _fetchNotes();
  }

  Future<void> loadData() async {
    newList = await isar.getAllNotes();
  }

  Future<void> saveNote(Note note) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await isar.saveNote(note);
      return _fetchNotes();
    });
  }

  Future<void> saveExistingNote(Note note) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await isar.saveExistingNote(note);
      return _fetchNotes();
    });
  }

  Future<void> clearDB() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await isar.cleanDB();
      return _fetchNotes();
    });
  }

  Future<void> deleteNote(int id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await isar.deleteNote(id);
      return _fetchNotes();
    });
  }
/*
  FutureOr<Note> getNoteByName(String name, int? id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final note = await isar.getNote(name, id);
      return note;
    });
    return state;
  }

  FutureOr<Note> getNotesByName(String name) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final notes = await isar.getNotes(name);
      return notes;
    });
    return state;
  }
  */
}
