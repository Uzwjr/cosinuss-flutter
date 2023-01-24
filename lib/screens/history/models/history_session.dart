
import 'package:fl_chart/fl_chart.dart';
import 'package:floor/floor.dart';

@entity
class HistorySession {

  HistorySession(this.id, this.exerciseNumber, this.name, this.heartRateFlSpotsAsJson, this.temperatureFlSpotsAsJson);

  @primaryKey
  final int id;

  final int exerciseNumber;
  final String name;

  String heartRateFlSpotsAsJson;
  String temperatureFlSpotsAsJson;
}