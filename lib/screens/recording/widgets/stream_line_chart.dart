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
    this.minY, required this.startTimeGetter,
  }) : super(key: key);
  final List<RecordingValue> eventValues;
  final Duration timeRange;
  final double? maxY;
  final double? minY;
  final Function startTimeGetter;

  //final List<Color> _colors = const [Colors.red, Colors.blue, Colors.orange];

  List<LineChartBarData> _eventValuesToLineBarsData(List<RecordingValue> eventValues) {
    List<FlSpot> spots = [];

    for (var event in eventValues) {
      var diff = -1;
      if (startTimeGetter() != null) {
        diff = event.timeStamp.difference(startTimeGetter()).inSeconds;
      }
      spots.add(FlSpot(diff.toDouble(), event.value));
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
    if (startTimeGetter() != null) {
      latestTimeStampDiff = eventValues.last.timeStamp.difference(startTimeGetter()).inSeconds.toDouble();
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
