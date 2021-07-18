import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';


class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscureText = true;
  bool loading = false;
  String username;
  String email;
  String password;
  final _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool textCheck = false;
  bool wordCheck = false;



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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ModalProgressHUD(
            inAsyncCall: loading,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Flexible(
                        child: Text("Create an Account!",
                          style: TextStyle(
                              fontSize: 18.0
                          ),),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        validator: (value){
                          if(value.isEmpty){
                            return "Username is Required";
                          }
                          return null;
                        },
                        onSaved: (value){
                          username = value;
                        },
                        decoration: InputDecoration(
                            labelText: "Username",
                            filled: true,
                            contentPadding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                            prefixIcon: Icon(Icons.person_outline),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none
                            )
                        ),
                      ),
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
                        obscureText: _obscureText,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value){
                          if(value.isEmpty){
                            return "Password is Required";
                          }
                          if(value.length<6){
                            return "Password should be at least six characters";
                          }
                          return null;
                        },
                        onSaved: (value){
                          password = value;
                        },
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
                        height: 10.0,
                      ),
                      RaisedButton(
                        onPressed: ()async{

                          if(!_formkey.currentState.validate()){
                            return;
                          }

                          _formkey.currentState.save();
                          setState(() {
                            loading = true;
                          });

                         try {
                           UserCredential newUser = await  _auth.createUserWithEmailAndPassword(email: email, password: password);


                       if(newUser != null){

                       await  _auth.currentUser.updateDisplayName(username);
                         print(_auth.currentUser.uid);
                        CollectionReference users = FirebaseFirestore.instance.collection(_auth.currentUser.uid);
                        await users.doc(_auth.currentUser.uid).set({"id":_auth.currentUser.uid})
                        .then((value) => print("user added"))
                         .catchError((error){print(error);});

                      await newUser.user.sendEmailVerification();

                      setState(() {
                           loading = false;
                         });
                         Fluttertoast.showToast(
                             msg: "Please check your email for verification",
                             toastLength: Toast.LENGTH_LONG,
                             gravity: ToastGravity.BOTTOM,
                             timeInSecForIosWeb: 1,
                             textColor: Colors.white,
                             fontSize: 12.0
                         );
                       }

                         }  catch (e) {
                           setState(() {
                             loading = false;
                           });
                          print(e.toString());
                          if(e.toString().contains("EMAIL_ALREADY_IN_USE")){
                            Fluttertoast.showToast(
                                msg: "Email already exists",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                textColor: Colors.white,
                                fontSize: 12.0
                            );
                          }

                           if(e.toString().contains("NETWORK_REQUEST_FAILED")){
                             Fluttertoast.showToast(
                                 msg: "Network problem occured",
                                 toastLength: Toast.LENGTH_LONG,
                                 gravity: ToastGravity.BOTTOM,
                                 timeInSecForIosWeb: 1,
                                 textColor: Colors.white,
                                 fontSize: 12.0
                             );
                           }

                         }
                        },
                        padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                        child: Text("Sign Up",
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
                          Navigator.pop(context);
                        },
                        child: Text("I've already an account",
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

      ));
  }
}



