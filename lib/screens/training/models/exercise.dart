import 'package:floor/floor.dart';

@entity
class Exercise {
  Exercise({required this.name, required this.id});

  final String name;

  @primaryKey
  final int id;
}
