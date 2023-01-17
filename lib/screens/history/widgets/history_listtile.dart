
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../dimensions.dart';
import '../../comparison/comparison.dart';
import '../../training/models/exercise.dart';

class HistoryListTile extends StatelessWidget{
  const HistoryListTile({Key? key, required this.exercise, required this.onLongPress}) : super(key: key);

  final Exercise exercise;
  final void Function(int id) onLongPress;

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
            MaterialPageRoute(
              builder: (context) => Comparison(), //TODO Fill in Parameters
            ),
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