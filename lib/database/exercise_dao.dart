
import 'package:cosinuss/screens/training/models/exercise.dart';
import 'package:floor/floor.dart';

@dao
abstract class ExerciseDao{

  @Query('SELECT * FROM Exercise')
  Future<List<Exercise>> findAllExercises();

  @Query('SELECT * FROM Exercise WHERE id = :id')
  Stream<Exercise?> findExerciseById(int id);

  @insert
  Future<void> insertExercise(Exercise exercise);

  @delete
  Future<void> deleteExercise(Exercise exercise);
}