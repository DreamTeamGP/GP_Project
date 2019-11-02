import 'package:firebase_core/firebase_core.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:gp_project/Pages/profiledrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gp_project/measurementPopup.dart';
import 'package:gp_project/moodPopup.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var mood = ['mood'];
  var month = ['month'];
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // floatingActionButton: FloatingActionButton(child: Icon(Icons.person),onPressed: (){},),
        drawer: ProfileDrawer(),
        appBar: AppBar(
          title: Text('Home'),
          backgroundColor: Colors.cyan,
        ),
        body: Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: ListView(
            // scrollDirection: Axis.horizontal,
            children: <Widget>[
              RaisedButton(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.list,
                      size: 35,
                    ),
                    Text(
                      '  New Measurment',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    )
                  ],
                ),
                onPressed: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=> Measurement()));

                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: Text('Measurement'),
                            titleTextStyle: TextStyle(
                              backgroundColor: Colors.cyan,
                              fontSize: 25.0,
                            ),
                             content: MeasurementPopUp()
                            );
                      });
                },
                color: Colors.cyanAccent[200],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              RaisedButton(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.fastfood, size: 35),
                    Text(
                      '  Meal Intake',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    )
                  ],
                ),
                onPressed: () {},
                color: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              RaisedButton(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.tag_faces, size: 35),
                    Text(
                      '  Mood',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    )
                  ],
                ),
                onPressed: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=> DropdownButtonAletDialog()));
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: Text('Mood'),
                            titleTextStyle: TextStyle(
                              backgroundColor: Colors.cyan,
                              fontSize: 25.0,
                            ),
                            content: MoodPopUp()
                            );
                      });
                },
                color: Colors.yellow,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              RaisedButton(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.person, size: 35),
                    Text(
                      '  Profile',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    )
                  ],
                ),
                onPressed: () {},
                color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 0),
                  child: Text(
                    'Statistics Bar Chart',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  )),
              Row(
                children: <Widget>[
                  Expanded(
                      child: DropdownButton<String>(
                    items: mood.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    value: 'mood',
                    // onChanged: (){},
                  )),
                  Expanded(
                      child: DropdownButton<String>(
                    items: month.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    value: 'month',
                    // onChanged: (){},
                  )),
                ],
              ),
              //Column(children: <Widget>[chartdisplay],),
            ],
          ),
        ),
      ),
    );
  }
}
