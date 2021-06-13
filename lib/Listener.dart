
import 'package:flutter/cupertino.dart';

class Data extends ChangeNotifier{

  void change(){
    notifyListeners();
  }
}