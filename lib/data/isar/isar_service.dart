import 'dart:io';

import 'package:isar/isar.dart';
import 'package:note_book/data/default_note.dart';
import 'package:note_book/data/isar/adapters.dart';
import 'package:note_book/data/utils/date_convertor.dart';
import 'package:path_provider/path_provider.dart';
import './note.dart';
import './tags.dart';
import './notebook.dart';

class IsarService {
  static late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<void> prepData() async {
    final isar = await db;
    if (isar.notes.where().isEmptySync()) {
      createSampleData();
    } else {}
  }

  Future<void> createSampleData() async {
    final isar = await db;
    final note_1 = Note()
      ..title = 'Hello World'
      ..content = MapStringAdapter.mapDocToString(noteExample)
      ..dateCreated = todaysDateFormatted()
      ..dateModified = todaysDateFormatted();

    final note_2 = Note()
      ..title = 'Hello World 2'
      ..content = MapStringAdapter.mapDocToString(noteExample)
      ..dateCreated = todaysDateFormatted()
      ..dateModified = todaysDateFormatted();

    isar.writeTxn(() => isar.notes.put(note_1));
    isar.writeTxn(() => isar.notes.put(note_2));
  }

  /// ************** NOTE: Note Methods **************
  Future<List<Note>> getAllNotes() async {
    final isar = await db;
    return await isar.notes.where().findAll();
  }

  Future<Note?> getNote(String title, int? id) async {
    final isar = await db;
    if (id != null) {
      //
    }
    final selectedNoteTitle =
        await isar.notes.filter().titleContains(title).findFirst();
    final selectedNoteId = await isar.notes.filter().idEqualTo(id!).findFirst();
    if (selectedNoteTitle != null) {
      return selectedNoteTitle;
    }
    if (selectedNoteId != null) {
      return selectedNoteId;
    }
    return null;
  }

  Future<List<Note>?> getNotes(String name) async {
    final isar = await db;
    final notes = await isar.notes.filter().titleContains(name).findAll();
    return notes;
  }

  Future<void> saveNote(Note newNote) async {
    final isar = await db;
    await isar.writeTxn<int>(() => isar.notes.put(newNote));
  }

  Future<void> saveExistingNote(Note existingNote) async {
    final isar = await db;
    await isar.writeTxn(() async {
      final updatedNote = await isar.notes.get(existingNote.id);
      updatedNote?.content = existingNote.content;
      updatedNote?.title = existingNote.title;
      updatedNote?.dateModified = existingNote.dateModified;
      isar.notes.put(updatedNote!);
    });
  }

  Future<void> deleteNote(int id) async {
    final isar = await db;
    final findNote = await isar.notes.get(id);
    if (findNote == null) {
      //
    }
    await isar.writeTxn(() async {
      await isar.notes.delete(findNote!.id);
    });
  }

  /// ************** NOTE: NoteBook Methods **************
  Future<List<NoteBook>> getAllNoteBooks() async {
    final isar = await db;
    return await isar.noteBooks.where().findAll();
  }

  Future<NoteBook?> getNoteBook(Note note) async {
    final isar = await db;
    final notebook = await isar.noteBooks
        .filter()
        .notes((q) => q.idEqualTo(note.id))
        .findFirst();
    return notebook;
  }

  Future<List<Note>?> getNoteBookNotes(int noteBookID) async {
    final isar = await db;

    final notes = await isar.notes
        .filter()
        .notebook((q) => q.idEqualTo(noteBookID))
        .findAll();
    return notes;
  }

  Future<void> saveNoteBook(NoteBook existingNoteBook) async {
    final isar = await db;
    isar.writeTxn(() async {
      final updatedNoteBook = await isar.noteBooks.get(existingNoteBook.id);
      updatedNoteBook?.title = existingNoteBook.title;
      updatedNoteBook?.notes.addAll(existingNoteBook.notes);
      updatedNoteBook?.tags.addAll(existingNoteBook.tags);
      updatedNoteBook?.dateModified = existingNoteBook.dateModified;
    });
  }

  Future<void> saveExistingNoteBook(NoteBook newNoteBook) async {
    final isar = await db;
    isar.writeTxn<int>(() => isar.noteBooks.put(newNoteBook));
  }

  Future<NoteBook> getNoteBookByName(String name) async {
    final isar = await db;
    final selectedNoteBook =
        await isar.noteBooks.filter().titleContains(name).findFirst();
    if (selectedNoteBook == null) {
      //
    }
    return selectedNoteBook!;
  }

  Future<List<NoteBook>> getNoteBooksByName(String name) async {
    final isar = await db;
    final selectedNoteBook =
        await isar.noteBooks.filter().titleContains(name).findAll();
    return selectedNoteBook;
  }

  Future<void> deleteNoteBook(int id) async {
    final isar = await db;
    final findNoteBook = await isar.noteBooks.get(id);
    if (findNoteBook == null) {
      //
    }
    await isar.writeTxn(() async {
      await isar.noteBooks.delete(findNoteBook!.id);
    });
  }

  /// ************** NOTE: Tag Methods **************
  Future<List<Tags>> getAllTags() async {
    final isar = await db;
    return isar.tags.where().findAll();
  }

  Future<void> saveTags(Tags newTags) async {
    final isar = await db;
    isar.writeTxn<int>(() => isar.tags.put(newTags));
  }

  Future<void> saveExistingTags(Tags existingTag) async {
    final isar = await db;
    isar.writeTxn(() async {
      final updatedTag = await isar.tags.get(existingTag.id);
      updatedTag?.notes.addAll(existingTag.notes);
      updatedTag?.title = existingTag.title;
    });
  }

  Future<Tags> getTagByName(String name) async {
    final isar = await db;
    final foundTag =
        await isar.tags.where().filter().titleContains(name).findFirst();
    if (foundTag == null) {
      //
    }
    return foundTag!;
  }

  Future<List<Tags>> getNoteBookTags(int id) async {
    final isar = await db;
    return await isar.tags.filter().noteBooks((q) => q.idEqualTo(id)).findAll();
  }

  Future<List<Tags>> getNoteTags(int id) async {
    final isar = await db;
    return await isar.tags.filter().notes((q) => q.idEqualTo(id)).findAll();
  }

  Future<void> deleteTag(int id) async {
    final isar = await db;
    final findTag = await isar.tags.get(id);
    if (findTag == null) {
      //
    }
    await isar.writeTxn(() async {
      await isar.tags.delete(findTag!.id);
    });
  }

//WARN: Do not use this
  Stream<List<Note>> listenToNotes() async* {
    final isar = await db;
    /*NOTE: Fire immediately just updates the state quickly
    Since we want to avoid hitting the DB too hard.
    We will just use ref.read, which invalidates the previous value
    then updates it with the new value.
    NOTE: I believe by default Isar send has a `notifylisteners()`
    call on every CRUD operation. WatchLazy does let you know that
    something has changed but thats it.
    Even if you add a notifylisteners() the db just duplicates the result.
    So for now a FutureBuilder with ref.read will just work.
   */
    yield* isar.notes.where().watch(fireImmediately: true);
  }


  Future<void> cleanDB() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

  static Future<Isar> openDB() async {
    Directory phoneDocFolder = await getApplicationDocumentsDirectory();
    Future<Directory> notebookDefaultPath =
        Directory('${phoneDocFolder.path}/note_book').create();
    Directory docPath = await notebookDefaultPath;
//BUG: custom db name breaks Isar completely
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([NoteSchema, TagsSchema, NoteBookSchema],
          directory: docPath.path, inspector: true);
    }
    return Future.value(Isar.getInstance());
  }
}
