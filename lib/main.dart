import 'dart:io';

import 'package:flutter/material.dart';
import 'package:notes_app/notedao.dart';
import 'package:notes_app/notedetail.dart';
import 'package:notes_app/notes.dart';
import 'package:notes_app/notesave.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Notes>> showallNotes() async {
    var noteList = await notesDao().allNotes();

    return noteList;
  }

  Future<bool> exitApp() async {
    await exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              exitApp();
            },
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Notes App",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              FutureBuilder(
                future: showallNotes(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var noteList = snapshot.data;

                    double average = 0.0;
                    if (!noteList!.isEmpty) {
                      double total = 0.0;

                      for (var n in noteList) {
                        total = total + (n.score1 + n.score2) / 2;
                      }
                      average = total / noteList.length;
                    }
                    return Text(
                      "Average Notes : ${average.toInt()}",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    );
                  } else {
                    return Text(
                      "Average : 0 ",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    );
                  }
                },
              ),
            ],
          )),
      body: WillPopScope(
        onWillPop: exitApp,
        child: FutureBuilder<List<Notes>>(
          future: showallNotes(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var notList = snapshot.data;
              return ListView.builder(
                  itemCount: notList!.length,
                  itemBuilder: (context, index) {
                    var notes = notList[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => detailNote(note: notes)));
                      },
                      child: Card(
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(notes.course_name),
                              Text(notes.score1.toString()),
                              Text(notes.score2.toString()),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return Center();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => noteSave()));
        },
        tooltip: "Add New Note",
        child: Icon(Icons.add),
      ),
    );
  }
}
