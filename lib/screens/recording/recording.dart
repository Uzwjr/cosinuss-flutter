import 'package:bordered_text/bordered_text.dart';
import 'package:cosinuss/dimensions.dart';
import 'package:cosinuss/screens/recording/widgets/recording_bodytemperature.dart';
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
  void _onPressed(bool isStarted) {
    if (!isStarted) {

    }
  }

  @override
  Widget build(BuildContext context) {
    Dimensions(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: Dimensions.boxWidth * 22,
        title: BorderedText(
            //strokeColor: Colors.lightBlue,
            child: Text(
          widget.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: Dimensions.boxWidth * 7.5,
          ),
          textAlign: TextAlign.end,
        )),
      ),
      body: Flex(
        direction:
            Dimensions.screenOrientation ? Axis.horizontal : Axis.vertical,
        children: [
          Expanded(
              child: RecordingHeartRate(
            // handler: _handleHeartRate,
            stream: widget.heartBeatStream,
            timeRange: const Duration(seconds: 10),
            minValue: 60.0,
            maxValue: 200.0,
          )),
          Expanded(
            child : Padding(
              padding: EdgeInsets.only(bottom: Dimensions.boxHeight * 8),
              child: RecordingHeartRate(
            // handler: _handleHeartRate,
            stream: widget.temperatureStream,
            timeRange: const Duration(seconds: 10),
            minValue: 30.0,
            maxValue: 40.0,
              ),
          )),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: RecordingButton(
        isStarted: false,
        onPressed: (isStarted) {
          _onPressed;
        },
      ),
    );
  }
}
