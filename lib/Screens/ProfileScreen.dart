import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suites/Screens/FavouriteScreen.dart';
import 'package:suites/Screens/Hotelpage.dart';
import 'package:suites/Screens/TopRatingScreen.dart';
import 'package:suites/Services/Listener.dart';
import 'package:suites/Widgets/InfoDialog.dart';

import 'LoginScreen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  ImageProvider logo = AssetImage("images/backdrop2.jpg");
  String username;
  final _auth = FirebaseAuth.instance;
  bool loading = false;
  bool screenLoading= false;
  Uint8List imageData;


  @override
  void didChangeDependencies() {
    precacheImage(logo, context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    getBoolToSF().then((value){
      setState(() {
        print(value);
        username =  Provider.of<Data>(context,listen: false).userInfo?.displayName ?? value[1];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: logo != null ?SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: loading,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.topStart,
                  children: [
                    Container(
                      child: Image(image: logo,),
                      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height *0.07978),
                    ),
                    Positioned(
                      top: 165,
                      child:
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 2,color: Colors.blue)
                        ),
                        child: CircleAvatar(
                            backgroundImage: AssetImage("images/avatar.jpg"),
                            radius:  MediaQuery.of(context).size.width * 0.1388,
                            backgroundColor: Colors.white
                        ),
                      ),),
                    Positioned(
                        top: 220,
                        left: MediaQuery.of(context).size.width *0.39,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(username!=null?username:"...",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700
                              ),),
                            Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("Active",
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.black54
                                  ),),
                              ],
                            ),

                          ],
                        ))
                  ],
                ),

                SizedBox(height: screenSize * 0.0465,),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InfoTile(name: "About",color1: Colors.blue[50],
                        color2: Colors.blue,data: Icons.info,function: (){
                          dialogFunction(context);

                        },),
                      SizedBox(height: screenSize * 0.0398 ,),

                      InfoTile(name: "Favourites",color1: Colors.orange[100],
                          color2: Colors.deepOrangeAccent,data: Icons.favorite,function: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return FavouriteScreen();
                          }));
                        },),

                      SizedBox(height: screenSize * 0.0398 ,),

                      InfoTile(name: "Top Ratings",color1: Colors.blue[50],
                          color2: Colors.blue,data: Icons.star,function: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return TopRatingScreen();
                          }));
                        },),

                      SizedBox(height: screenSize * 0.093,),

                      OutlinedButton(onPressed: (){
                        signOut();
                      },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.exit_to_app_outlined,
                              color: Colors.deepOrangeAccent,),
                            SizedBox(width: 5,),
                            Text("Sign Out",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300
                              ),
                            )
                          ],
                        ),

                        style: OutlinedButton.styleFrom(
                            side:  BorderSide(
                                color: Colors.grey,
                                style: BorderStyle.solid
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            )
                        ) ,  )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ):Center(child: CircularProgressIndicator(),),
    );
  }

  signOut()async{
    setState(()=> loading = true);


    await _auth.signOut().then((value)async{

      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setBool("boolvalue", false);
      setState((){

        loading = false;});

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return LoginScreen();
      }));
    }).onError((error, stackTrace){
      setState(()=> loading = false);
      Fluttertoast.showToast(
          msg: "Failed to log out",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 12.0
      );
    });
    }
}

class RowWidget extends StatelessWidget {

  String name;
  Color color1;
  Color color2;

  RowWidget({this.name,this.color1,this.color2});
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      CircleAvatar(
        backgroundColor: color1,
        radius: 20,
        child: Icon(Icons.person,color: color2,),
      ),
      SizedBox(width: 10,),
      Text(name),
    ],);
  }
}

class InfoTile extends StatelessWidget {


  String name;
  Color color1;
  Color color2;
  IconData data;
  Function function;

  InfoTile({this.name,this.color1,this.color2,this.data,this.function});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 8,
          child: Row(children: [
            CircleAvatar(
              backgroundColor: color1,
              radius: 20,
              child: Icon(data,color: color2,size: 15,),
            ),
            SizedBox(width: 10,),
            Text(name),
          ],),
        ),

        Expanded(
            flex: 2,
            child: Container(
                child: GestureDetector(
                    onTap: function,
                    child: RoundContainer())))
      ],
    );
  }
}

class RoundContainer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 20,
        height: 20,

        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.grey[300]
            ),
            borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        child: Icon(Icons.arrow_forward_ios,
          size: 8,)
    );


  }
}

dialogFunction(BuildContext context){
  showDialog(context: context, builder: (context){
    return Dialog(
      elevation: 16,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        child: InfoDialog(),

      ),
    );
  });
}

