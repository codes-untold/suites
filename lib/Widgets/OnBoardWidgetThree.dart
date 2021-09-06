import 'package:flutter/material.dart';

class HomeThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("images/end.png"),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [  Text("Find Recreational",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17.0
            ),) ,
            Text("Centres closeby  🏊",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17.0
              ),),
            SizedBox(
              height: 20.0,
            ),
            Text("The coolest recreational centres you should pay a visit "
                "to during your leisure time",
              style: TextStyle(
                  fontSize: 13.5,
                  color: Colors.black45
              ),),],
        )
      ],
    );
  }
}