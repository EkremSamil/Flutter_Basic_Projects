import 'package:flutter/material.dart';
import 'package:notes_app/main.dart';
import 'package:notes_app/notedao.dart';

class noteSave extends StatefulWidget {
  const noteSave({super.key});

  @override
  State<noteSave> createState() => _noteSaveState();
}

class _noteSaveState extends State<noteSave> {
  var tfCourseName = TextEditingController();
  var tfScore1 = TextEditingController();
  var tfScore2 = TextEditingController();

  Future<void> saveAs(String course_name, int score1, int score2) async {
    await notesDao().addNote(course_name, score1, score2);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Note"),
      ),
      body: Center(
        child: Padding(
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          saveAs(
            tfCourseName.text,
            int.parse(tfScore1.text),
            int.parse(tfScore2.text),
          );
        },
        tooltip: "Save Note",
        icon: Icon(Icons.save),
        label: Text("Save"),
      ),
    );
  }
}
