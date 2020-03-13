import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gp_project/Pages/profiledrawer.dart';

class Map extends StatefulWidget {
  final FirebaseUser user;

  const Map({Key key, this.user}) : super(key: key);
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  GoogleMapController mapController;
  final LatLng _center = const LatLng(45.521563, -122.677433);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
      drawer: ProfileDrawer(currentUser: widget.user),
      appBar: AppBar( title: Text('My Maps ', 
      style: TextStyle(fontSize:28),),
      backgroundColor: Colors.cyan,
      ),
    body: 
    Column(children: <Widget>[
    Container(
      width:double.infinity,
      height: 300,
      child:GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 11.0,
      )
      )
    ),

    Container(
      width: double.infinity,
    alignment: Alignment.bottomLeft,

    height: 70,
    padding: EdgeInsets.all(10),
      child:FlatButton(
            textColor: Colors.black,
            
            padding: EdgeInsets.all(5.0),
            splashColor: Colors.cyan,
            onPressed: () {},
      child: Text(
        "Locate Closest Bathroom",
        style: TextStyle(fontSize: 20.0),textAlign: TextAlign.left,),

    )

    ),

    Container(width: double.infinity,
    alignment: Alignment.bottomLeft,
    height: 70,
    padding: EdgeInsets.all(10),
      child:FlatButton(
            textColor: Colors.black,
            padding: EdgeInsets.all(10),
            splashColor: Colors.cyan,
            onPressed: () {},
      child: Text(
        "Locate Closest SuperMarket ",
        style: TextStyle(fontSize: 20.0),textAlign: TextAlign.left,),
    )

    ),
    Container(width: double.infinity,
    alignment: Alignment.bottomLeft,
    height: 70,
    padding: EdgeInsets.all(10),
      child:FlatButton(
            textColor: Colors.black,
            padding: EdgeInsets.all(5.0),
            splashColor: Colors.cyan,
            onPressed: () {},
      child: Text(
        "Locate Closest Pharmacy",
        style: TextStyle(fontSize: 20.0),textAlign: TextAlign.left),
    )

    ),
    Container(
    
      width: double.infinity,
      alignment: Alignment.bottomLeft,
    height: 70,
    padding: EdgeInsets.all(10),

      child:FlatButton(
            textColor: Colors.black,
            padding: EdgeInsets.all(5.0),
            splashColor: Colors.cyan,
            onPressed: () {},
      child: Text(
        "Locate Closest Hospital",
        style: TextStyle(fontSize: 20.0),textAlign: TextAlign.left,
    ),
    )
    )
    ],),
    )
    );
    }
}