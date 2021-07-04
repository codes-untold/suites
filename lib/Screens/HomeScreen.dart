import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:suites/LoginScreen.dart';

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

class HomeOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("images/reduced.png"),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [  Text("Book a Hotel",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17.0
            ),) ,
            Text("from Anywhere ✅",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17.0
              ),),
            SizedBox(
              height: 20.0,
            ),
            Text("Make suite Inquiries on the Go from "
                "any location and get up to date info "
                "on your desired suite",
              style: TextStyle(
                  fontSize: 13.5,
                  color: Colors.black45
              ),),],
        )
      ],
    );
  }
}

class HomeTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("images/centera.png"),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [  Text("Best spots",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17.0
            ),) ,
            Text("for the weekend ⛱️",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17.0
              ),),
            SizedBox(
              height: 20.0,
            ),
            Text("Get the best suggestions on where to spend your"
                " weekend with your friends and family",
              style: TextStyle(
                  fontSize: 13.5,
                  color: Colors.black45
              ),),],
        )
      ],
    );
  }
}

class HomeThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("images/end.png"),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [  Text("Find Recreational",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17.0
            ),) ,
            Text("Centres closeby  🏊",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17.0
              ),),
            SizedBox(
              height: 20.0,
            ),
            Text("The coolest recreational centres you should pay a visit "
                "to during your leisure time",
              style: TextStyle(
                  fontSize: 13.5,
                  color: Colors.black45
              ),),],
        )
      ],
    );
  }
}