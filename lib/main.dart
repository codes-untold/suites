import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suites/HomeScreen.dart';
import 'package:suites/Hotelpage.dart';
import 'HomeScreen.dart';
import 'HomeScreen.dart';
import 'Hotelpage.dart';
import 'Hotelpage.dart';
import 'Hotelpage.dart';
import 'LoginScreen.dart';


Future <void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  runApp(MaterialApp(
   // home: await getBoolToSF()? HomeScreen():HomeScreen(),
    home: Hotelpage(),
    debugShowCheckedModeBanner: false,
  ));
}

getBoolToSF()async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool boolvalue = preferences.getBool("boolvalue")?? false;
  return boolvalue;

}
