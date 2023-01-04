import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';

import '../../../dimensions.dart';

class TaskButton extends StatelessWidget {
  const TaskButton({Key? key, required this.name, required this.page}) : super(key: key);

  final String name;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    Dimensions(context);
    return SizedBox(
      height: Dimensions.boxHeight * 25,
      width: Dimensions.boxWidth * 95,
      child: ElevatedButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => page,
          ),
        ),

        style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black38,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,

        child: Ink.image (
          image: AssetImage('assets/images/'+ name + '.jpg'),
          height: Dimensions.boxHeight * 27,
          width: double.infinity,
          fit: BoxFit.fitWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BorderedText(
                  child: Text(
                      name,
                      style: TextStyle(
                      fontSize: Dimensions.boxHeight * 7.5,
                      //fontWeight: FontWeight.bold,
                      color: Colors.white
                      )
                  )
              ),
            ]
          )
        ),
      ),
    );
  }
}
