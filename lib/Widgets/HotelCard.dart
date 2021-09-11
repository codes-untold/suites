import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:page_transition/page_transition.dart';
import 'package:suites/Screens/CardInfo.dart';
import 'file:///C:/Users/xeroes/AndroidStudioProjects/suites/lib/Services/Services.dart';
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
      if(widget.querySnapshot[Constants.HOTEL_FAVOURITE] == true){
        icon = Icons.favorite_rounded;
      }else{
        icon = Icons.favorite_border_rounded;
      }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: (){
        Navigator.push(context,PageTransition(type: PageTransitionType.fade,child: CardInfo(
        function: widget.function,snapshot: widget.snapshot,user: widget.user,
        ),duration: Duration(milliseconds: 500)));

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
                imageUrl: widget.querySnapshot[Constants.HOTEL_IMAGE],
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
                      Text(widget.querySnapshot[Constants.HOTEL_NAME],
                          style: Constants.hotelText),
                      Row(children: [
                        Image.asset("images/nairasign.png",
                          width: 15.0,
                          height: 15.0,),
                        Text(widget.check == false? Services().
                        fixPrice(widget.querySnapshot[Constants.HOTEL_PRICE].toString()):
                        Services().fixPrice( (widget.querySnapshot[Constants.HOTEL_PRICE] * widget.multiplier).toString()),
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
                              Text(widget.querySnapshot[Constants.HOTEL_LOCATION],
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
                              Text("${widget.querySnapshot[Constants.GENERAL_RATING]} Ratings",style:
                              TextStyle(
                                  color: Colors.black54
                              ),)
                            ],
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: updateFavouriteIcon,
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

  void updateFavouriteIcon()async{

    if (icon == Icons.favorite_border_rounded) {
      icon = Icons.favorite_rounded;
      widget.function("${widget.querySnapshot[Constants.HOTEL_NAME]} Added to Favourites😀");
      setState(() {
      });

      await FirebaseFirestore.instance.collection(widget.user).doc(widget.snapshot.id)
          .update({Constants.HOTEL_FAVOURITE: true});

    }

    else {
      icon = Icons.favorite_border_rounded;
      widget.function("${widget.querySnapshot[Constants.HOTEL_NAME]} Removed from Favourites•☹️");
      setState(() {

      });
      await FirebaseFirestore.instance.collection(widget.user).doc(widget.snapshot.id
      ).update({Constants.HOTEL_FAVOURITE: false});
    }
  }
}

        double toDecimal(value){
          return value.roundToDouble();
        }
