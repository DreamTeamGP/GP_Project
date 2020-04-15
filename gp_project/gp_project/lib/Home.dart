import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Classes/notificationClass.dart';

class Home extends StatefulWidget{


  @override
 _HomeState createState() =>_HomeState();

}

class _HomeState extends State<Home>{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
    );
  }
  // ${widget.user.email}

} 