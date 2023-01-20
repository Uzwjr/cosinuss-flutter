import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../screens/history/models/history_session.dart';
import 'package:cosinuss/database/historysession_dao.dart';

part 'historysessiondb.g.dart';

@Database (version: 1, entities: [HistorySession])
abstract class HistorySessionDB extends FloorDatabase {
  HistorySessionDao get historySessionDao;
}