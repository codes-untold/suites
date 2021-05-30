import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suites/ForgotScreen.dart';
import 'package:suites/Hotelpage.dart';
import 'package:suites/RegisterScreen.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  final _auth = FirebaseAuth.instance;
  String password;
  String email;
  int y = 8778;

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
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Container(
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
                  TextField(
                    onChanged: (value){
                      email = value;
                    },
                    keyboardType: TextInputType.emailAddress,
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
                  TextField(
                    onChanged: (value){
                      password = value;
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
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
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
                    onPressed: ()async{

                      try {
                        final newUser = await  _auth.signInWithEmailAndPassword(email: email, password: password);
                        if(newUser != null){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                            return Hotelpage();
                          }));
                        }
                      }  catch (e) {

                        print(e.toString());
                      }
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
    );
  }
}
