import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suites/Screens/HomeScreen.dart';
import 'package:suites/Screens/LoginScreen.dart';
import 'package:suites/Screens/MainScreen.dart';
import 'Services/Listener.dart';
import 'Services/Services.dart';



Future <void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) async{

  });
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider<Data>(
    create:(context) => Data(),
    child: MaterialApp(
       home: await Services().getBoolToSF()? MainScreen(): HomeScreen(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}
