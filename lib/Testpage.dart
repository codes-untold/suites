import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class Testpage extends StatefulWidget {
  @override
  _TestpageState createState() => _TestpageState();
}

class _TestpageState extends State<Testpage> {
String value;
QuerySnapshot querySnapshot;
  @override
  void initState() {
    print("uyfytr56rl");
   // download();
   // getData();
    super.initState();

  }

 Future <void> getData()async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
   /* FirebaseFirestore db  = FirebaseFirestore.instance;
   await db.collection("hotels").get().then((value) =>querySnapshot = value).catchError((error){
     print(error);
   });

print(querySnapshot.docs.map((e) => e.data()["image"]));*/

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    16)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0),topRight:  Radius.circular(16.0)),
                  child: Image.asset("images/room.jpg"),
                ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10.0,bottom: 20.0,top: 20.0),
                child: Column(

                  children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Protea Hotels"),
                    Text("400"),
                  ],
                ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.location_on,size: 15,),
                                SizedBox(width: 5.0,),
                                Text("Ugbowo")
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.star,size: 15,),
                                SizedBox(width: 5.0,),
                                Text("4.8 Ratings")
                              ],
                            )
                          ],
                        ),
                        Icon(Icons.favorite_border_rounded,
                        color: Colors.blue,)
                      ],
                    )
                  ],
                ),
              )],
            ),
          ),
        )

      ),


    );
  }
}






/* Future <void> download()async{

    firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
    String url = await storage.ref("hotel2.jpg").getDownloadURL();
    print(url);
    setState(() {
      value = url;
    });

  }*/

/*Padding(
          padding: const EdgeInsets.all(16.0),
          child: PaginateFirestore(
            itemsPerPage: 3,
            itemBuilderType: PaginateBuilderType.listView,
            itemBuilder: (index,context,documentsnapshot){
              return Column(
                children: [
                  FadeInImage.memoryNetwork(placeholder: placeholder, image: image),

                  ListTile(
                    leading: Image(
                      image: NetworkImage(documentsnapshot.data()["image"]),
                    ),
                    title: Text( documentsnapshot.data()["name"]),
                  ),
                  SizedBox(
                    height: 200
                  )
                ],
              );
            },
           query: FirebaseFirestore.instance.collection("hotels").orderBy("name"),
          isLive: true,),
        )*/


/*Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                            Row(
                              children: [
                                Icon(Icons.location_on,size: 15,),
                                SizedBox(width: 5.0,),
                                Text("Ugbowo")
                              ],
                            ),
                             Row(
                               children: [
                                 Icon(Icons.star,size: 15,),
                                 SizedBox(width: 5.0,),
                                 Text("4.8 Ratings")
                               ],
                             )
                           ],
                         )*/

/*   */