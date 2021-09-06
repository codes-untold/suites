import 'package:flutter/material.dart';

class HomeTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("images/centera.png"),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [  Text("Best spots",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17.0
            ),) ,
            Text("for the weekend ⛱️",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17.0
              ),),
            SizedBox(
              height: 20.0,
            ),
            Text("Get the best suggestions on where to spend your"
                " weekend with your friends and family",
              style: TextStyle(
                  fontSize: 13.5,
                  color: Colors.black45
              ),),],
        )
      ],
    );
  }
}
