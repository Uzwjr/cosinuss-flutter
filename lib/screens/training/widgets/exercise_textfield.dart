import 'package:cosinuss/screens/training/models/exercise.dart';
import 'package:flutter/material.dart';

class ExerciseTextField extends StatefulWidget {
  const ExerciseTextField({Key? key, required this.onFinish}) : super(key: key);

  final void Function(Exercise) onFinish;

  @override
  State<ExerciseTextField> createState() => _ExerciseTextFieldState();

}

class _ExerciseTextFieldState extends State<ExerciseTextField> {

  String text = "";

  void _onFinished(String text, BuildContext context) {
    DateTime now = DateTime.now();
    Exercise newExercise = Exercise(name: text, id: now.millisecondsSinceEpoch);
    widget.onFinish(newExercise);
    Navigator.of(context).pop();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    text = value;
                  });
                },
                onSubmitted: (text) => _onFinished(text, context),
              ),
            ),
          ),
         // Padding(
         //   padding: const EdgeInsets.all(8.0),
         //   child: text == ""
         //       ? const AddButton(onPress: null)
         //       : AddButton(onPress: () => _onFinishHandler(text, context)),
         // )
        ],
      ),
      padding: MediaQuery.of(context).viewInsets,
    );
  }

}
