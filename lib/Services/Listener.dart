
import 'package:flutter/cupertino.dart';

class Data extends ChangeNotifier{


List <int> liked = [9];
String searchText;

  void likeMethod(int num){

    if(!liked.contains(num)){
      liked.add(num);
    }else{
      liked.remove(num);
    }
    notifyListeners();


  }

  void updateText(String text){
    searchText = text;
    notifyListeners();
  }




}