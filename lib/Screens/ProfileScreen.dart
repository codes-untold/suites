import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suites/Screens/Hotelpage.dart';
import 'package:suites/Services/Listener.dart';
import 'package:suites/Widgets/InfoDialog.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  ImageProvider logo = AssetImage("images/backdrop2.jpg");
  String username;

  @override
  void initState() {

    getBoolToSF().then((value){
      setState(() {
        print(value);
        username =  Provider.of<Data>(context,listen: false).userInfo?.displayName?.isEmpty ?? value[1];


      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("images/backdrop2.jpg"), context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.topStart,
                children: [
                  Container(
                    child: Image(image: logo,),
                    margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height *0.07978),
                  ),
                  Positioned(
                    top: 165,
                    child:
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(width: 2,color: Colors.blue)
                      ),
                      child: CircleAvatar(
                          backgroundImage: AssetImage("images/placeholder.jpeg"),
                          radius:  MediaQuery.of(context).size.width * 0.1388,
                          backgroundColor: Colors.white
                      ),
                    ),),
                  Positioned(
                      top: 220,
                      left: MediaQuery.of(context).size.width *0.39,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(username!=null?username:"...",
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700
                            ),),
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text("Active",
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black54
                                ),),
                            ],
                          ),

                        ],
                      ))
                ],
              ),

              SizedBox(height: 35,),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoTile(name: "About",color1: Colors.blue[50],
                      color2: Colors.blue,data: Icons.info,function: (){
                        dialogFunction(context);

                      },),
                    SizedBox(height: 30,),

                    InfoTile(name: "Favourites",color1: Colors.orange[100],
                        color2: Colors.deepOrangeAccent,data: Icons.favorite),

                    SizedBox(height: 30,),

                    InfoTile(name: "Settings",color1: Colors.blue[50],
                        color2: Colors.blue,data: Icons.settings),

                    SizedBox(height: 50,),
                    SizedBox(height: 20,),

                    OutlinedButton(onPressed: (){},
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.exit_to_app_outlined,
                            color: Colors.deepOrangeAccent,),
                          SizedBox(width: 5,),
                          Text("Sign Out",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w300
                            ),
                          )
                        ],
                      ),

                      style: OutlinedButton.styleFrom(
                          side:  BorderSide(
                              color: Colors.grey,
                              style: BorderStyle.solid
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          )
                      ) ,  )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RowWidget extends StatelessWidget {

  String name;
  Color color1;
  Color color2;

  RowWidget({this.name,this.color1,this.color2});
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      CircleAvatar(
        backgroundColor: color1,
        radius: 20,
        child: Icon(Icons.person,color: color2,),
      ),
      SizedBox(width: 10,),
      Text(name),
    ],);
  }
}

class InfoTile extends StatelessWidget {


  String name;
  Color color1;
  Color color2;
  IconData data;
  Function function;

  InfoTile({this.name,this.color1,this.color2,this.data,this.function});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 8,
          child: Row(children: [
            CircleAvatar(
              backgroundColor: color1,
              radius: 20,
              child: Icon(data,color: color2,size: 15,),
            ),
            SizedBox(width: 10,),
            Text(name),
          ],),
        ),

        Expanded(
            flex: 2,
            child: Container(
                child: GestureDetector(
                    onTap: function,
                    child: RoundContainer())))
      ],
    );
  }
}

class RoundContainer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 20,
        height: 20,

        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.grey[300]
            ),
            borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        child: Icon(Icons.arrow_forward_ios,
          size: 8,)
    );


  }



}

dialogFunction(BuildContext context){
  showDialog(context: context, builder: (context){
    return Dialog(
      elevation: 16,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        child: InfoDialog(),

      ),
    );
  });
}