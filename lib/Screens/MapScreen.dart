import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:suites/Networking/FireWorks.dart';
import 'package:suites/Screens/Hotelpage.dart';
import 'package:suites/Services.dart';
import 'package:suites/Services/Listener.dart';
import 'package:suites/TestWidget.dart';
import 'package:suites/Widgets/HotelCard.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  GoogleMapController _controller;
  List<Marker> allMarkers = [];
  PageController _pageController;
  int prevPage;
  String user;
  GeoPoint latLng;
  List<QueryDocumentSnapshot> list = [];

  @override
  void initState() {
    super.initState();
    FireWorks().internetCheck().then((value) {
      if(value == false){
        Services().displayToast("Turn on Internet Connection to view Map");
      }
    });
    getBoolToSF().then((value){
      print(value);
      user =  Provider.of<Data>(context,listen: false).auth ?? value[0];
      getCoords(user).then((value){
        list.forEach((element) {
          latLng = element.data()["coord"];
          allMarkers.add(Marker(
              markerId: MarkerId(element.data()["name"]),
              draggable: false,
              infoWindow:
              InfoWindow(title: element.data()["name"], snippet: element.data()["location"]),
              position: LatLng(latLng.latitude,latLng.longitude)));
          setState(() {});
        });
      });
    });
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScroll);
  }



  void _onScroll() {
    if (_pageController.page.toInt() != prevPage) {
      prevPage = _pageController.page.toInt();
      moveCamera();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height - 50.0,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(6.3350, 5.6037), zoom: 15.0),
                markers: Set.from(allMarkers),
                onMapCreated: mapCreated,
              ),
            ),
            Positioned(
              bottom: 20.0,
              child: Container(
                height: 200.0,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _coffeeShopList(index);
                  },
                ),
              ),
            )
          ],
        ));
  }


  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  moveCamera() {
    GeoPoint geoPoint = list[_pageController.page.toInt()].data()["coord"];
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(geoPoint.latitude,geoPoint.longitude),
        zoom: 15.0,
        bearing: 45.0,
        tilt: 45.0)));
  }

  _coffeeShopList(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: InkWell(
          onTap: () {
          },
          child: Stack(children: [
            Center(
                child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 20.0,
                    ),
                    height: 125.0,
                    width: 275.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 10.0,
                          ),
                        ]),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: list.isEmpty? Text("loading"):Row(children: [
                          Container(
                              height: 90.0,
                              width: 90.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10.0),
                                      topLeft: Radius.circular(10.0)),
                                  image: DecorationImage(
                                      image: NetworkImage(

                                          list[index].data()["image"]),
                                      fit: BoxFit.cover))),
                          SizedBox(width: 5.0),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      list[index].data()["name"].toString().length > 23 ?
                                      "${  list[index].data()["name"].toString().substring(
                                          0, 20)}..." :
                                      list[index].data()["name"].toString(),
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.5
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.location_on, size: 16.0,
                                            color: Colors.black87),
                                        Text(   list[index].data()["location"].toString().length > 23 ?
                                        "${  list[index].data()["location"].toString().substring(
                                            0, 20)}..." :
                                        list[index].data()["location"].toString(),
                                          style: TextStyle(
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.w600),),
                                      ],),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    RatingBar.builder(
                                      onRatingUpdate: null,

                                      itemSize: 15.0,

                                      initialRating: toDecimal(list[index].data()["myrating"]),


                                      direction: Axis.horizontal,

                                      allowHalfRating: false,

                                      itemCount: 5,

                                      itemBuilder: (context, _) =>
                                          Icon(

                                            Icons.star,

                                            color: Colors.amber,

                                          ),),
                                  ]),
                            ),
                          )
                        ]))))
          ])),
    );
  }

  Future <void> getCoords(String id) async {
    await FirebaseFirestore.instance.collection(id)
        .where("name",isEqualTo: null)
        .get().then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        if(element.data()["name"]!= null){
          list.add(element);
        }
      }
      );
    });
  }
}