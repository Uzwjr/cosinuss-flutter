
import 'package:fl_chart/fl_chart.dart';
import 'package:floor/floor.dart';

@entity
class HistorySession {

  HistorySession(this.id, this.name, this.heartRateFlSpotsAsJson, this.temperatureFlSpotsAsJson);

  @primaryKey
  final int id;

  final String name;

  String heartRateFlSpotsAsJson;
  String temperatureFlSpotsAsJson;
}