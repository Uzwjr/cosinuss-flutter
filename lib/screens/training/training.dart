import 'dart:async';
import 'dart:math';

import 'package:bordered_text/bordered_text.dart';
import 'package:cosinuss/BluetoothHandler.dart';
import 'package:cosinuss/database/database.dart';
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
  List<Exercise> _exercises = [];
  bool _isConnected = false;
  final BluetoothHandler _bluetoothHandler = BluetoothHandler(_update);
  final _heartBeatController = StreamController<double>.broadcast();
  final _temperatureController = StreamController<double>.broadcast();

  late final _database;
  late final _exerciseDao;



  @override
  void initState() {
    super.initState();
    _numberCreator();
  }


  void _addExercise(Exercise newExercise) async{
    await _exerciseDao.insertExercise(newExercise);
    setState(()  {
      _exercises.insert(0, newExercise);
    });
  }

  void _removeExercise(int id) async {
    int index = _exercises.indexWhere((exercise) => exercise.id == id);
    Exercise exercise = _exercises.elementAt(index);
    if (index != -1) {
      await _exerciseDao.deleteExercise(exercise);
      setState(() {
        _exercises.removeAt(index);
      });
    }
  }

  void _askIfDelete(int id) {
    showDialog(
        context: context,
        builder: (context) {
          return ExerciseAlertDialog(onPressed: _removeExercise, id: id);
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

  void _connectToBluetooth() {
    _bluetoothHandler.connect;
    setState(() {
      _isConnected = _bluetoothHandler.isConnected;
    });
  }

  static _update() {
  }

  Stream<double> get heartBeatStream => _heartBeatController.stream;
  Stream<double> get temperatureStream => _temperatureController.stream;

  void _numberCreator() {
    double countA = 100;
    double countB = 38;
    Timer.periodic(const Duration(seconds: 1), (t) {
      _heartBeatController.sink.add(countA);
      _temperatureController.sink.add(countB);
      bool random = Random().nextBool();
      if(random) {
        countA++;
        countB++;
      }
      else {
        countA--;
        countB--;
      }
    });
  }

  Future<void> _buildDatabase() async {
      setState(() async {
        _database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
        _exerciseDao = _database.exerciseDao;
        _exercises = await _exerciseDao.findAllExercises();
        setState(() {
        });
      });
  }

  @override
  Widget build(BuildContext context) {
      _buildDatabase();
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
        itemCount: _exercises.length,
        itemBuilder: (context, index) {
          return ExerciseListTile(
              exercise: _exercises[index], onLongPress: _askIfDelete, heartBeatStream: heartBeatStream, temperatureStream: temperatureStream,);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton(
              heroTag: "btn1",
              child: const Icon(Icons.bluetooth),
              backgroundColor: _isConnected ? Colors.blue : Colors.grey,
              onPressed: () {
                _connectToBluetooth();
              },
            ),
            FloatingActionButton(
              heroTag: "btn2",
              child: const Icon(Icons.add),
              backgroundColor: Colors.blue,
              onPressed: () {
                _enterExerciseName(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
