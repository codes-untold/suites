import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suites/HomeScreen.dart';
import 'package:suites/Hotelpage.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: await getBoolToSF()? Hotelpage():HomeScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

getBoolToSF()async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool boolvalue = preferences.getBool("boolvalue")?? false;
  return boolvalue;

}
