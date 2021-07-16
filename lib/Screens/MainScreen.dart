import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suites/Screens/MapScreen.dart';
import 'package:suites/Screens/ProfileScreen.dart';
import 'package:suites/TestWidget.dart';

import 'Hotelpage.dart';

class MainScreen extends StatefulWidget {


  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int selectedIndex = 0;

  List <Widget> widgets = [Hotelpage(),MapScreen(),ProfileScreen()];

  void onItemTapped(int index){
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("images/backdrop2.jpg"), context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: widgets[selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>
        [BottomNavigationBarItem(icon: Icon(Icons.home,size: 20.0,),label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.location_on_outlined,size: 20.0,),label: "location"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline_sharp,size: 20.0,),label: "profile")],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: onItemTapped,
        selectedLabelStyle: TextStyle(color: Colors.white,fontSize: 1.0),
        unselectedLabelStyle:  TextStyle(color: Colors.white,fontSize: 1.0) ,
      ),
    );
  }
}
