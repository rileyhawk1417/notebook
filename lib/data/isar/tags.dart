import 'package:isar/isar.dart';
import 'package:note_book/data/isar/note.dart';
import 'package:note_book/data/isar/notebook.dart';

part 'tags.g.dart';

@Collection()
class Tags {
  /*
  * Add backlink to Note <> Tag
  * Add backlink to Note <> Notebook
  * */
  Id id = Isar.autoIncrement;
  late String title;
  late String color;
  final notes = IsarLinks<Note>();
  final noteBooks = IsarLinks<NoteBook>();
}
