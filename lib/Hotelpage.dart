import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suites/FireWorks.dart';
import 'package:suites/HotelCard.dart';
import 'package:suites/InfoColumn.dart';
import 'package:suites/Listener.dart';


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
  final GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();
  Data data = Data();



@override
  void initState(){
  super.initState();
  getBoolToSF().then((value){
  setState(() {
    user = value;
    FireWorks().addUser(user, list);

  });
});
  }


    @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Data>(
      create: (context) => Data(),
      child: Scaffold(
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
                      TextFormField(
                        onSaved: (value){

                        },
                        decoration: InputDecoration(
                            labelText: "Hotels nearby",
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                            suffixIcon:  IconButton(
                              icon: Icon(Icons.calendar_today_outlined),
                              onPressed: (){},
                            ) ,
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none
                            )
                        ),
                      ),
                    Divider(
                      thickness: 1.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [InfoColumn(),
                         InfoColumn(),
                        InfoColumn(),],
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
                  child: user == null ?Text(""):RefreshIndicator(
                    onRefresh: ()async{
                      refreshedChangeListener.refreshed = true;
                    },
                    child: PaginateFirestore(
                      listeners: [refreshedChangeListener,data],
                      itemsPerPage: 3,
                      onLoaded: (loaded){

                   //  print(loaded.documentSnapshots.last.data().update("favourite", (value) => null));
                      },
                      itemBuilderType: PaginateBuilderType.listView,
                      itemBuilder: (index,context,documentsnapshot){

                        return Column(
                          children: [
                            HotelCard(querySnapshot: documentsnapshot,index: index,user:user,function:
                              showInSnackBar,),
                         SizedBox(
                           height: 20,
                         ) ],
                        );
                      },
                      query: FirebaseFirestore.instance.collection(user).orderBy("name"),
                      isLive: false,),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
}

