import 'package:hive_flutter/hive_flutter.dart';
import 'package:isar/isar.dart';

part 'notes_model.g.dart';

@HiveType(typeId: 1)
class NoteBookModel {
  @HiveField(0)
  String noteTitle;
  @HiveField(1)
  List<NoteModel>? noteBooks;
  @HiveField(2)
  List<String>? tags;
  NoteBookModel({required this.noteTitle, this.noteBooks, this.tags});
}

@HiveType(typeId: 2)
class NoteModel {
  @HiveField(0)
  String noteTitle;
  @HiveField(1)
  Map<String, dynamic> document;
  @HiveField(2)
  List<String>? tags;
  NoteModel({required this.noteTitle, required this.document, this.tags});
}
