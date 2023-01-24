import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'exercise_dao.dart';
import '../screens/training/models/exercise.dart';

part 'exercise_database.g.dart';

@Database (version: 1, entities: [Exercise])
abstract class ExerciseDatabase extends FloorDatabase {
  ExerciseDao get exerciseDao;
}