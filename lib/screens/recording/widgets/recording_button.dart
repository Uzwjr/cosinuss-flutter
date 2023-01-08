import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../dimensions.dart';

class RecordingButton extends StatelessWidget{
  const RecordingButton({Key? key, required this.isStarted, required this.onPressed}) : super(key: key);

  final bool isStarted;
  final Function(bool) onPressed;

  @override
  Widget build(BuildContext context) {
    Dimensions(context);
    String runningStatus = (isStarted) ? "Stop" : "Start";
    return SizedBox(
      height: Dimensions.boxHeight * 6,
      width: Dimensions.boxWidth * 80,
      child : FloatingActionButton.extended(
        onPressed: onPressed(isStarted),
      backgroundColor: isStarted? Colors.red : Colors.green,
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