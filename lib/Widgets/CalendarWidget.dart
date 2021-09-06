import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../Services.dart';

class CalendarWidget extends StatefulWidget {

  Function function;
  Function result;

  CalendarWidget({this.function,this.result});
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {

  String user;
  DateTime focusedDay = DateTime.now();
  DateTime RangeOne = DateTime.now();
  DateTime RangeTwo = DateTime.now();
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height:  MediaQuery.of(context).size.height * 0.12,
              color: Colors.blue[800],
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("SELECT DATE",
                      style: TextStyle(
                          color: Colors.white,
                        fontSize: 12.0
                      ),),
                    Row(children: [
                      Text(RangeOne != null ? "${Services().getMonth(RangeOne.month)} ${RangeOne.day}": "${Services().getMonth(DateTime.now().month)} ${DateTime.now().day}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0
                          )),
                      SizedBox(
                        width: 5,
                      ),
                      Text("-",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0
                          )),
                      SizedBox(
                        width: 5,
                      ),

                      Text( RangeTwo != null  ? "${Services().getMonth(RangeTwo.month)} ${RangeTwo.day}":"${Services().getMonth(DateTime.now().month)} ${DateTime.now().day}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0
                          ))
                    ],),
                  ],
                ),
              ),
            ),
            TableCalendar(
              firstDay: DateTime.utc(2010,10,16),
              lastDay: DateTime.utc(2030,10,16),
              focusedDay: focusedDay,
              selectedDayPredicate: (day){
                return isSameDay(focusedDay, day);
              },

              onDaySelected: (selectedday,focusedday){
                setState(() {
                  if(i == 0){
                    focusedDay = focusedday;
                    RangeOne = selectedday;
                    i++;
                  }
                  else{
                    focusedDay = focusedday;
                    RangeTwo = selectedday;
                    i = 0;
                  }

                });
              },
              calendarFormat: CalendarFormat.month,
              onRangeSelected: (a,b,c){
                print(a);
                // print(b);
                print(c);          },
              rangeStartDay: RangeOne,
              rangeEndDay: RangeTwo ,
            ),
            SizedBox(
              height: 30,
            ) ,
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Text("CANCEL",
                      style: TextStyle(
                        color: Colors.blue
                      ),),
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    GestureDetector(
                      onTap: (){

                        if(RangeOne == DateTime.now() && RangeTwo ==DateTime.now()){
                          Navigator.pop(context);
                        }

                        if(RangeOne.month > RangeTwo.month ){
                          widget.function("Duration should not exceed thirty days");
                        }

                        if(RangeOne.month == RangeTwo.month ){
                          if(RangeTwo.day > RangeOne.day){
                                widget.result(RangeTwo,RangeOne);
                                Navigator.pop(context);
                          }
                          else{
                            if(RangeOne.day == RangeTwo.day){
                              widget.function("Select more than one date");
                            }else
                            widget.function("Check out Date must come before Check in Date");
                          }

                        }

                        if(RangeOne.month < RangeTwo.month ){
                          if((RangeTwo.day + 30) - RangeOne.day > 30){
                            widget.function("Duration should not exceed thirty days");
                          }
                          else{
                            widget.result(RangeTwo,RangeOne);
                            Navigator.pop(context);
                          }
                        } if( RangeTwo.month - RangeOne.month > 1 ){
                       widget.function("Duration should not exceed thirty days");}


                      },
                      child: Text("OK",style: TextStyle(
                          color: Colors.blue
                      ),),
                    )
                  ],
                ),
              ),
            )],
        ),
      ),
    );
  }

}

