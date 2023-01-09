import 'dart:async';

import 'package:cosinuss/screens/recording/models/recording_value.dart';
import 'package:cosinuss/screens/recording/widgets/stream_line_chart.dart';
import 'package:flutter/cupertino.dart';

class RecordingHeartRate<T> extends StatefulWidget {
  const RecordingHeartRate(
      {Key? key,
      required this.stream,
      //required this.handler,
      required this.timeRange,
      this.minValue,
      this.maxValue,
        required this.startTimeGetter})
      : super(key: key);

  final Stream<T> stream;

  final Function startTimeGetter;
  final Duration timeRange;
  final double? minValue;
  final double? maxValue;
  @override
  _RecordingHeartRateState<T> createState() => _RecordingHeartRateState<T>();
}

class _RecordingHeartRateState<T> extends State<RecordingHeartRate> {
  late StreamSubscription<double> _subscription;
  final List<RecordingValue> _data = [];

  @override
  initState() {
    super.initState();
    Stream<double> mappedStream = widget.stream.map((i) => i as double);
    _subscription = mappedStream.listen((event) {
      DateTime now = DateTime.now();

      //check if old data can be removed
      if (widget.startTimeGetter() != null) {
        _data.removeWhere((element) =>
            element.timeStamp.isBefore(now.subtract(widget.timeRange)));
        setState(() {
          _data.add(RecordingValue(event, now));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamLineChart(
      startTimeGetter: widget.startTimeGetter,
      eventValues: _data,
      timeRange: widget.timeRange,
      maxY: widget.maxValue,
      minY: widget.minValue,
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
