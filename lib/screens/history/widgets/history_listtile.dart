import 'package:bordered_text/bordered_text.dart';
import 'package:cosinuss/screens/history/models/history_session.dart';
import 'package:cosinuss/screens/history/widgets/history_multiselect.dart';
import 'package:floor/floor.dart';
import 'package:flutter/material.dart';

import '../../../dimensions.dart';
import '../../training/models/exercise.dart';

class HistoryListTile extends StatelessWidget {
  const HistoryListTile(
      {Key? key, required this.exercise, required this.onLongPress, required this.historySessionDao})
      : super(key: key);

  final Exercise exercise;
  final void Function(int id) onLongPress;
  final historySessionDao;

  double _nameLengthSize(String name) {
    if (name.length > 12) {
      return 6.5 / ((name.length) * 0.1);
    }
    return 6.5;
  }

  @override
  Widget build(BuildContext context) {
    Dimensions(context);
    return Card(
      child: ElevatedButton(
          onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return HistoryMultiSelect(
                      items: historySessionDao.findAllHistorySessionWithId(exercise.id));
                }),
              ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            BorderedText(
                child: Text(exercise.name,
                    style: TextStyle(
                        fontSize: Dimensions.boxHeight *
                            _nameLengthSize(exercise.name),
                        //fontWeight: FontWeight.bold,
                        color: Colors.white))),
          ])),
    );
  }
}
