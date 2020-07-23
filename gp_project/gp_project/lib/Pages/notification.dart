import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gp_project/Auth/line.dart';
import 'Detailsdoctor.dart';
import '../models/doctor.dart';
import 'homepage.dart';

class notification extends StatefulWidget {
  final FirebaseUser currentUser;

  const notification({Key key, this.currentUser}) : super(key: key);

  @override
  _notificationState createState() => _notificationState();
}

class _notificationState extends State<notification> {
  Doctor doctor = new Doctor();
  ScrollController _scrollController = new ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future _data;

  Future getNotifications() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection("patientAlert")
        .where('patientID', isEqualTo: widget.currentUser.uid)
        .getDocuments();
    return qn.documents;
  }

  navigateToDetail(DocumentSnapshot doctor) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              details(doctor: doctor, currentuser: widget.currentUser)),
    );
  }

  @override
  void initState() {
    super.initState();
    _data = getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notification',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28.0,
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
      ),
      body: FutureBuilder(
        future: _data,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text("Loading ..."),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          top: 0.0, bottom: 10.0, right: 10.0, left: 10.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 20.0),
                            width: 30.0,
                            height: 30.0,
                            child: Icon(
                              Icons.notifications,
                              color: Colors.cyan,
                            ),
                          ),
                          Container(
                            width: 20,
                          ),
                          Flexible(
                            child: GestureDetector(
                              onTap: () =>
                                  navigateToDetail(snapshot.data[index]),
                              child: Container(
                                margin: EdgeInsets.only(top: 15),
                                child: Text(
                                  '${snapshot.data[index].data["state"]}',
                                  //'snapshot.data[index].data["name"]',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(),
                      child: Column(
                        children: <Widget>[
                          CustomPaint(painter: Drawhorizontalline4(false)),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
