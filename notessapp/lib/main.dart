import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:notessapp/note/note_hive_helper.dart';
import 'package:notessapp/note/note_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();
  await Hive.openBox(NoteHiveHelper.noteBox);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: NoteScreen());
  }
}
