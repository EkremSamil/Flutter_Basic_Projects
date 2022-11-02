import 'dart:collection';

import 'package:flag_quiz/Quiz.dart';
import 'package:flutter/material.dart';

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
      home: homePage(),
    );
  }
}

class homePage extends StatefulWidget {
  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Welcome To Quize", style: TextStyle(fontSize: 30)),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                child: Text("Start"),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => QuizWindow()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
