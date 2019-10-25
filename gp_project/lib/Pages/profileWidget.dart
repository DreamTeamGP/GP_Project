import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class profileWidget extends StatefulWidget {

  @override
  _profileWidgetState createState() => _profileWidgetState();
}

class _profileWidgetState extends State<profileWidget> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  User user;
  var email, name,phone, birthday, gender, country;
   Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }
  @override
  void initState() {
    super.initState();
    initUser();
    
  }
  initUser() async {
    firebaseUser = await _firebaseAuth.currentUser();
    var userID = firebaseUser.uid;
    DocumentSnapshot result = await Firestore.instance.collection('users').document(userID)
    .get().then((snapshot) {
      print(snapshot.data);
      print(snapshot.data['password']);
      test(snapshot.data);
    });
    print('helllo');
    setState(() {});
  }
  void test(x){
    print(x);
    email = x['email'];
    name = x['name'];
    phone = x['phone'];
    country = x['country'];
    gender = x['gender'];
    birthday = x['birthday'];

    //print(user.country);
    print(phone);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
          ),
          ),
        leading: Icon(Icons.menu, color: Colors.white,),
      ),
      body: Column(
        
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20.0),
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  color: Colors.red,
                  //image here
                  borderRadius: BorderRadius.all(Radius.circular(75.0)),
                ),
                
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(15.0),
                child: new Text(
                //"${firebaseUser?.email }",
                "${name}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  
                ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 15.0, top: 7.0),
            child: Row(
            children: <Widget>[
              Icon(Icons.location_on, color: Colors.grey, size: 32.0,),
              Container(
                margin: EdgeInsets.only(left: 15.0),
                child: Text('${country}',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                ),
            ],
          ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15.0, top: 7.0),
            child: Row(
            children: <Widget>[
              Icon(Icons.phone, color: Colors.grey, size: 32.0,),
              Container(
                margin: EdgeInsets.only(left: 15.0),
                child: Text('${phone}',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                ),
            ],
          ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15.0, top: 7.0),
            child: Row(
            children: <Widget>[
              Icon(Icons.mail, color: Colors.grey, size: 32.0,),
              Container(
                margin: EdgeInsets.only(left: 15.0),
                child: Text('${email}',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                ),
            ],
          ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15.0, top: 7.0),
            child: Row(
            children: <Widget>[
              Icon(Icons.calendar_today, color: Colors.grey, size: 32.0,),
              Container(
                margin: EdgeInsets.only(left: 15.0),
                child: Text('${birthday}',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                ),
            ],
          ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15.0, top: 7.0),
            child: Row(
            children: <Widget>[
              Icon(Icons.person, color: Colors.grey, size: 32.0,),
              Container(
                margin: EdgeInsets.only(left: 15.0),
                child: Text('${gender}',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                ),
            ],
          ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15.0, top: 7.0),
            child: Row(
            children: <Widget>[
              Icon(Icons.description, color: Colors.grey, size: 32.0,),
              Container(
                margin: EdgeInsets.only(left: 15.0),
                child: Text('Lorem ipsum dolor sit amet.',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                ),
                
            ],
          ),
          ),
        ],

      ),
      
      floatingActionButton: Container(
        width: 85.0,
        height: 85.0,
        child: FloatingActionButton(
          onPressed: (){},   
          child: Icon(Icons.edit, color: Colors.white, size: 50.0,),
        )
           
      ),
    );
  }
}