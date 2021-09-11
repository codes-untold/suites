
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:suites/Screens/LoginScreen.dart';
import 'package:suites/Screens/MainScreen.dart';
import 'file:///C:/Users/xeroes/AndroidStudioProjects/suites/lib/Services/Services.dart';
import 'package:suites/Services/Listener.dart';

class Authentication{
  final _auth = FirebaseAuth.instance;
  Services services = Services();



//create user account on firebase
Future <void> createUser(username,email,password)async{
  try {
    UserCredential newUser = await  _auth.createUserWithEmailAndPassword(email: email, password: password);
    if(newUser != null){
      await newUser.user.updateDisplayName(username).then((value)async{
        CollectionReference users = FirebaseFirestore.instance.collection(_auth.currentUser.uid);
        await users.doc(_auth.currentUser.uid).set({"id":_auth.currentUser.uid})
            .then((value)async {
          await newUser.user.sendEmailVerification().then((value){
            services.displayToast("Please check your email for verification");
          });
        })
            .catchError((error){print(error);});

      });

    }
  } on Exception catch (e) {

    if(e.toString().contains("EMAIL_ALREADY_IN_USE")){
      services.displayToast("Email aleady exists");
    }

    if(e.toString().contains("NETWORK_REQUEST_FAILED")){
      services.displayToast("Network problem occured");
    }
  }
}


  //check for wrong email formatting
  bool checkEmail(String value){
    if(!RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(value)){
      return false;
    }
    else{
      return true;
    }
      }

  //login user into app
      Future <void> loginUser(String email,password,context)async{

        try {
          final newUser = await  _auth.signInWithEmailAndPassword(email: email, password: password);

          if(newUser != null) {
            if (newUser.user.emailVerified) {
              print(_auth.currentUser.uid);
              addBoolToSF(_auth);
              print(_auth.currentUser.uid);
              Provider.of<Data>(context,listen: false).updateUser(_auth.currentUser);
              Navigator.push(context,PageTransition(type: PageTransitionType.fade,child: MainScreen()));

            }
            else {
              services.displayToast("Email not verified");
            }
          }
        } on Exception catch (e) {
          print(e.toString());
          if(e.toString().contains("network-request-failed")){
            services.displayToast("Network problem occured");
          }

          if(e.toString().contains("The password is invalid")){
            services.displayToast("Incorrect password");

          }
          if(e.toString().contains("no user record")){
            services.displayToast("User not found");
          }
        }
      }

      //Sends user email for password reset
      Future <void> resetEmail(email)async{
        try {
          await  _auth.sendPasswordResetEmail(email: email);
          services.displayToast(" Reset link has been sent to your email");

        } on Exception catch (e) {
          if(e.toString().contains("no user record")){
            services.displayToast("User not found");
          }
        }
      }
}