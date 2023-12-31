import 'package:isar/isar.dart';
import 'package:note_book/data/isar/note.dart';
import 'package:note_book/data/isar/tags.dart';

part 'notebook.g.dart';

@Collection()
class NoteBook {
  /*
  * Add backlink to Note <> Tag
  * Add backlink to Note <> Notebook
  * */
  Id id = Isar.autoIncrement;
  late String title;
  bool favorite = false;
  bool isPinned = false;
  late String dateCreated;
  late String dateModified;
  final tags = IsarLinks<Tags>();
  final notes = IsarLinks<Note>();
}
