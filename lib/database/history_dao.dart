
import 'package:cosinuss/screens/history/models/history_session.dart';
import 'package:floor/floor.dart';

@dao
abstract class HistoryDao{

  @Query('SELECT * FROM Exercise WHERE id = :id ORDER BY id DESC')
  Future<List<HistorySession>> findAllHistorySessionWithId(int id);

  @Query('SELECT * FROM Exercise WHERE id = :id')
  Stream<HistorySession?> findHistorySessionsById(int id);

  @insert
  Future<void> insertHistorySession(HistorySession historySession);

  @delete
  Future<void> deleteHistorySession(HistorySession historySession);
}