import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp_project/Auth/login.dart';
import 'package:gp_project/Pages/Calendar.dart';
import 'package:gp_project/Pages/Listdoctors.dart';
import 'package:gp_project/Pages/contactUs.dart';
import 'package:gp_project/Pages/homepage.dart';
import 'package:gp_project/Pages/doctorNotification.dart';
import 'package:gp_project/Pages/notification.dart';
import 'package:gp_project/Pages/profileWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gp_project/Pages/Maps.dart';

import 'Detailsdoctor.dart';
import 'Search.dart';

class ProfileDrawer extends StatefulWidget {
  final FirebaseUser currentUser;
  const ProfileDrawer({Key key, this.currentUser}) : super(key: key);
  @override
  _ProfileDrawerState createState() => _ProfileDrawerState();
}

class _ProfileDrawerState extends State<ProfileDrawer> {
  File _image;
  static Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    FirebaseAuth.instance.signOut();
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  var resultedDoctor;
  var patientDocID;
  getDoctorData() async {
    firebaseUser = await _firebaseAuth.currentUser();
    var userID = firebaseUser.uid;
    DocumentSnapshot resultUser = await Firestore.instance
        .collection('users')
        .document(userID)
        .get()
        .then((snapshot) {
      patientDocID = snapshot['doctorId'];
      print('patientDocID ' + patientDocID);
    });

    DocumentSnapshot resultDoctor = await Firestore.instance
        .collection('users')
        .document(patientDocID)
        .get()
        .then((snapshot) {
      print('doctor dataaa ' + snapshot.data['name']);
      resultedDoctor = snapshot;
    });
    //return resultDoctor;
  }

  @override
  void initState() {
    getDoctorData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //FirebaseUser user;
    return Drawer(
      child: StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection("users")
            .document(widget.currentUser.uid)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return checkRole(snapshot.data);
          }
          return LinearProgressIndicator();
        },
      ),
    );
  }

  Drawer checkRole(DocumentSnapshot snapshot) {
    if (snapshot.data == null) {
      return Drawer(
        child: Text('no data set in the userId document in firestore'),
      );
    }
    if (snapshot.data['role'] == 'doctor') {
      return docPage(snapshot);
    } else {
      return userPage(snapshot);
    }
  }

  Drawer docPage(DocumentSnapshot snapshot) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Column(
                  children: <Widget>[
                    // snapshot.data['gender'] == 1
                    //     ? Container(
                    //         width: 100,
                    //         height: 100,
                    //         decoration: BoxDecoration(
                    //           //color: Colors.blue,
                    //           //image here
                    //           image: DecorationImage(
                    //             image: AssetImage('icons/Womandoctor.png'),
                    //             fit: BoxFit.fill,
                    //           ),
                    //           shape: BoxShape.circle,
                    //           //borderRadius: BorderRadius.all(Radius.circular(75.0)),
                    //         ),
                    //       )
                    //     : Container(
                    //         width: 100,
                    //         height: 100,
                    //         decoration: BoxDecoration(
                    //           //color: Colors.blue,
                    //           //image here
                    //           image: DecorationImage(
                    //             image: AssetImage('icons/Doctor.png'),
                    //             fit: BoxFit.fill,
                    //           ),
                    //           shape: BoxShape.circle,
                    //           //borderRadius: BorderRadius.all(Radius.circular(75.0)),
                    //         ),
                    //       ),
                    _image != null
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
                                image: AssetImage('icons/user.jpg'),
                                fit: BoxFit.fill,
                              ),
                              shape: BoxShape.circle,
                              //borderRadius: BorderRadius.all(Radius.circular(75.0)),
                            ),
                          ),
                    Text('${snapshot.data['name']}',
                        style: TextStyle(fontSize: 22, color: Colors.white)),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                size: 25,
              ),
              title: Text(
                'Home',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage(
                              user: widget.currentUser,
                            )));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                size: 25,
              ),
              title: Text(
                'Profile',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => profileWidget(
                              currentUser: widget.currentUser,
                            )));
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text(
                'Notification',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => doctorNotification(
                              currentUser: widget.currentUser,
                            )));
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text(
                'Help',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                'Settings',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text(
                'Contact Us',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => contactUs(
                              user: widget.currentUser,
                            )));
              },
            ),
            ListTile(
              leading: Icon(Icons.accessibility_new),
              title: Text(
                'Log Out',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                signOut();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => login()));
              },
            ),
          ],
        ),
      ),
    );
    /*Center(
        child: Text('${snapshot.data['role']} ${snapshot.data['name']}'));*/
  }

  Drawer userPage(DocumentSnapshot snapshot) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Column(
                  children: <Widget>[
                    //   snapshot.data['gender'] == 1
                    //  ? Container(
                    //     width: 100,
                    //     height: 100,
                    //     decoration: BoxDecoration(
                    //       //color: Colors.blue,
                    //       //image here
                    //       image: DecorationImage(
                    //         image: AssetImage('icons/Womanuser.png'),
                    //         fit: BoxFit.fill,
                    //       ),
                    //       shape: BoxShape.circle,
                    //       //borderRadius: BorderRadius.all(Radius.circular(75.0)),
                    //     ),
                    //   )
                    //   : Container(
                    //     width: 100,
                    //     height: 100,
                    //     decoration: BoxDecoration(
                    //       //color: Colors.blue,
                    //       //image here
                    //       image: DecorationImage(
                    //         image: AssetImage('icons/user.jpg'),
                    //         fit: BoxFit.fill,
                    //       ),
                    //       shape: BoxShape.circle,
                    //       //borderRadius: BorderRadius.all(Radius.circular(75.0)),
                    //     ),
                    //   ),
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
                                image: AssetImage('icons/user.jpg'),
                                fit: BoxFit.fill,
                              ),
                              shape: BoxShape.circle,
                              //borderRadius: BorderRadius.all(Radius.circular(75.0)),
                            ),
                          ),
                    Text('${snapshot.data['name']}',
                        style: TextStyle(fontSize: 22, color: Colors.white)),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                size: 25,
              ),
              title: Text(
                'Home',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage(
                              user: widget.currentUser,
                            )));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                size: 25,
              ),
              title: Text(
                'Profile',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => profileWidget(
                              currentUser: widget.currentUser,
                            )));
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text(
                'Notification',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => notification(
                              currentUser: widget.currentUser,
                            )));
              },
            ),
            ListTile(
              leading: Icon(Icons.border_color),
              title: Text(
                'My Report',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.perm_identity),
              title: Text(
                'My Doctor',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                if (patientDocID == "") {
                  print('no doctooooor');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => listdoc(
                                currentUser: widget.currentUser,
                              )));
                } else {
                  print('yes doctooooor');

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => details(
                              doctor: resultedDoctor,
                              currentuser: widget.currentUser)));
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text(
                'Find Doctor',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => searchByName(
                              currentUser: widget.currentUser,
                            )));
              },
            ),
            ListTile(
              leading: Icon(Icons.map),
              title: Text(
                'My Maps',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Map(user: widget.currentUser)));
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text(
                'My calender',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => calenderPage(
                              user: widget.currentUser,
                            )));
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text(
                'Help',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                'Settings',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text(
                'Contact Us',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => contactUs(
                              user: widget.currentUser,
                            )));
              },
            ),
            ListTile(
              leading: Icon(Icons.accessibility_new),
              title: Text(
                'Log Out',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                signOut();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => login()));
              },
            ),
          ],
        ),
      ),
    ); /*(child: Text(snapshot.data['name']));*/
  }
}
