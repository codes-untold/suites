import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class  CardInfo extends StatefulWidget {

  List<dynamic> imgList = [];

  CardInfo({this.imgList});
  @override
  _CardInfoState createState() => _CardInfoState();
}

class _CardInfoState extends State<CardInfo> {
  List <dynamic> item = [];


  @override
  void initState() {
   item = widget.imgList;
   print(item);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: Column(

  children: [

    CarouselSlider(


      items: item.map((e){

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




 Padding(padding: EdgeInsets.all(20.0),child: Column(
   children: [
     Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
         Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text("Mandarin Oriental",style: TextStyle(
               color: Colors.black54,fontWeight: FontWeight.w800,fontSize: 18.0
             ),),
             SizedBox(height: 5.0,),
             Row(
               children: [
               Icon(Icons.location_on,size: 16.0,color: Colors.black87),
               Text("London bridge"),
             ],)
           ],
         ),
         MaterialButton(
           onPressed: (){},
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
              Text("Price"),
              SizedBox(
                height: 5.0,
              ),
              Row(children: [
                Image.asset("images/nairasign.png",
                  width: 15.0,
                  height: 15.0,),
                Text("19,200",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800),)
              ],)
            ],
          ),
        SizedBox(
          width: 30.0,
        ),
        Column(
          children: [
            Text("Rating"),
          ],
        ),
              ],
     ) ],
 ),) ]
          ),
    );
  }
}
