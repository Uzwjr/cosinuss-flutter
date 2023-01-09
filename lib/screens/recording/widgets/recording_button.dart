import 'dart:developer';

import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../dimensions.dart';

class RecordingButton extends StatefulWidget {
  const RecordingButton({Key? key, required this.onPressed}) : super(key: key);

  final void Function(bool) onPressed;

  @override
  State<RecordingButton> createState() => RecordingButtonState();
}

class RecordingButtonState extends State<RecordingButton> {
  bool isStarted = false;

  @override
  Widget build(BuildContext context) {
    Dimensions(context);
    String runningStatus = (isStarted) ? "Stop" : "Start";
    return SizedBox(
      height: Dimensions.boxHeight * 6,
      width: Dimensions.boxWidth * 80,
      child: FloatingActionButton.extended(
        onPressed: () {
          log("MEH0");
          widget.onPressed(isStarted);
          setState(() {
            isStarted = !isStarted;
          });
        },
        backgroundColor: isStarted ? Colors.red : Colors.green,
        label: BorderedText(
            //strokeColor: Colors.lightBlue,
            child: Text(
          runningStatus,
          style: TextStyle(
            color: Colors.white,
            fontSize: Dimensions.boxWidth * 7.5,
          ),
          textAlign: TextAlign.end,
        )),
      ),
    );
  }
}
