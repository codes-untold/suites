import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:suites/Screens/CardInfo.dart';
import 'package:suites/Services/Listener.dart';
import '../Services/constants.dart';

class HotelCard extends StatefulWidget {
   HotelCard({
    Key key,
    @required this.querySnapshot,

    @required this.index,

    this.function,

    this.user,

    this.snapshot,

    this.multiplier,

    this.check,


  }) : super(key: key);

  final  Map <String,dynamic> querySnapshot;

  final index;

  final String user;

  final Function function;

  final DocumentSnapshot snapshot;

  int multiplier;

  bool check;

  @override
  _HotelCardState createState() => _HotelCardState();
}

class _HotelCardState extends State<HotelCard> {

  IconData icon;

  @override
  void initState() {


      if(widget.querySnapshot["favourite"] == true){
        icon = Icons.favorite_rounded;
      }else{
        icon = Icons.favorite_border_rounded;
      }


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print(widget.multiplier);
    return GestureDetector(
      onTap: (){
        Navigator.push(context,PageTransition(type: PageTransitionType.fade,child: CardInfo(
        function: widget.function,snapshot: widget.snapshot,

        ),duration: Duration(seconds: 1)));

      },
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(16.0))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(topRight: Radius.circular(16.0),topLeft: Radius.circular(16.0)),
              child: CachedNetworkImage(
                imageUrl: widget.querySnapshot["image"],
                placeholder: (context,url) => Icon(Icons.hotel,size: MediaQuery.of(context).size.width *0.6,
                color: Colors.black12,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10.0,bottom: 20.0,top: 20.0),
              child: Column(

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.querySnapshot["name"],
                          style: Constants.hotelText),
                      Row(children: [

                        Image.asset("images/nairasign.png",
                          width: 15.0,
                          height: 15.0,),
                        Text(widget.check == false? fixPrice(widget.querySnapshot["price"].toString()):
                            fixPrice( (widget.querySnapshot["price"] * widget.multiplier).toString()),
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
                              Icon(Icons.location_on,size: 15,
                              color: Colors.blue,),
                              SizedBox(width: 5.0,),
                              Text(widget.querySnapshot["location"],
                              style: TextStyle(
                                color: Colors.black54
                              ),)
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.star,size: 15,
                                color: Colors.blue,),
                              SizedBox(width: 5.0,),
                              Text("4.8 Ratings",style:
                              TextStyle(
                                  color: Colors.black54
                              ),)
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
      ),
    );
  }

  void work()async{

    if (  icon == Icons.favorite_border_rounded) {
      icon = Icons.favorite_rounded;
      print("on");
      widget.function("${widget.querySnapshot["name"]} Added to Favourites😀");
      Provider.of<Data>(context,listen: false).likeMethod(widget.index);

      setState(() {


      });
      await FirebaseFirestore.instance.collection(
          widget.user).doc(
          widget.snapshot.id
      ).update({"favourite": true});

    }

    else {
      icon = Icons.favorite_border_rounded;
      print("off");
      widget.function("${widget.querySnapshot["name"]} Removed from Favourites•	☹️");
      Provider.of<Data>(context,listen: false).likeMethod(widget.index);
      setState(() {

      });
      await FirebaseFirestore.instance.collection(
          widget.user).doc(
          widget.snapshot.id
      ).update({"favourite": false});
    }
  }



}


String fixPrice(String price){
  switch (price.length) {
    case 4:
      return "${price.substring(0, 1)},${price.substring(1, 4)}";
      break;

    case 5:
      return "${price.substring(0, 2)},${price.substring(2, 5)}";
      break;

    case 6:
      return "${price.substring(0, 3)},${price.substring(3, 6)}";
      break;

    case 7:
      return "${price.substring(0,1)},${price.substring(1, 4)},${price.substring(4, 7)}";

  }


}
