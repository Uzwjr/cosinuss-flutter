import 'package:flutter/material.dart';

class ExerciseAlertDialog extends StatelessWidget {
  const ExerciseAlertDialog(
      {Key? key, required this.onPressed, required this.id})
      : super(key: key);

  final Function(int) onPressed;
  final int id;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text("Delete this exercise ?")),
     // content: const Text("Delete this exercise ?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(
                width: 2.0,
                color: Colors.blue,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: const Text(
              "No",
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
        ),

        TextButton(
            onPressed: () {
              onPressed(id);
              Navigator.of(context).pop();
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2.0,
                  color: Colors.blue,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: const Text(
                "Yes",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            )),
      ],
      elevation: 24,
      //backgroundColor: Colors.blue,
    );
  }
}
