import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:suites/ForgotScreen.dart';
import 'package:suites/Hotelpage.dart';
import 'package:suites/RegisterScreen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  List <Map<String,dynamic>> list = [];
  bool _obscureText = true;
  final _auth = FirebaseAuth.instance;
  String password;
  String email;
  bool loading = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();


  void toggle(){
    setState(() {
      if(_obscureText){
        _obscureText = false;
      }
      else{
        _obscureText = true;
      }
    });
  }


  addBoolToSF()async{

      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("UID", _auth.currentUser.uid);
      preferences.setBool("boolvalue", true);

  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: loading,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Container(
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Welcome Back!",
                      style: TextStyle(
                        fontSize: 18.0
                      ),),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (value){
                          if(value.isEmpty){
                            return "Email is required";
                          }

                          if(!RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(value)){
                            return "Please enter a valid email address";
                          }
                          return null;
                        },
                        onSaved: (value){
                          email = value;
                        },
                        decoration: InputDecoration(
                          labelText: "Email Address",
                            filled: true,
                            contentPadding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                            prefixIcon: Icon(Icons.mail_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none
                          )
                        ),
                      ),

                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        onChanged: (value){
                          password = value;
                        },
                        validator: (value){
                          if(value.isEmpty){
                            return "Password is Required";
                          }
                          if(value.length<6){
                            return "Password should be at least six characters";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                            labelText: "Password",
                            contentPadding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                        fillColor: Colors.grey[300],
                        filled: true,
                        prefixIcon: Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              onPressed: toggle,
                              icon: Icon(_obscureText == true? Icons.visibility_off:Icons.visibility),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none
                            )
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return ForgotScreen();
                            }));
                          },
                          child: Text("Forgot Password?",
                          textAlign: TextAlign.right,),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      RaisedButton(
                        onPressed: (){
                        authenticate();
                        },
                        padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                        child: Text("Sign in",
                        style: TextStyle(
                          color: Colors.white
                        ),),
                        color: Colors.blue[800],

                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return RegisterScreen();
                          }));
                        },
                        child: Text("I haven't an account",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          decoration: TextDecoration.underline
                        ),),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void authenticate()async{

    if(!_formkey.currentState.validate()){
      return;
    }

    _formkey.currentState.save();
    setState(() {
      loading = true;
    });


    try {
      final newUser = await  _auth.signInWithEmailAndPassword(email: email, password: password);
      if(newUser != null){
        setState(() {
          loading = false;
        });
        if(newUser.user.emailVerified){
          addBoolToSF();

          Navigator.push(context,PageTransition(type: PageTransitionType.fade,child: Hotelpage(
            authString: _auth.currentUser.uid,
          )));
        }
        else{
          Fluttertoast.showToast(
              msg: "Email not verified",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 12.0
          );
        }

      }
    }  catch (e) {
      setState(() {
        loading = false;
      });
      print(e.toString());
      if(e.toString().contains("WRONG_PASSWORD")){
        Fluttertoast.showToast(
            msg: "Wrong Password",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 12.0
        );

      }
      if(e.toString().contains("USER_NOT_FOUND")){
        Fluttertoast.showToast(
            msg: "User not Found",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 12.0
        );
      }
    }
  }
}
