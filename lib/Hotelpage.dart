import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Hotelpage extends StatefulWidget {
  @override
  _HotelpageState createState() => _HotelpageState();
}

class _HotelpageState extends State<Hotelpage> {

  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedinUser;


  void getCurrentUser()async{
    final user = await _auth.currentUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                onSaved: (value){

                },
                decoration: InputDecoration(
                    labelText: "Hotels nearby",
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                    suffixIcon:  Icon(Icons.calendar_today_outlined) ,
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none
                    )
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [InfoColumn(),
          InfoColumn(),
                InfoColumn(),],
            )],
          ),
        ),
      ),
    );
  }
}

class InfoColumn extends StatelessWidget {
  const InfoColumn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Check in"),
        Text("28 May"),
      ],
    );
  }
}
