import 'package:hive_ce/hive.dart';

class NoteHiveHelper {
  static var noteBox = "NoteBox";
  static var noteKey = "noteKey";

  static List<String> notes = [];

  static void addNote(String noteText) {
    notes.add(noteText);
    Hive.box(noteBox).put(noteKey, notes);
  }

  static void updateNote(String noteText, int i) {
    notes[i] = noteText;
    Hive.box(noteBox).put(noteKey, notes);
  }

  static void deleteNote(int i) {
    notes.removeAt(i);
    Hive.box(noteBox).put(noteKey, notes);
  }

  static void deleteAllNote() {
    notes.clear();
    Hive.box(noteBox).put(noteKey, notes);
  }

  static Future<void> getAllNote() async {
    notes = await Hive.box(noteBox).get(noteKey) ?? [];
    await Future.delayed(Duration(seconds: 3));
  }
}


///(1) Add Note
///(2) Edit Note
///(3) Delete Note
///(4) Delete all notes
///(5) Get all notes