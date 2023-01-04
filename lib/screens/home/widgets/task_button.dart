import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';


class TaskButton extends StatelessWidget {
  const TaskButton({Key? key, required this.name, required this.page}) : super(key: key);

  final String name;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => page,
          ),
        ),
        style: ElevatedButton.styleFrom(

            backgroundColor: Colors.black38,
            minimumSize: const Size.fromHeight(160),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
        child: AutoSizeText(name, maxLines: 1, style: const TextStyle(fontSize:32, color: Colors.white)),
      ),
    );
  }
}
