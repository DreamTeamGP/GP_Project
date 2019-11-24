import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp_project/Classes/User.dart';
import 'package:gp_project/Pages/profiledrawer.dart';
import 'package:gp_project/Pages/measurementPopup.dart';
import 'package:gp_project/Pages/moodPopup.dart';
import 'package:gp_project/models/user.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  var mood=['mood'];
  var month=['month'];
  UserClass userClass = new UserClass();
  User user = new User();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  User currentUser = new User();

  initUser() async {
    //firebaseUser = await _firebaseAuth.currentUser();
    //userID = firebaseUser.uid;
    currentUser = this.userClass.getCurrentUser();
    setState(() {
    });
  }
  @override
  void initState() {
    super.initState();
    initUser(); 
  }

 

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  debugShowCheckedModeBanner: false,
      home: Scaffold(
       // floatingActionButton: FloatingActionButton(child: Icon(Icons.person),onPressed: (){},),
          drawer: ProfileDrawer(currentUser: currentUser,),
        appBar: AppBar(title: Text('Home'), backgroundColor: Colors.cyan,),
        body: Container(
          margin: EdgeInsets.only(left: 10,right: 10),
          padding: EdgeInsets.only(top:20,bottom: 20),
          child: ListView(
            // scrollDirection: Axis.horizontal,
            children: <Widget>[
            RaisedButton(child:Row(children: <Widget>[Icon(Icons.list,size:35,),
            Text('  New Measurment',style: TextStyle(fontSize: 25,color: Colors.white),)],),
            onPressed:(){
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
           color: Colors.cyanAccent[200],shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
           ),
          RaisedButton(
            child:Row(
              children: <Widget>[Icon(Icons.fastfood,size: 35),
              Text('  Meal Intake',style:TextStyle(fontSize: 25,color: Colors.white),)],),
              onPressed:(){},
              color: Colors.red,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),),
              RaisedButton(child:Row(children: <Widget>[Icon(Icons.tag_faces,size:35),
              Text('  Mood',style:TextStyle(fontSize: 25,color: Colors.white),)],)
              ,onPressed:(){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        title: Text('Measurement'),
                        titleTextStyle: TextStyle(
                          backgroundColor: Colors.cyan,
                          fontSize: 25.0,
                        ),
                          content: MoodPopUp()
                        );
                  });},
                  color:Colors.yellow,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                ),
            RaisedButton(child:Row(children: <Widget>[Icon(Icons.person,size:35),
            Text('  Profile',style:TextStyle(fontSize: 25,color: Colors.white),)],)
            ,onPressed:(){},color:Colors.green,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),),             
         Padding(padding: EdgeInsets.only(top: 10,bottom:0),child: 
         Text('Statistics Bar Chart',style:TextStyle(fontWeight:FontWeight.bold,fontSize: 28),)),
          Row(children: <Widget>[
            Expanded(child: DropdownButton<String>(
              items: mood.map((String value){
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              value: 'mood',
             // onChanged: (){},
            )),
            Expanded(child: DropdownButton<String>(
              items: month.map((String value){
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              value: 'month',
             // onChanged: (){},
            )),
          ],),
          //Column(children: <Widget>[chartdisplay],),
          
          ],),
          
        ),
    ),
    
    );
     
  }
}
