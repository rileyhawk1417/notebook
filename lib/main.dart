import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_book/components/drawer.dart';
import 'package:note_book/data/models/notes_class.dart';
import 'package:note_book/data/models/notes_model.dart';
import 'package:note_book/data/riverpod/notes_state.dart';
import 'package:note_book/screens/home_screen.dart';
import 'package:note_book/screens/new_note.dart';

void main() async {
  Hive.registerAdapter(NoteBookModelAdapter());
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.initFlutter();
  await Hive.openBox<NoteBookModel>(noteBox);
  final noteBookServices = NoteClass();
  await noteBookServices.prepData();

  runApp(ProviderScope(
      overrides: [noteBookService.overrideWith((_) => noteBookServices)],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        AppFlowyEditorLocalizations.delegate
      ],
      supportedLocales: const [Locale('en', 'US')],
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: const Center(
        child: HomeScreen(),
      ),
      drawer: const SideDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const NewNote()),
        tooltip: 'Add new note',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
