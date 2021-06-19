import 'package:flutter/material.dart';

class InfoColumn extends StatelessWidget {

  String month;
  int day;
  String check;

  InfoColumn({this.day,this.month,this.check});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(check),
        SizedBox(
          height: 5.0,
        ),
        Text("${day!= null?day:""} ${month!= null?month:""}",
          style: TextStyle(
              fontWeight: FontWeight.w600
          ),),
      ],
    );
  }
}