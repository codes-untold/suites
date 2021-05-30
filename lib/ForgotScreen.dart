import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suites/RegisterScreen.dart';


class ForgotScreen extends StatelessWidget {
  int y = 8778;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
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
                TextField(
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
                  onPressed: (){},
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
    );
  }
}



