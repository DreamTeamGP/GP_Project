import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gp_project/Pages/profiledrawer.dart';
import '../models/user.dart';
import '../Pages/profileEditWidget.dart';
import 'homepage.dart';
import 'DoctorEditProfile.dart';
import '../models/doctor.dart';
class DoctorProfile extends StatefulWidget {
  final FirebaseUser currentUser;
  final Doctor doctor;
  @override
  _DoctorProfileState createState() => _DoctorProfileState();
  DoctorProfile({this.currentUser, this.doctor});
}

class _DoctorProfileState extends State<DoctorProfile> {
  String gender;
  File _image;
  @override
  void initState() {
    //widget.user.gender == 1 ? gender = 'female' : gender = 'male';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //user = this.userClass.getCurrentUser();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
          ),
        ),
        backgroundColor: Colors.cyan,
        leading: new IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 30.0,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage(
                          user: widget.currentUser,
                        )));
          },
        ),
        // leading: Icon(
        //   Icons.menu,
        //   size: 30,
        //   color: Colors.white,
        // ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection("users")
            .document(widget.currentUser.uid)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // snapshot.data['gender'] == 1
                    //     ? Container(
                    //         margin: EdgeInsets.only(top: 20.0),
                    //         width: 100,
                    //         height: 100,
                    //         decoration: BoxDecoration(
                    //           //color: Colors.blue,
                    //           //image here
                    //           image: DecorationImage(
                    //             image: AssetImage('icons/Womanuser.png'),
                    //             fit: BoxFit.fill,
                    //           ),
                    //           shape: BoxShape.circle,
                    //           //borderRadius: BorderRadius.all(Radius.circular(75.0)),
                    //         ),
                    //       )
                    //     : Container(
                    //         margin: EdgeInsets.only(top: 20.0),
                    //         width: 100,
                    //         height: 100,
                    //         decoration: BoxDecoration(
                    //           //color: Colors.blue,
                    //           //image here
                    //           image: DecorationImage(
                    //             image: AssetImage('icons/user.jpg'),
                    //             fit: BoxFit.fill,
                    //           ),
                    //           shape: BoxShape.circle,
                    //           //borderRadius: BorderRadius.all(Radius.circular(75.0)),
                    //         ),
                    //       ),
                    snapshot.data['photo'] != null
                        ? CircleAvatar(
                            radius: 80.0,
                            backgroundImage: NetworkImage(
                              snapshot.data['photo'],
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.only(top: 20.0),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              //color: Colors.blue,
                              //image here
                              image: DecorationImage(
                                image: AssetImage('icons/Doctor.png'),
                                fit: BoxFit.fill,
                              ),
                              shape: BoxShape.circle,
                              //borderRadius: BorderRadius.all(Radius.circular(75.0)),
                            ),
                          ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(15.0),
                      child: new Text(
                        //"${firebaseUser?.email }",
                        '${snapshot.data['name']}',
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
                      Icon(
                        Icons.location_on,
                        color: Colors.grey,
                        size: 32.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15.0),
                        child: Text(
                          '${snapshot.data['clinicRegion']}',
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
                      Icon(
                        Icons.phone,
                        color: Colors.grey,
                        size: 32.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15.0),
                        child: Text(
                          '${snapshot.data['phone']}',
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
                      Icon(
                        Icons.mail,
                        color: Colors.grey,
                        size: 32.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15.0),
                        child: Text(
                          '${snapshot.data['email']}',
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
                      Icon(
                        Icons.location_on,
                        color: Colors.grey,
                        size: 32.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15.0),
                        child: Text(
                          '${snapshot.data['address1']}',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                snapshot.data['address2'] != ""
                    ? Container(
                        margin: EdgeInsets.only(left: 15.0, top: 7.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_city,
                              color: Colors.grey,
                              size: 32.0,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15.0),
                              child: Text(
                                '${snapshot.data['address2']}',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container()
              ],
            );
          }
          return LinearProgressIndicator();
        },
      ),
      floatingActionButton: Container(
          width: 85.0,
          height: 85.0,
          child: FloatingActionButton(
            backgroundColor: Colors.cyan,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DoctorEditProfile(
                            currentUser: widget.currentUser,
                          )));
            },
            child: Icon(
              Icons.edit,
              color: Colors.white,
              size: 50.0,
            ),
          )),
    );
  }
}
