import 'package:note_book/data/isar/isar_service.dart';
import 'package:note_book/data/isar/note.dart';
import 'package:note_book/data/isar/tags.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'isar_riverpod_tags.g.dart';

@riverpod
class TagRp extends _$TagRp {
  final IsarService isar = IsarService();

  @override
  FutureOr<List<Tags>> build() {
    return isar.getAllTags();
  }

  Future<void> saveTag(Tags tag) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await isar.saveTags(tag);
      return isar.getAllTags();
    });
  }

  Future<void> saveExistingTag(Tags tag) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await isar.saveExistingTags(tag);
      return isar.getAllTags();
    });
  }

  Future<void> deleteTag(int id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await isar.deleteTag(id);
      return isar.getAllTags();
    });
  }
/*
  Future<Tags?> getTagByName(String name, int? id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final tag = await isar.getTagByName(name);
      final finalValue = AsyncValue.data(tag);
      return tag;
    });
    return state.value!.first;
  }
  */

  Future<List<Tags>?> getNoteTags(int id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final tags = await isar.getNoteTags(id);

      final val = AsyncValue.data(tags);
      return val.value!;
    });
    return state.value;
  }

  Future<List<Tags>?> getNoteBookTags(int id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final tags = await isar.getNoteBookTags(id);
      final finalValue = AsyncValue.data(tags);
      return finalValue.value!;
    });
    return state.value;
  }
}
