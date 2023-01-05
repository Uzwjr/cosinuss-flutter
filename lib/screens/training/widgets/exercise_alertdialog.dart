import 'package:flutter/material.dart';

class ExerciseAlertDialog extends StatelessWidget {
  const ExerciseAlertDialog({Key? key, required this.onPressed, required this.id})
      : super(key: key);

  final Function(int) onPressed;
  final int id;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Delete ?"),
      content: const Text("Delete the exercise ?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("No"),

        ),
        TextButton(
            onPressed: () {
              onPressed(id);
              Navigator.of(context).pop();
            },
            child: const Text("Yes")
        ),
      ],
      elevation: 20,
    );
  }
}
