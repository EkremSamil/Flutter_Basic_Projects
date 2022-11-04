import 'package:flutter/material.dart';
import 'package:notes_app/main.dart';
import 'package:notes_app/notedao.dart';

import 'package:notes_app/notes.dart';

class detailNote extends StatefulWidget {
  Notes note;
  detailNote({
    required this.note,
  });

  @override
  State<detailNote> createState() => _detailNoteState();
}

class _detailNoteState extends State<detailNote> {
  var tfCourseName = TextEditingController();
  var tfScore1 = TextEditingController();
  var tfScore2 = TextEditingController();

  Future<void> delCourse(int note_id) async {
    await notesDao().deleteNote(note_id);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  Future<void> update(
      int note_id, String course_name, int score1, int score2) async {
    await notesDao().upgradeNote(note_id, course_name, score1, score2);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  @override
  void initState() {
    super.initState();

    var note = widget.note;
    tfCourseName.text = note.course_name;
    tfScore1.text = note.score1.toString();
    tfScore2.text = note.score2.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Note Detail"),
        actions: [
          ElevatedButton(
            child: Text(
              "Delete",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              delCourse(widget.note.note_id);
            },
          ),
          ElevatedButton(
            child: Text(
              "Update",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              update(widget.note.note_id, tfCourseName.text,
                  int.parse(tfScore1.text), int.parse(tfScore2.text));
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextField(
                    controller: tfCourseName,
                    decoration: InputDecoration(hintText: "Course Name"),
                  ),
                  TextField(
                    controller: tfScore1,
                    decoration: InputDecoration(hintText: "1. Score"),
                  ),
                  TextField(
                    controller: tfScore2,
                    decoration: InputDecoration(hintText: "2. Score"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: "Details",
        child: Icon(Icons.add),
      ),
    );
  }
}
