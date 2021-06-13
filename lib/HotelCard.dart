import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:suites/Hotelpage.dart';
import 'package:suites/Listener.dart';
import 'constants.dart';

class HotelCard extends StatefulWidget {
  const HotelCard({
    Key key,
    @required this.querySnapshot,

    @required this.index,

    this.function,

    this.user
  }) : super(key: key);

  final DocumentSnapshot querySnapshot;

  final index;

  final String user;

  final Function function;

  @override
  _HotelCardState createState() => _HotelCardState();
}

class _HotelCardState extends State<HotelCard> {

  IconData icon;

  @override
  void initState() {

    if(widget.querySnapshot.data()["favourite"] == true){
      icon = Icons.favorite_rounded;
    }else{
      icon = Icons.favorite_border_rounded;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0),topRight:  Radius.circular(16.0)),
            child: CachedNetworkImage(
              imageUrl: widget.querySnapshot.data()["image"],
              placeholder: (context,url) => Icon(Icons.hotel,size: MediaQuery.of(context).size.width *0.6,
              color: Colors.black12,),
            )
            //Image.asset("images/room.jpg"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0,right: 10.0,bottom: 20.0,top: 20.0),
            child: Column(

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.querySnapshot.data()["name"],
                        style: Constants.hotelText),
                    Row(children: [

                      Image.asset("images/nairasign.png",
                        width: 15.0,
                        height: 15.0,),
                      Text(widget.querySnapshot.data()["price"],
                          style: Constants.hotelText),
                    ],),

                  ],
                ),
                SizedBox(
                  height: 8,
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
                            Text(widget.querySnapshot.data()["location"])
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
                    GestureDetector(
                      onTap: () {

                       work();

                      },
                      child: Icon(icon,
                        color: Colors.blue,),
                    )
                  ],
                )
              ],
            ),
          )],
      ),
    );
  }

  void work()async{

    if (  icon == Icons.favorite_border_rounded) {
      icon = Icons.favorite_rounded;
      print("on");
      widget.function("${widget.querySnapshot.data()["name"]} Added to Favourites😀");
      Data().change();
      setState(() {


      });
      await FirebaseFirestore.instance.collection(
          widget.user).doc(
          widget.querySnapshot.id
      ).update({"favourite": true});

    }

    else {
      icon = Icons.favorite_border_rounded;
      print("off");
      widget.function("${widget.querySnapshot.data()["name"]} Removed from Favourites•	☹️");
      Data().change();
      setState(() {

      });
      await FirebaseFirestore.instance.collection(
          widget.user).doc(
          widget.querySnapshot.id
      ).update({"favourite": false});
    }
  }
}


