import 'dart:convert';

import 'package:bordered_text/bordered_text.dart';
import 'package:cosinuss/dimensions.dart';
import 'package:cosinuss/screens/history/models/history_session.dart';
import 'package:cosinuss/screens/recording/widgets/recording_button.dart';
import 'package:cosinuss/screens/recording/widgets/recording_streamHandler.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../database/database.dart';

class Recording extends StatefulWidget {
  const Recording({Key? key,
    required this.name,
    required this.heartBeatStream,
    required this.temperatureStream,
    required this.id})
      : super(key: key);

  final int id;
  final String name;
  final Stream<double> heartBeatStream;
  final Stream<double> temperatureStream;


  @override
  State<StatefulWidget> createState() => _RecodingState();
}

class _RecodingState extends State<Recording> {

  DateTime? _startTime;
  late final _historySessionDb;
  late final _historySessionDao;

  @override
  void initState() {
    _buildDatabase();
    super.initState();
  }

  Future<void> _buildDatabase() async {
    setState(() async {
      _historySessionDb =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
      _historySessionDao = _historySessionDb.historySessionDao;
      _historySessionDb = await _historySessionDao.findAllExercises();
      setState(() {});
    });
  }

  void saveHistorySession(int sessionID, int streamNumber, List<FlSpot> spots) {
    String jsonString = json.encode(spots);
    HistorySession historySession;
    if(_historySessionDao.findHistorySessionsById(sessionID) != null) {
      historySession = _historySessionDao.findHistorySessionsById(sessionID);
    }
    else {
      historySession = HistorySession(widget.id, widget.name, "", "");

      if (streamNumber == 0) {
        historySession.heartRateFlSpotsAsJson = jsonString;
      }
      else {
        historySession.temperatureFlSpotsAsJson = jsonString;
      }
    }
    _historySessionDao.insertHistorySession(historySession);
  }


  void startStopRecording(bool isStarted) {
    setState(() {
      if (!isStarted) {
        _startTime = DateTime.now();
      } else {
        _startTime = null;
      }
    });
  }

  set startTime(DateTime value) {
    _startTime = value;
  }

  DateTime? startTimeGetter() {
    return _startTime;
  }

  @override
  Widget build(BuildContext context) {
    Dimensions(context);
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: Dimensions.boxHeight * 6,
          title: Center(
            child: BorderedText(
              //strokeColor: Colors.lightBlue,
                child: Text(
                  widget.name,
                  style: TextStyle(
                      color: Colors.white, fontSize: Dimensions.boxHeight * 5),
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
                    saveHistorySession: saveHistorySession,
                    stream: widget.heartBeatStream,
                    timeRange: const Duration(seconds: 10),
                    minValue: 60.0,
                    maxValue: 200.0,
                    streamType: 0,
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
                  saveHistorySession: saveHistorySession,
                  // handler: _handleHeartRate,
                  stream: widget.temperatureStream,
                  timeRange: const Duration(seconds: 10),
                  minValue: 30.0,
                  maxValue: 40.0,
                  streamType: 1,
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
