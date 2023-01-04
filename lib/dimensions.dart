import 'package:flutter/cupertino.dart';

class Dimensions {
  static double boxWidth = 0;
  static double boxHeight = 0;

  Dimensions(context) {
    boxHeight = MediaQuery.of(context).size.height / 100;
    boxWidth = MediaQuery.of(context).size.width / 100;
  }
}
