import 'package:isar/isar.dart';
import 'package:note_book/data/isar/notebook.dart';
import 'package:note_book/data/isar/tags.dart';
import 'package:uuid/uuid.dart';

part 'note.g.dart';

@Collection()
class Note {
  /*
  * Add backlink to Note <> Tag
  * Add backlink to Note <> Notebook
  * */
  Id id = Isar.autoIncrement;
  late String title;
  late String content;
  bool favorite = false;
  bool isPinned = false;
  late String dateCreated;
  late String dateModified;

  @Backlink(to: 'notes')
  final notebook = IsarLinks<NoteBook>();

  @Backlink(to: 'notes')
  final tags = IsarLinks<Tags>();
}
