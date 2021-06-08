import 'package:flutter/material.dart';

class InfoColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Check in"),
        SizedBox(
          height: 5.0,
        ),
        Text("28 May",
        style: TextStyle(
          fontWeight: FontWeight.w600
        ),),
      ],
    );
  }
}
