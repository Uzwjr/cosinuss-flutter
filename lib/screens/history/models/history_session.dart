
import 'package:fl_chart/fl_chart.dart';
import 'package:floor/floor.dart';

@entity
class HistorySession {

  HistorySession(this.id, this.name, this.flSpotsAsJson);

  @primaryKey
  final int id;

  final String name;
  final String flSpotsAsJson;
}