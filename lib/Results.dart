import 'package:flutter/material.dart';

class resultWindow extends StatefulWidget {
  int correctNum;
  resultWindow({required this.correctNum});

  @override
  State<resultWindow> createState() => _resultWindowState();
}

class _resultWindowState extends State<resultWindow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Results"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("${widget.correctNum} Correct ${5 - widget.correctNum} Wrong",
                style: TextStyle(fontSize: 30)),
            Text("%${((widget.correctNum * 100) / 5).toInt()} Success",
                style: TextStyle(fontSize: 30, color: Colors.pink)),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                child: Text("Try Again"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
    ;
  }
}
