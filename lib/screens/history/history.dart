import 'package:bordered_text/bordered_text.dart';
import 'package:cosinuss/screens/history/widgets/history_listtile.dart';
import 'package:flutter/material.dart';

import '../../database/database.dart';
import '../../dimensions.dart';
import '../training/models/exercise.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);
  @override
  State<History> createState() => HistoryState();
}

class HistoryState extends State<History> {
  List<Exercise> _exercises = [];

  late final _database;
  late final _exerciseDao;

  Future<void> _buildDatabase() async {
      _database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
      _exerciseDao = _database.exerciseDao;
      _exercises = await _exerciseDao.findAllExercises();
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
            onLongPress: (int id) {},
          );
        },
      ),
    );
  }
}
