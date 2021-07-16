
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Data extends ChangeNotifier{


List <int> liked = [9];
String auth;
User userInfo;

  void likeMethod(int num){

    if(!liked.contains(num)){
      liked.add(num);
    }else{
      liked.remove(num);
    }
    notifyListeners();


  }

  void updateText(String text){
   auth = text;
    notifyListeners();
  }

void updateUser(User user){
    userInfo = user;
    notifyListeners();
}


}