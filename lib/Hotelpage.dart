import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suites/CalendarWidget.dart';
import 'package:suites/FireWorks.dart';
import 'package:suites/HotelCard.dart';
import 'package:suites/InfoColumn.dart';
import 'package:suites/Listener.dart';
import 'package:suites/TestWidget.dart';


class Hotelpage extends StatefulWidget {
  String authString;

  Hotelpage({this.authString});
  @override
  _HotelpageState createState() => _HotelpageState();
}

class _HotelpageState extends State<Hotelpage> {

  SharedPreferences sharedPreferences;
  Map<String,dynamic> list = {};
  String  user;
  PaginateRefreshedChangeListener refreshedChangeListener = PaginateRefreshedChangeListener();
  Data data = Data();
  DateTime checkIn = DateTime.now();
  DateTime checkOut = DateTime.now();
  int multiplier = 1;
  bool multiplier_Check = false;
  int selectedIndex = 0;


    void onItemTapped(int index){
  setState(() {
    selectedIndex = index;
  });
}


@override
  void initState(){
  super.initState();
  getBoolToSF().then((value){
  setState(() {
    print(value);
    user = widget.authString?? value;
    FireWorks().addUser(user, list);

  });
});
  }


    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                elevation: 5,
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
              10)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            SizedBox(
                              width: 12.0,
                            ),
                            Text(DateTime.now().hour > 17? "Good Evening Xeroes🌤":"Good Day Xeroes🌤",
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.0,
                                  color: Colors.black54

                              ),),
                          ],),


                          IconButton(
                            iconSize: 20.0,
                            icon: Icon( Icons.calendar_today_outlined
                            ,color: Colors.blue,),
                            onPressed: (){
                              showModalBottomSheet(context: context,
                                  builder: (context)=> Container(height:MediaQuery.of(context).size.height *0.80 ,
                                      child: CalendarWidget(function: showInSnackBar,
                                      result: (a,b){
                                        setState(() {
                                          checkIn = b;
                                          checkOut = a;
                                          multiplier = checkOut.day - checkIn.day;
                                          multiplier_Check = true;
                                        });

                                      },))
                                  ,isScrollControlled: true);
                            },
                          ),],
                      ),
                    ),
                  Divider(
                    thickness: 1.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [InfoColumn(check: "Check in",month: getMonth(checkIn.month),day: checkIn.day),
                       InfoColumn(check: "Lodge",month: "Single",),
                      InfoColumn(check: "Check Out",month: getMonth(checkOut.month),day: checkOut.day,),
                     ],
                  ),
                    SizedBox(
                      height: 10.0,
                    ),],
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Flexible(
                child: user == null ? Center(
                  child: CircularProgressIndicator(
                  ),
                ):RefreshIndicator(
                  onRefresh: ()async{
                    refreshedChangeListener.refreshed = true;
                  },
                  child: PaginateFirestore(


                    listeners: [refreshedChangeListener,data],
                    itemsPerPage: 1,
                    itemBuilderType: PaginateBuilderType.listView,
                    itemBuilder: (index,context,documentsnapshot){

                          return  Column(
                            children: [
                              HotelCard(querySnapshot: documentsnapshot.data(),index: index,user:user,function:
                              showInSnackBar,snapshot: documentsnapshot,check: multiplier_Check,multiplier: multiplier,),
                              SizedBox(
                                height: 20,
                              ) ],
                          );


                    },
                    query: FirebaseFirestore.instance.collection(user).orderBy("name"),
                    isLive: true,),
                ),
              ),
            ],
          ),
        ),
      ),
    bottomNavigationBar: BottomNavigationBar(
    items: const <BottomNavigationBarItem>
    [BottomNavigationBarItem(icon: Icon(Icons.home,size: 20.0,),label: "home"),
      BottomNavigationBarItem(icon: Icon(Icons.location_on_outlined,size: 20.0,),label: "location"),
      BottomNavigationBarItem(icon: Icon(Icons.person_outline_sharp,size: 20.0,),label: "profile")],
     currentIndex: selectedIndex,
    selectedItemColor: Colors.blue,
    onTap: onItemTapped,
      selectedLabelStyle: TextStyle(color: Colors.white,fontSize: 1.0),
      unselectedLabelStyle:  TextStyle(color: Colors.white,fontSize: 1.0) ,
    ),);
  }

  void fetchPlaceHolder(){
    rootBundle.load("images/placeholder.png").then((value){
      setState(() {
    //    this.imageData = value;
      });
    }).catchError((error){print(error);});
  }

  Future <String> getBoolToSF()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String boolvalue = preferences.getString("UID");
    return boolvalue;

  }

  showInSnackBar(String text){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
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

}

Future <List<String>> getListData()async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  List <String> list = preferences.getStringList("UID");
  return list;
}

addListData(List <String> list)async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setStringList("data", list);

}

