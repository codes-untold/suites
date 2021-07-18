import 'package:flutter/material.dart';
import 'package:suites/Screens/Hotelpage.dart';


class FavouriteScreen extends StatefulWidget {
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Hotelpage(isFavouritePage: true,)),
    );
  }
}
