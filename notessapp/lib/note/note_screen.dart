import 'package:flutter/material.dart';
import 'package:notessapp/note/note_hive_helper.dart';
import 'package:notessapp/const.dart';
import 'package:notessapp/note/add_note_screen.dart';
import 'package:notessapp/note/edit_note_screen.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  TextEditingController controller = TextEditingController();
  bool _isLoading = false;

  final List<Color> noteColors = [
    Color(0xFFE61FD0), // Pink
    Color(0xFFFF9999), // Salmon
    Color(0xFF66FF66), // Green
    Color(0xFFFFFF66), // Yellow
    Color(0xFF66FFFF), // Cyan
    Color(0xFFCC99FF), // Purple
  ];

  void getNotes() async {
    _isLoading = true;
    setState(() {});
    await NoteHiveHelper.getAllNote();
    _isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getNotes();
    super.initState();
  }

  Color getColorForIndex(int index) {
    return noteColors[index % noteColors.length];
  }

  void _openEditScreen(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNoteScreen(
          initialText: NoteHiveHelper.notes[index],
          onSave: (updatedText) {
            NoteHiveHelper.updateNote(updatedText, index);
            setState(() {});
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          "Notes",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black.withValues(alpha: 0.8),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNoteScreen(
                onSave: (noteText) {
                  NoteHiveHelper.addNote(noteText);
                  setState(() {});
                },
              ),
            ),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: NoteHiveHelper.notes.length,
              itemBuilder: (c, i) => Dismissible(
                key: Key(i.toString()),
                background: Container(
                  margin: EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.red,
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.delete, color: Colors.white, size: 32),
                ),
                onDismissed: (direction) {
                  NoteHiveHelper.deleteNote(i);
                  setState(() {});
                },
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 12),
                  constraints: BoxConstraints(minHeight: 150),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: getColorForIndex(i),
                  ),
                  child: Stack(
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            controller.text = NoteHiveHelper.notes[i];
                            AlertDialog alert = AlertDialog(
                              title: Text("Update Note"),
                              content: TextField(controller: controller),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    NoteHiveHelper.updateNote(
                                      controller.text,
                                      i,
                                    );
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: Text("Update"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Cancel"),
                                ),
                              ],
                            );

                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              NoteHiveHelper.notes[i],
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: IconButton(
                          icon: Icon(Icons.edit, color: Colors.black87),
                          onPressed: () {
                            _openEditScreen(i);
                          },
                          padding: EdgeInsets.all(4),
                          constraints: BoxConstraints(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
