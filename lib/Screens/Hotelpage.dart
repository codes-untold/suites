
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suites/Networking/FireWorks.dart';
import 'package:suites/Services/Listener.dart';
import 'package:suites/Widgets/CalendarWidget.dart';
import 'package:suites/Widgets/HotelCard.dart';
import 'package:suites/Widgets/InfoColumn.dart';

import '../Services.dart';



class Hotelpage extends StatefulWidget {

  bool isFavouritePage;

  Hotelpage({this.isFavouritePage});
  @override
  _HotelpageState createState() => _HotelpageState();
}

class _HotelpageState extends State<Hotelpage> {

  SharedPreferences sharedPreferences;
  Map<String,dynamic> list = {};
  String  user;
  String username;
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
   user =  Provider.of<Data>(context,listen: false).userInfo?.uid ?? value[0];
    username =  Provider.of<Data>(context,listen: false).userInfo?.displayName ?? value[1];
    print(user);
    FireWorks().addUser(user, list);


  });
});
  }


    @override
  Widget build(BuildContext context) {
    return Padding(
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
                            Text(widget.isFavouritePage?
                              "Favourites💙":DateTime.now().hour > 17? "Good Evening $username🌤":"Good Day $username🌤",
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
                                      child: CalendarWidget(function:(String text){
                                        Services().showInSnackBar(text, context);
                                      },
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
                    children: [InfoColumn(check: "Check in",month: Services().getMonth(checkIn.month),day: checkIn.day),
                       InfoColumn(check: "Lodge",month: "Single",),
                      InfoColumn(check: "Check Out",month: Services().getMonth(checkOut.month),day: checkOut.day,),
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

                    onError: (e){
                      return Text("Please check your Internet Connection");
                    },

                    listeners: [refreshedChangeListener,data],
                    itemsPerPage: 1,
                    itemBuilderType: PaginateBuilderType.listView,
                    itemBuilder: (index,context,documentsnapshot){

                         if(documentsnapshot.data()["favourite"] == false){
                         }
                        return  Column(
                          children: [
                            HotelCard(querySnapshot: documentsnapshot.data(),index: index,user:user,function:(String text){
                              Services().showInSnackBar(text,context);
                      }
                           ,snapshot: documentsnapshot,check: multiplier_Check,multiplier: multiplier,),
                            SizedBox(
                              height: 20,
                            ) ],
                        );

                    },
                    query: widget.isFavouritePage?FirebaseFirestore.instance.collection(user)
                        .orderBy("name").where("favourite",isEqualTo: true):
                    FirebaseFirestore.instance.collection(user).orderBy("name")
                    ,
                    isLive: true,),
                ),
              ),
            ],
          ),
        );
  }

}
Future <List<String>> getBoolToSF()async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  List <String> boolvalue = preferences.getStringList("UID");
  return boolvalue;

}