import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:suites/InfoColumn.dart';


class Hotelpage extends StatefulWidget {
  @override
  _HotelpageState createState() => _HotelpageState();
}

class _HotelpageState extends State<Hotelpage> {

  final _auth = FirebaseAuth.instance;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 5,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
          10)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  onSaved: (value){

                  },
                  decoration: InputDecoration(
                      labelText: "Hotels nearby",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                      suffixIcon:  IconButton(
                        icon: Icon(Icons.calendar_today_outlined),
                        onPressed: (){},
                      ) ,
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none
                      )
                  ),
                ),
              Divider(
                thickness: 1.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [InfoColumn(),
                   InfoColumn(),
                  InfoColumn(),],
              ),
                SizedBox(
                  height: 10.0,
                ),],
            ),
          ),
        ),
      ),
    );
  }
}

