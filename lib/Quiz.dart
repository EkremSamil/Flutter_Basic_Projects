import 'dart:collection';

import 'package:flag_quiz/Flags.dart';
import 'package:flag_quiz/Results.dart';
import 'package:flag_quiz/flags_dao.dart';
import 'package:flutter/material.dart';

class QuizWindow extends StatefulWidget {
  const QuizWindow({super.key});

  @override
  State<QuizWindow> createState() => _QuizWindowState();
}

class _QuizWindowState extends State<QuizWindow> {
  var quests = <Flags>[];
  var wrongOptions = <Flags>[];
  late Flags correctQuest;
  var allOptions = HashSet<Flags>();

  int whichQuest = 0;
  int trueQuest = 0;
  int wrongQuest = 0;

  String flagsImgName = "placeholder.png"; //if not work img this is working.
  String buttonA = "";
  String buttonB = "";
  String buttonC = "";
  String buttonD = "";

  @override
  void initState() {
    super.initState();
    takeQuest();
  }

  Future<void> takeQuest() async {
    quests = await Flagsdao().randomFlags();
    uploadQuest();
  }

  Future<void> uploadQuest() async {
    correctQuest = quests[whichQuest];

    flagsImgName = correctQuest.flag_img;

    wrongOptions = await Flagsdao().randomWrongFlags(correctQuest.flag_id);

    allOptions.clear();
    allOptions.add(correctQuest);
    allOptions.add(wrongOptions[0]);
    allOptions.add(wrongOptions[1]);
    allOptions.add(wrongOptions[2]);

    buttonA = allOptions.elementAt(0).flag_name;
    buttonB = allOptions.elementAt(1).flag_name;
    buttonC = allOptions.elementAt(2).flag_name;
    buttonD = allOptions.elementAt(3).flag_name;

    setState(() {});
  }

  void whichQuestController() {
    whichQuest += 1;

    if (whichQuest != 5) {
      uploadQuest();
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => resultWindow(correctNum: trueQuest)));
    }
  }

  void correctController(String buttonText) {
    if (correctQuest.flag_name == buttonText) {
      trueQuest += 1;
    } else {
      wrongQuest += 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(236, 255, 255, 255),
      appBar: AppBar(
        title: Text("Quiz Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("True : $trueQuest", style: TextStyle(fontSize: 18)),
                Text("Wrong : $wrongQuest", style: TextStyle(fontSize: 18)),
              ],
            ),
            whichQuest != 5
                ? Text("${whichQuest + 1}", style: TextStyle(fontSize: 30))
                : Text("5. Quest", style: TextStyle(fontSize: 30)),
            Image.asset("images/$flagsImgName"),
            ElevatedButton(
              child: Text(buttonA),
              onPressed: () {
                correctController(buttonA);
                whichQuestController();
              },
            ),
            ElevatedButton(
              child: Text(buttonB),
              onPressed: () {
                correctController(buttonB);
                whichQuestController();
              },
            ),
            ElevatedButton(
              child: Text(buttonC),
              onPressed: () {
                correctController(buttonC);
                whichQuestController();
              },
            ),
            ElevatedButton(
              child: Text(buttonD),
              onPressed: () {
                correctController(buttonD);
                whichQuestController();
              },
            ),
          ],
        ),
      ),
    );
  }
}
