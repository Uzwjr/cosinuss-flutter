import 'package:bordered_text/bordered_text.dart';
import 'package:cosinuss/screens/training/widgets/exercise_alertdialog.dart';
import 'package:cosinuss/screens/training/widgets/exercise_listtile.dart';
import 'package:cosinuss/screens/training/widgets/exercise_textfield.dart';
import 'package:flutter/material.dart';
import '../../dimensions.dart';
import 'models/exercise.dart';

class Training extends StatefulWidget {
  const Training({Key? key}) : super(key: key);

  @override
  State<Training> createState() => _TrainingState();
}

class _TrainingState extends State<Training> {
  List<Exercise> exercises = [];

  void _addExercise(Exercise newExercise) {
    setState(() {
      exercises.insert(0, newExercise);
    });
  }

  void _removeExercise(int id) {
    int index = exercises.indexWhere((exercise) => exercise.id == id);
    if (index != -1) {
      setState(() {
        exercises.removeAt(index);
      });
    }
  }

  void _askIfDelete(int id) {
    showDialog(
        context: context,
        builder: (context) {
          return ExerciseAlertDialog(onPressed: _removeExercise, id: id);
        }
    );
  }

  void _enterExerciseName(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ExerciseTextField(onFinish: _addExercise);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Dimensions(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: Dimensions.boxWidth * 22,
        title: BorderedText(
            //strokeColor: Colors.lightBlue,
              child: Text(
                "Training",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.boxWidth * 7.5,
                ),
                textAlign: TextAlign.end,
              )),
      ),
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          return ExerciseListTile(exercise: exercises[index], onLongPress: _askIfDelete);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
        onPressed: () {
          _enterExerciseName(context);
        },
      ),
    );
  }
}
