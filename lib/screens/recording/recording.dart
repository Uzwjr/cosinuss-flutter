import 'package:bordered_text/bordered_text.dart';
import 'package:cosinuss/dimensions.dart';
import 'package:cosinuss/screens/recording/widgets/recording_bodytemperature.dart';
import 'package:cosinuss/screens/recording/widgets/recording_heartrate.dart';
import 'package:esense_flutter/esense.dart';
import 'package:flutter/material.dart';

class Recording extends StatefulWidget {
  const Recording({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  State<StatefulWidget> createState() => _RecodingState();
}




class _RecodingState extends State<Recording> {

  List<double> _handleHeartRate(SensorEvent event) {
      return [0.0, 0.0, 0.0];
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
              child: RecordingHeartRate<SensorEvent>(
                stream: ESenseManager("meh").sensorEvents,
                handler: _handleHeartRate,
                timeRange: Duration(seconds: 10),
                minValue: -20000.0,
                maxValue: 20000.0,
              )
          ),
          Expanded(child: RecordingBodyTemperature()
          ),
        ],
      ),
    );
  }
}
