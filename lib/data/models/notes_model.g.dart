// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteBookModelAdapter extends TypeAdapter<NoteBookModel> {
  @override
  final int typeId = 1;

  @override
  NoteBookModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteBookModel(
      noteTitle: fields[0] as String,
      noteBooks: (fields[1] as List?)?.cast<NoteModel>(),
      tags: (fields[2] as List?)?.cast<String>(),
      dateCreated: fields[3] as String,
      dateModified: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NoteBookModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.noteTitle)
      ..writeByte(1)
      ..write(obj.noteBooks)
      ..writeByte(2)
      ..write(obj.tags)
      ..writeByte(3)
      ..write(obj.dateCreated)
      ..writeByte(4)
      ..write(obj.dateModified);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteBookModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NoteModelAdapter extends TypeAdapter<NoteModel> {
  @override
  final int typeId = 2;

  @override
  NoteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteModel(
      noteTitle: fields[0] as String,
      document: (fields[1] as Map).cast<String, dynamic>(),
      tags: (fields[2] as List?)?.cast<String>(),
      dateCreated: fields[3] as String,
      dateModified: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NoteModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.noteTitle)
      ..writeByte(1)
      ..write(obj.document)
      ..writeByte(2)
      ..write(obj.tags)
      ..writeByte(3)
      ..write(obj.dateCreated)
      ..writeByte(4)
      ..write(obj.dateModified);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
