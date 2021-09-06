
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Services{

   displayToast(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 12.0
    );
  }


   String getMonth(int date){
     switch(date){
       case 1: return "JAN";
       break;

       case 2: return "FEB";
       break;

       case 3: return "MAR";
       break;

       case 4: return "APR";
       break;

       case 5: return "MAY";
       break;

       case 6: return "JUN";
       break;

       case 7: return "JULY";
       break;

       case 8: return "AUG";
       break;

       case 9: return "SEP";
       break;

       case 10: return "OCT";
       break;

       case 11: return "NOV";
       break;

       case 12: return "DEC";
       break;
     }
   }


   showInSnackBar(String text,BuildContext context){
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
   }




   String fixPrice(String price){
     switch (price.length) {
       case 4:
         return "${price.substring(0, 1)},${price.substring(1, 4)}";
         break;

       case 5:
         return "${price.substring(0, 2)},${price.substring(2, 5)}";
         break;

       case 6:
         return "${price.substring(0, 3)},${price.substring(3, 6)}";
         break;

       case 7:
         return "${price.substring(0,1)},${price.substring(1, 4)},${price.substring(4, 7)}";
     }

   }

}