import 'dart:developer';

import 'package:bordered_text/bordered_text.dart';
import 'package:cosinuss/dimensions.dart';
import 'package:cosinuss/screens/recording/widgets/recording_button.dart';
import 'package:cosinuss/screens/recording/widgets/recording_heartrate.dart';
import 'package:flutter/material.dart';

class Recording extends StatefulWidget {
  const Recording(
      {Key? key,
      required this.name,
      required this.heartBeatStream,
      required this.temperatureStream})
      : super(key: key);

  final String name;
  final Stream<double> heartBeatStream;
  final Stream<double> temperatureStream;

  @override
  State<StatefulWidget> createState() => _RecodingState();
}

class _RecodingState extends State<Recording> {
  DateTime? _startTime;

  set startTime(DateTime value) {
    _startTime = value;
  }

  DateTime? startTimeGetter() {
    return _startTime;
  }

  void startStopRecording(bool isStarted) {
    if (!isStarted) {
      _startTime = DateTime.now();
    } else {
      _startTime = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Dimensions(context);
    return Scaffold(
      appBar: AppBar(
          title: Center(
            child: BorderedText(
            //strokeColor: Colors.lightBlue,
            child: Text(
              widget.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: Dimensions.boxHeight * 5.5
              ),
          textAlign: TextAlign.end,
        )),
      )),
      body: Column(children: [
        Flex(
          direction:
              Dimensions.screenOrientation ? Axis.horizontal : Axis.vertical,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  right: Dimensions.boxWidth * 5,
                  top: Dimensions.boxHeight * 2),
              child: SizedBox(
                  height: Dimensions.screenOrientation
                      ? Dimensions.boxHeight * 70
                      : Dimensions.boxHeight * 39,
                  width: Dimensions.screenOrientation
                      ? Dimensions.boxWidth * 45
                      : Dimensions.boxWidth * 95,
                  child: RecordingHeartRate(
                    // handler: _handleHeartRate,
                    startTimeGetter: startTimeGetter,
                    stream: widget.heartBeatStream,
                    timeRange: const Duration(seconds: 10),
                    minValue: 60.0,
                    maxValue: 200.0,
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: Dimensions.boxWidth * 5,
                  top: Dimensions.boxHeight * 2),
              child: SizedBox(
                height: Dimensions.screenOrientation
                    ? Dimensions.boxHeight * 70
                    : Dimensions.boxHeight * 39,
                width: Dimensions.screenOrientation
                    ? Dimensions.boxWidth * 45
                    : Dimensions.boxWidth * 95,
                child: RecordingHeartRate(
                  startTimeGetter: startTimeGetter,
                  // handler: _handleHeartRate,
                  stream: widget.temperatureStream,
                  timeRange: const Duration(seconds: 10),
                  minValue: 30.0,
                  maxValue: 40.0,
                ),
              ),
            )
          ],
        ),
        Center(
          child: RecordingButton(
            onPressed: (isStarted) {
              startStopRecording(isStarted);
            },
          ),
        ),
      ]),
    );
  }
}
