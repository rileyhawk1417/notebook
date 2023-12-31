import 'package:isar/isar.dart';

part 'isar_data.g.dart';

@Collection()
class NoteBook {
  Id id = Isar.autoIncrement;
  late String name;
  final noteBookName = IsarLinks<Note>();
  late List<String> tags;
  late String dateCreated;
  late String dateModified;
}

@Collection()
class Note {
  Id id = Isar.autoIncrement;
  late String name;
  @ignore
  late Map<String, dynamic>? doc;
  @Backlink(to: 'noteBookName')
  final noteBookName = IsarLinks<NoteBook>();
  late List<String> tags;
  late String dateCreated;
  late String dateModified;
}
/*
class IsarService {
  late Future<Isar> db;
  IsarService() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([NoteBookSchema, NoteSchema],
          directory: '/home/riley/Documents', inspector: true);
    }
    return Future.value(Isar.getInstance());
  }
  
}
*/
