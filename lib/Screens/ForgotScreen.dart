import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'file:///C:/Users/xeroes/AndroidStudioProjects/suites/lib/Screens/RegisterScreen.dart';
import 'package:suites/Networking/Authentication.dart';


class ForgotScreen extends StatefulWidget {
  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final _auth = FirebaseAuth.instance;
  bool loading = false;
  String email;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

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
                key:  _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Forgot Password?",
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

                        if(!Authentication().checkEmail(value)){
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
                    RaisedButton(
                      onPressed: (){
                        resetEmail(email);
                      },
                      padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                      child: Text("Reset Password",
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
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
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
    );
  }

  resetEmail(email)async{
    if(!_formkey.currentState.validate()){
      return;
    }

    _formkey.currentState.save();
    setState(() {
      loading = true;
    });

    Authentication().resetEmail(email).then((value){
      setState(() {
        loading = false;
      });
    });
  }
}


