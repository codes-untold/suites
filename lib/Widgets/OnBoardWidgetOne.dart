import 'package:flutter/material.dart';

class HomeOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("images/reduced.png"),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [  Text("Search for Hotels",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17.0
            ),) ,
            Text("from Anywhere ✅",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17.0
              ),),
            SizedBox(
              height: 20.0,
            ),
            Text("Make suite Inquiries on the Go from "
                "any location and get up to date info "
                "on your desired suite in Benin City",
              style: TextStyle(
                  fontSize: 13.5,
                  color: Colors.black45
              ),),],
        )
      ],
    );
  }
}
