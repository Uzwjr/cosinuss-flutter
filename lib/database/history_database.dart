import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../screens/history/models/history_session.dart';
import 'package:cosinuss/database/history_dao.dart';

part 'history_database.g.dart';

@Database (version: 1, entities: [HistorySession])
abstract class HistoryDatabase extends FloorDatabase {
  HistoryDao get historyDao;
}