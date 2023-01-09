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
    List<List<FlSpot>> spots = [];

    spots.add([]);

    for (var event in eventValues) {
      var diff = -1;
      if (startTimeGetter() != null) {
        log (startTimeGetter().toString());
        diff = startTimeGetter().difference(DateTime.now()).inSeconds;
      }
      spots[0].add(FlSpot(diff.toDouble(), event.value));
    }

    List<LineChartBarData> lineBarsData = [];
    spots.map((e) => LineChartBarData(spots: e, dotData: FlDotData(show: false))).toList();
    for (var i = 0; i < spots.length; i++) {
      lineBarsData.add(LineChartBarData(
        spots: spots[i],
        color: Colors.blue,
        dotData: FlDotData(show: true),
      ));
    }
    return lineBarsData;
  }

  @override
  Widget build(BuildContext context) {
    if (eventValues.isEmpty) return const Center(child: Text("Waiting for first event..."));

    double latestTimeStampInMilliSec = eventValues.last.timeStamp.second.toDouble();
    return LineChart(
      LineChartData(
        clipData: FlClipData.all(),
        titlesData: FlTitlesData(
          topTitles: AxisTitles(),
         rightTitles: AxisTitles(),
         //   topTitles: SideTitles(showTitles: false)
        ),
        //axisTitleData: FlAxisTitleData(bottomTitle: AxisTitle(showTitle: false)),
        lineBarsData: _eventValuesToLineBarsData(eventValues),
        maxX: latestTimeStampInMilliSec,
        minX: latestTimeStampInMilliSec - timeRange.inSeconds,
        maxY: maxY,
        minY: minY,
      ),
      swapAnimationDuration: const Duration(seconds: 1),
    );
  }
}
