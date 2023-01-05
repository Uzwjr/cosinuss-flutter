import 'package:bordered_text/bordered_text.dart';
import 'package:cosinuss/dimensions.dart';
import 'package:cosinuss/screens/history/history.dart';
import 'package:cosinuss/screens/settings/settings.dart';
import 'package:cosinuss/screens/training/training.dart';
import 'package:flutter/material.dart';
import './widgets/task_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  final Map<String, Widget> _screens = const {
    "training": Training(),
    "history": History(),
    "settings": Settings(),
  };

  List<Widget> _buildButtons() {
    return _screens.entries
        .map((e) => TaskButton(name: e.key, page: e.value))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    Dimensions(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: BorderedText(
            //strokeColor: Colors.lightBlue,
              child: Text(
            "Cosinuss Workout",
            style: TextStyle(
              color: Colors.white,
              fontSize: Dimensions.boxWidth * 9,
            ),
            textAlign: TextAlign.end,
          )),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.blueGrey.shade200],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _buildButtons(),
          ),
        ),
      ),
    );
  }
}
