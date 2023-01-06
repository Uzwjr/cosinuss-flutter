import 'package:bordered_text/bordered_text.dart';
import 'package:cosinuss/screens/recording/recording.dart';
import 'package:cosinuss/screens/training/models/exercise.dart';
import 'package:flutter/material.dart';

import '../../../dimensions.dart';

class ExerciseListTile extends StatelessWidget {
  const ExerciseListTile(
      {Key? key, required this.exercise, required this.onLongPress})
      : super(key: key);

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
      color: Colors.black26,
      child: ElevatedButton(
          onLongPress: () {
            onLongPress(exercise.id);
          },
          onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Recording(name: exercise.name),
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
