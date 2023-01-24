import 'package:bordered_text/bordered_text.dart';
import 'package:cosinuss/screens/history/widgets/history_listtile.dart';
import 'package:cosinuss/screens/history/widgets/history_multiselect.dart';
import 'package:flutter/material.dart';

import '../../database/exercise_database.dart';
import '../../database/history_database.dart';
import '../../dimensions.dart';
import '../training/models/exercise.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);
  @override
  State<History> createState() => HistoryState();
}

class HistoryState extends State<History> {
  List<Exercise> _exercises = [];

  late final _exerciseDB;
  late final _exerciseDao;

  late final _historyDatabae;
  late final _historyDao;

  Future<void> _buildDatabase() async {
      _exerciseDB = await $FloorExerciseDatabase.databaseBuilder('exercise_database.db').build();
      _exerciseDao = _exerciseDB.exerciseDao;
      _exercises = await _exerciseDao.findAllExercises();

      _historyDatabae = await $FloorHistoryDatabase.databaseBuilder('history_database.db').build();
      _historyDao = _historyDatabae.historyDao;
      setState(() {
      });
  }

  @override
  void initState() {
    _buildDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Dimensions(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: Dimensions.boxWidth * 22,
        title: BorderedText(
            child: Text(
          "History",
          style: TextStyle(
            color: Colors.white,
            fontSize: Dimensions.boxWidth * 7.5,
          ),
          textAlign: TextAlign.end,
        )),
      ),
      body: ListView.builder(
        itemCount: _exercises.length,
        itemBuilder: (context, index) {
          return HistoryListTile(
            exercise: _exercises[index],
            historySessionDao: _historyDao,
            onLongPress: (int id) {  }, //TODO DELETE OPTION ADDEN
          );
        },
      ),
    );
  }
}
