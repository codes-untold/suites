import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:suites/Services/constants.dart';
import 'package:suites/Widgets/HotelCard.dart';

import '../Services/Services.dart';


// ignore: must_be_immutable
class CardInfo extends StatefulWidget {

  Function function;
  DocumentSnapshot snapshot;
  String user;


  CardInfo({this.function,this.snapshot,this.user});
  @override
  _CardInfoState createState() => _CardInfoState();
}

class _CardInfoState extends State<CardInfo> {
  List <dynamic> imageList = [];
  List <dynamic> featureList = [];
  double ratingg;



  @override
  void initState() {

    ratingg = toDecimal(widget.snapshot.data()[Constants.USER_RATING]??0);
    imageList = widget.snapshot.data()[Constants.HOTEL_IMAGE_LIST];
    featureList = widget.snapshot.data()[Constants.HOTEL_FEATURES];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            children: [
              CarouselSlider(
                items: imageList.map((e){
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    child: CachedNetworkImage(
                      imageUrl: e,
                      placeholder:  (context,url) => Icon(Icons.hotel,color:Colors.black12,size: MediaQuery.of(context).size.width *0.6),
                      imageBuilder: (context,imageProvider)=>Container(
                        height:  MediaQuery.of(context).size.height * 0.35,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.fill
                            )
                        ),
                      ),
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.35,
                  aspectRatio: 16/9,
                  viewportFraction: 1.0,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,),),



              Padding(padding: EdgeInsets.all(12.0),child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.snapshot.data()[Constants.HOTEL_NAME],style: TextStyle(
                              color: Colors.black54,fontWeight: FontWeight.w800,fontSize: 18.0
                          ),),
                          SizedBox(height: 5.0,),
                          Row(
                            children: [
                              Icon(Icons.location_on,size: 16.0,color: Colors.black),
                              Text(widget.snapshot.data()[Constants.HOTEL_LOCATION]),
                            ],)
                        ],
                      ),

                      MaterialButton(
                        onPressed: (){
                          shareImage();
                        },
                        child: Icon(Icons.share_outlined,size: 18.0,color: Colors.blue,),
                        color: Colors.blue[50],
                        shape: CircleBorder(),

                      )  ],



                  ),

                  SizedBox(
                    height: 20.0,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Constants.HOTEL_PRICE,
                            style:  TextStyle(
                                color: Colors.black54,fontWeight: FontWeight.w800,fontSize: 14.0
                            ),),

                          SizedBox(
                            height: 5.0,
                          ),

                          Row(children: [
                            Image.asset("images/nairasign.png",
                              width: 15.0,
                              height: 15.0,),
                            Text(Services().fixPrice(widget.snapshot.data()[Constants.HOTEL_PRICE].toString()),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800),)
                          ],)

                        ],

                      ),

                      SizedBox(

                        width: 30.0,

                      ),

                      Column(

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          Text("Rating",style:  TextStyle(

                              color: Colors.black54,fontWeight: FontWeight.w800,fontSize: 14.0

                          ),),

                          SizedBox(

                            height: 5.0,

                          ),

                          Row(

                            children: [

                              Text(ratingg.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800),),

                              SizedBox(

                                width: 5.0,

                              ),

                              RatingBar.builder(

                                itemSize: 15.0,

                                initialRating: ratingg,

                                direction: Axis.horizontal,

                                allowHalfRating: false,

                                itemCount: 5,

                                itemBuilder: (context,_)=> Icon(

                                  Icons.star,

                                  color: Colors.amber,

                                ), onRatingUpdate: (rating){

                                print(rating);

                                setState(() {

                                  ratingg = rating;
                                  updateRating();
                                  ScaffoldMessenger.of(context).showSnackBar

                                    (SnackBar(content: Text("Your rating has been recorded")));


                                });

                              },),

                            ],

                          )

                        ],



                      ),



                    ],

                  ),

                  SizedBox(

                    height: 20.0,

                  ),



                  Container(

                    width: MediaQuery.of(context).size.width,

                    height: MediaQuery.of(context).size.height * 0.1,

                    child: ListView.builder(itemBuilder: (BuildContext context, int i){

                      return Padding(

                        padding: const EdgeInsets.only(right: 10),

                        child: Card(

                          color: Colors.blue[50],

                          elevation: 5.0,

                          shape: RoundedRectangleBorder(

                              borderRadius: BorderRadius.all(

                                  Radius.circular(6.0))),

                          child: Container(

                            width: MediaQuery.of(context).size.width * 0.2,

                            height:  MediaQuery.of(context).size.height * 0.1,

                            child: Column(

                              mainAxisSize: MainAxisSize.min,

                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [

                                Icon(getWidget(featureList[i]),color: Colors.blue,size:MediaQuery.of(context).size.height *0.03,),

                                SizedBox(

                                  height: 5,

                                ),

                                Text(featureList[i],style: TextStyle(color: Colors.black54,fontSize: 12.0,fontWeight: FontWeight.w700),)

                              ],

                            ),

                          ),

                        ),

                      );



                    },



                      itemCount: featureList.length,

                      scrollDirection: Axis.horizontal,

                      shrinkWrap: true,



                    ),

                  ),

                  SizedBox(

                    height: 25.0,

                  ),

                  Text("About",

                    style: TextStyle(

                        fontSize: 16.0,

                        fontWeight: FontWeight.w700,

                        color: Colors.black54

                    ),),

                  SizedBox(

                    height: 10,

                  ),

                  Text( widget.snapshot.data()[Constants.HOTEL_DESCRIPTION]

                    ,style: TextStyle(
                      height: 1.5,
                      //  letterSpacing: 2.0

                    ),)],

              ),) ]

        ),
      ),
    );
  }

  IconData getWidget(String value){
    switch(value){
      case "LowCost": return Icons.attach_money;
      break;
      case "Parking":return Icons.directions_car;
      break;
      case "Party": return Icons.celebration;
      break;
      case "Theater": return Icons.movie_outlined;
      break;
      case "Bar": return Icons.wine_bar_rounded;
      break;
      case "Pool": return Icons.pool;
      break;
      case "Spa": return Icons.spa;
      break;
      case "Games": return Icons.gamepad;
      break;
    }
    return null;
  }


  //Share image from app to other apps
  void shareImage()async{
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sharing...")));
    print(widget.snapshot.data()[Constants.HOTEL_NAME]);
    final response = await get(Uri.parse(imageList[0]));
    final bytes = response.bodyBytes;

    final Directory temp = await getExternalStorageDirectory();
    final File imageFile = File('${temp.path}/tempImage.jpg');
    imageFile.writeAsBytesSync(bytes);
    print('${temp.path}/tempImage');
    Share.shareFiles(['${temp.path}/tempImage.jpg'], text: widget.snapshot.data()[Constants.HOTEL_DESCRIPTION],
        subject:widget.snapshot.data()[Constants.HOTEL_NAME] );

  }

        //update user rating document on firebase firestore
        updateRating()async{
          await FirebaseFirestore.instance.collection(widget.user).doc(widget.snapshot.id)
              .update({Constants.USER_RATING:ratingg.round()}).then((value) {})
              .onError((error, stackTrace) {
            print(error);
          });
        }
}