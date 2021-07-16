import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class InfoDialog extends StatefulWidget {

  @override
  _InfoDialogState createState() => _InfoDialogState();
}

class _InfoDialogState extends State<InfoDialog> {
  int currentPos = 0;

  List <Widget> item = [
    Center(
      child: Text("📍Suites App connects you with hotels, bars, Casinos and Relaxation"
          " centers in Benin City.",style: TextStyle(
          height: 1.5
      ),
      ),
    ),
    Center(
      child: Text("📍Get updated locations of fun centers via Google Map ",style: TextStyle(
          height: 1.5
      ),),
    ),
    Center(
      child: Text("📍You can also give your own rating for the places"
          " you have visited ",style: TextStyle(
          height: 1.5
      ),),
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Column(
        children: [
          Expanded(
            flex: 4,
            child:  Image.asset(
            "images/popimage.png",
              fit: BoxFit.cover,
             //   width: double.infinity,

            ),

          ),
          Expanded(
            flex: 2,
            child: CarouselSlider(
              items: item,
              options: CarouselOptions(
                  height: 500,
                  aspectRatio: 16/9,
                  viewportFraction: 0.9,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  reverse: false,
                  autoPlay: false,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index,reason){
                    setState(() {
                      currentPos = index;
                    });
                  }

              ),
            )
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: item.map((e) {
              int index = item.indexOf(e);
              return Container(
                width: 6.0,
                height: 6.0,
                margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 2.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentPos == index?
                    Color.fromRGBO(0, 0, 0, 0.9)
                        : Color.fromRGBO(0, 0, 0, 0.4)
                ),
              );
            }).toList(),
          ),
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("Got It"))
        ],
      ),
    );
  }
}
