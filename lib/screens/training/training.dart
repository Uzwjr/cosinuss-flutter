import 'package:cosinuss/screens/training/widgets/exercise_listtile.dart';
import 'package:cosinuss/screens/training/widgets/exercise_textfield.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          return ExerciseListTile(exercise: exercises[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _enterExerciseName(context);
        },
      ),
    );
  }
}
