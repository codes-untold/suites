import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:suites/Widgets/OnBoardWidgetOne.dart';
import 'package:suites/Widgets/OnBoardWidgetThree.dart';
import 'package:suites/Widgets/OnBoardWidgetTwo.dart';

import 'LoginScreen.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List <Widget> item = [HomeOne(),HomeTwo(),HomeThree()];

  int currentPos = 0;
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0,left: 15.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                    return LoginScreen();
                  }));
                },
                child: Text("SKIP",
                  style:  TextStyle(
                      color: Colors.blue[700],
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500
                  ),),
              ),
            ),

            Expanded(
              flex: 12,
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
                        if(currentPos == 2){
                          isVisible = true;
                        }
                      });
                    }

                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Stack(
                  alignment: Alignment.bottomCenter,
                  children:[Row(
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
                    Visibility(
                      visible: isVisible,
                      child: Positioned(
                          bottom: 0.1,
                          right: 8.0,
                          child: FlatButton(
                              onPressed: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                  return LoginScreen();
                                }));
                              },
                              child: Text("DONE",
                                style: TextStyle(
                                    color: Colors.white
                                ),),
                              color: Colors.blue[700]
                          )
                      ),
                    ),]
              ),
            )
          ],
        ),
      ),
    );
  }
}

