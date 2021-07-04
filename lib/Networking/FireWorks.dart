
import 'package:cloud_firestore/cloud_firestore.dart';

class FireWorks{


  Future <void> addUser(String user,Map<String,dynamic> list)async{
    int a = 0;
    var res = await FirebaseFirestore.instance.doc("$user/${user}1").get();

    if(res.exists){
      print("exists");
      await FirebaseFirestore.instance.collection("hotels").get().then((QuerySnapshot querySnapshot){
        querySnapshot.docs.forEach((element)async {

          list = element.data();
          list.removeWhere((key, value) => key == "favourite");



          a++;

          await FirebaseFirestore.instance.collection(user).doc("$user$a").update(list).then((value){})
              .onError((error, stackTrace){print(error);});
        });
      });
    }

    else{
      print("doesnt exist");
      await FirebaseFirestore.instance.collection("hotels").get().then((QuerySnapshot querySnapshot){
        querySnapshot.docs.forEach((element)async {
          a++;

          await FirebaseFirestore.instance.collection(user).doc("$user$a").set(element.data()).then((value){})
              .onError((error, stackTrace){print(error);});
        });
      });
    }


  }
}