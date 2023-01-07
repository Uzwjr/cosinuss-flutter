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
      this.maxValue})
      : super(key: key);

  final Stream<T> stream;

  //final List<double> Function(T) handler;
  final Duration timeRange;
  final double? minValue;
  final double? maxValue;

  @override
  _RecordingHeartRateState<T> createState() => _RecordingHeartRateState<T>();
}

class _RecordingHeartRateState<T> extends State<RecordingHeartRate> {
  late StreamSubscription<double> _subscription;
  final List<RecordingValue> _data = [];
  //String recordingTime = '0:0';
  //bool isRecording = false;

  @override
  void initState() {
    super.initState();
    Stream<double> mappedStream = widget.stream.map((i) => i as double);
    _subscription = mappedStream.listen((event) {
      DateTime now = DateTime.now();

    /*  Timer.periodic(const Duration(seconds: 0), (Timer t) {
        var diff = DateTime.now().difference(now);
        recordingTime =
            '${diff.inHours == 0 ? '' : diff.inHours.toString().padLeft(2, "0") + ':'}${(diff.inMinutes % 60).floor().toString().padLeft(2, "0")}:${(diff.inSeconds % 60).floor().toString().padLeft(2, '0')}';
        if (!isRecording) {
          t.cancel();
        }
      });
    */
      //check if old data can be removed
      _data.removeWhere((element) =>
          element.timeStamp.isBefore(now.subtract(widget.timeRange)));
      setState(() {
        _data.add(RecordingValue(event, DateTime.now()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamLineChart(
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
