import 'package:fl_chart/fl_chart.dart';

class HistorySession<V> {

  HistorySession(this.label, this.value, this.spots);

  final String label;
  final V value;
  List<FlSpot> spots = [];
}