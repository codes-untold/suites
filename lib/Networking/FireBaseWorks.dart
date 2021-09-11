
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseWorks {



  //fetches existing user data from firebase fireStore or creates if not existing
  Future <void> getUserData(String user, Map<String, dynamic> list) async {
    int a = 0;
    var userDocument = await FirebaseFirestore.instance.doc("$user/${user}1").get();
    //if user document already exists, fetch documents from general list of courses
    //to add new courses to exisiting user's collection
    if (userDocument.exists) {
      print("exists");
      await FirebaseFirestore.instance.collection("hotels").get().then((
          QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((element) async {
          list = element.data();
          //Remove user specific fields to avoid overiding fields in user documents
          list.removeWhere((key, value) => key == "favourite");
          list.removeWhere((key, value) => key == "myrating");


          a++;

          await FirebaseFirestore.instance.collection(user).doc("$user$a")
              .update(list).then((value) {})
              .onError((error, stackTrace) {
            print(error);
          });
        });
      });
    }

    else {
      //if user document does not exist,fetch all item from general course list
      // and update user collection
      await FirebaseFirestore.instance.collection("hotels").get().then((
          QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((element) async {
          a++;

          await FirebaseFirestore.instance.collection(user).doc("$user$a").set(
              element.data()).then((value) {})
              .onError((error, stackTrace) {
            print(error);
          });
        });
      });
    }
  }


  Future <bool> internetCheck() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

}