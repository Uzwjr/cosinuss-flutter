import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/recording_value.dart';

class StreamLineChart extends StatelessWidget {
  const StreamLineChart({
    Key? key,
    required this.eventValues,
    required this.timeRange,
    this.maxY,
    this.minY,
    required this.startTime,
    required this.saveHistorySession,
    required this.historySessionData,
    required this.streamType, 
    required this.running,
  }) : super(key: key);
  final List<RecordingValue> eventValues;
  final List<RecordingValue> historySessionData;
  final Duration timeRange;
  final double? maxY;
  final double? minY;
  final DateTime startTime;
  final Function(int streamNumber, List<FlSpot> spots) saveHistorySession;
  final int streamType;
  final bool running;

  //final List<Color> _colors = const [Colors.red, Colors.blue, Colors.orange];

  List<LineChartBarData> _eventValuesToLineBarsData(List<RecordingValue> eventValues) {
    List<FlSpot> spots = [];

    for (var event in eventValues) {
      if (running) {
      var diff = event.timeStamp.difference(startTime).inSeconds;
      spots.add(FlSpot(diff.toDouble(), event.value));
      }
     // else {
     //   log ("meh2"); //ZWEIMALIGES AUFRUFEN BEI STOP
     // }
    }

    List<LineChartBarData> lineBarsData = [];
    //spots.map((e) => LineChartBarData(spots: e.toDouble(), dotData: FlDotData(show: false))).toList();
    for (var i = 0; i < spots.length; i++) {
      lineBarsData.add(LineChartBarData(
        spots: spots,
        color: Colors.blue,
        dotData: FlDotData(show: false),
      ));
    }
    return lineBarsData;
  }

  @override
  Widget build(BuildContext context) {
    if (eventValues.isEmpty) return const Center(child: Text("Waiting for first event..."));
    double latestTimeStampDiff = 0;
    if (running) { //TODO FUCK klappt das ?
      latestTimeStampDiff = eventValues.last.timeStamp.difference(startTime).inSeconds.toDouble();
    }
    else {
      List<FlSpot> historySessionFlSpots = [];
      for (var event in historySessionData) {
        var diff = event.timeStamp.difference(startTime).inSeconds;
        historySessionFlSpots.add(FlSpot(diff.toDouble(), event.value));
        saveHistorySession(streamType, historySessionFlSpots);
      }
    }


    return LineChart(
      LineChartData(
        clipData: FlClipData.all(),
        titlesData: FlTitlesData(
          topTitles: AxisTitles(),
         rightTitles: AxisTitles(),
        ),
        lineBarsData: _eventValuesToLineBarsData(eventValues),
        maxX: latestTimeStampDiff,
        minX: latestTimeStampDiff - timeRange.inSeconds,
        maxY: maxY,
        minY: minY,
      ),
      swapAnimationDuration: const Duration(seconds: 1),
    );
  }
}
