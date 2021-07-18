
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suites/Networking/FireWorks.dart';

import 'Screens/Hotelpage.dart';
import 'Services/Listener.dart';


class TestWidget extends StatefulWidget {
  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
bool p;
  @override
  void initState() {

    work();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Container();


  }

  work()async{
    p = await FireWorks().internetCheck();
    print(p);
  }
}
