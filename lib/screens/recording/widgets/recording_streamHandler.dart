import 'dart:async';
import 'dart:developer';

import 'package:cosinuss/screens/recording/models/recording_value.dart';
import 'package:cosinuss/screens/recording/widgets/stream_line_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

class RecordingHeartRate<T> extends StatefulWidget {
  const RecordingHeartRate(
      {Key? key,
      required this.stream,
      //required this.handler,
      required this.timeRange,
      this.minValue,
      this.maxValue,
        required this.startTime,
        required this.saveHistorySession, 
        required this.streamType, 
        required this.running})
      : super(key: key);

  final Stream<T> stream;
  final int streamType;
  final bool running;
  final DateTime startTime;
  final Function(int streamNumber, List<FlSpot> spots) saveHistorySession;
  final Duration timeRange;
  final double? minValue;
  final double? maxValue;
  @override
  _RecordingHeartRateState<T> createState() => _RecordingHeartRateState<T>();
}

class _RecordingHeartRateState<T> extends State<RecordingHeartRate> {
  late StreamSubscription<double> _subscription;
  final List<RecordingValue> _data = [];
  final List<RecordingValue> _historySessionData = [];

  @override
  initState() {
    super.initState();
    Stream<double> mappedStream = widget.stream.map((i) => i as double);
    _subscription = mappedStream.listen((event) {
      //check if old data can be removed
      if (widget.running) {
        _data.removeWhere((element) =>
            element.timeStamp.isBefore(DateTime.now().subtract(widget.timeRange)));
        setState(() {
          _historySessionData.add(RecordingValue(event, DateTime.now()));
          _data.add(RecordingValue(event, DateTime.now()));
          for (int i = 0; i < _data.length; i++) {
            log(i.toString() + " " + _data[i].value.toString());
          }
        });
      }
     // else {
     //   log("meh 1"); PERMANENTES LOG WÄHREND NICHT RECORDED
     // }
    });
  }

  @override
  Widget build(BuildContext context) {

    return StreamLineChart(
      startTime: widget.startTime,
      saveHistorySession: widget.saveHistorySession,
      running: widget.running,
      eventValues: _data,
      timeRange: widget.timeRange,
      maxY: widget.maxValue,
      minY: widget.minValue,
      historySessionData: _historySessionData,
      streamType: widget.streamType,
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    log("save");
    super.dispose();
  }
}
