
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Data extends ChangeNotifier{


String auth;
User userInfo;


  void updateText(String text){
   auth = text;
    notifyListeners();
  }

void updateUser(User user){
    userInfo = user;
    notifyListeners();

}

}