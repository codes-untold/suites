
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class TestWidget extends StatefulWidget {
  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {


  List<String> list = ["bbc","abc","abc","abc","abc","abc","abc","a",
    "abc","abc",];
  @override
  void initState() {

    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    print(MediaQuery.of(context).size.height);

    return Scaffold(
      backgroundColor: Colors.white,
body: SafeArea(
  child:   Center(
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.15,
      child: ListView.builder(itemBuilder: (BuildContext context, int i){
          return Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(6.0))),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.25,
              height:  MediaQuery.of(context).size.height * 0.15,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.attach_money,color: Colors.blue[600],size:MediaQuery.of(context).size.height *0.035,),
                  SizedBox(
                    height: 5,
                  ),
                  Text(list[i],style: TextStyle(color: Colors.black54,fontSize: 12.0,fontWeight: FontWeight.w700),)
                ],
              ),
            ),
          );

      },

      itemCount: list.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,

      ),
    ),
  ),
)
    );
  }


}


/*TextFormField(
                      onChanged: (value){
                        print(value);
                      //  Provider.of<Data>(context,listen: false).updateText(value);
                    //    print( Provider.of<Data>(context,listen: false).searchText);
                    setState(() {
                   searchText = value;

                      });
                      },

                      decoration: InputDecoration(
                          labelText: "Hotels nearby",
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                          suffixIcon:  IconButton(
                            icon: Icon(Icons.calendar_today_outlined),
                            onPressed: (){},
                          ) ,
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none
                          )
                      ),
                    )*/



/*StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("JT6VTVQQwveNUGtrZ9PRpRBnyht1").orderBy("name").snapshots(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            final datum = snapshot.data.docs;
            print(datum.length);

            List <String> words = [];
            for(var dat in datum){
              Map<String,dynamic> messageText = dat.data();
print(messageText);
            }
           // print(messageText);
          }else{
            print("problem");
          }
          return Text("");
        },
      )*/