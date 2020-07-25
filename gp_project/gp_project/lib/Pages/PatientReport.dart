import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp_project/models/user.dart';
import 'package:intl/intl.dart';
import 'homepage.dart';
class PatientReport extends StatefulWidget {
  final FirebaseUser currentUser;
  //final DocumentSnapshot patient;
  //final User user;
  @override
  _PatientReportState createState() => _PatientReportState();
  PatientReport({this.currentUser});
}

class _PatientReportState extends State<PatientReport> {
  Future _mood, _meal, _measure;
  var now = DateTime.now();
  Future getMoods() async {
    final currenttime = DateTime.now();
    final _start = DateTime(currenttime.year);
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection("moods")
        .where('Timestamp',
            isGreaterThanOrEqualTo:
                DateTime.now().subtract(new Duration(days: 90)))
        .orderBy('Timestamp', descending: true)
        .getDocuments();
    return qn.documents;
  }

  Future getMeals() async {
    final currenttime = DateTime.now();
    final _start = DateTime(currenttime.year);
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection("meals")
        .where('Date',
            isGreaterThanOrEqualTo:
                DateTime.now().subtract(new Duration(days: 90)))
        .orderBy('Date', descending: true)
        .getDocuments();
    return qn.documents;
  }

  Future getMeasures() async {
    final currenttime = DateTime.now();
    DateTime now = new DateTime.now();
    DateTime date =
        new DateTime(now.year, now.month, now.day, now.hour, now.minute);
    final _start = DateTime(currenttime.year);
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection("patientsMeasurements")
        .where('Date',
            isGreaterThanOrEqualTo: date.subtract(new Duration(days: 90)))
        .orderBy('Date', descending: true)
        .getDocuments();
    return qn.documents;
  }

  initUser() async {
    var patientName;
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser;
    firebaseUser = await firebaseAuth.currentUser();
    var userID = firebaseUser.uid;
    DocumentSnapshot result = await Firestore.instance
        .collection('users')
        .document(userID)
        .get()
        .then((snapshot) {
      patientName = snapshot.data['name'];
      print(snapshot.data['name']);
    });
  }

  @override
  void initState() {
    super.initState();
    initUser();
    _mood = getMoods();
    _meal = getMeals();
    _measure = getMeasures();
  }

  getDateForTimetamp(DateTime inputVal) {
    String processedDate = DateFormat("yyyy-MM-dd").format(inputVal);
    return processedDate;
  }

//Future datee = getMoods();
  @override
  Widget build(BuildContext context) {
    var date1 = DateTime.parse("1995-07-20");
    var newDate = date1.subtract(new Duration(days: 90));
    print(newDate);
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    print(formattedDate);
    DateTime parsing = DateTime.parse(formattedDate);
    print(parsing);
    var parr = parsing.subtract(new Duration(days: 90));
    print(parr);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '3-Months Report',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
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
        ),      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(top: 15.0, left: 11.0, right: 10.0),
              child: Text(
                "This Report include the measurements, meals and moods that you recorded in the last 3-Months ",
                textAlign: TextAlign.justify,
                softWrap: true,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                "Measuerments",
                textAlign: TextAlign.left,
                softWrap: true,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance
                          .collection("patientsMeasurements")
                          // .where("Date",
                          //     isGreaterThanOrEqualTo:parr)
                          .where('UserId', isEqualTo: widget.currentUser.uid)
                          .orderBy('Date', descending: true)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError)
                          return new Text('Error: ${snapshot.error}');
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return new Text('Loading...');
                          default:
                            return Container(
                              child: ListView(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                children: snapshot.data.documents.map(
                                  (DocumentSnapshot document) {
                                    return Column(
                                      children: <Widget>[
                                        new ListTile(
                                          title: new Text(
                                            '${document['Date']}  ${document['measurement']}',
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                ).toList(),
                              ),
                            );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                "Moods",
                textAlign: TextAlign.left,
                softWrap: true,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance
                          .collection("moods")
                          .where('Timestamp',
                              isGreaterThanOrEqualTo: DateTime.now()
                                  .subtract(new Duration(days: 90)))
                          .where('UserId', isEqualTo: widget.currentUser.uid)
                          .orderBy('Timestamp', descending: true)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError)
                          return new Text('Error: ${snapshot.error}');
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return new Text('Loading...');
                          default:
                            return Container(
                              child: ListView(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                children: snapshot.data.documents.map(
                                  (DocumentSnapshot document) {
                                    return Column(
                                      children: <Widget>[
                                        new ListTile(
                                          title: new Text(
                                            '${document['Date']}    ${document['mood']}',
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                ).toList(),
                              ),
                            );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                "Meals",
                textAlign: TextAlign.left,
                softWrap: true,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance
                          .collection("meals")
                          .where('Timestamp',
                              isGreaterThanOrEqualTo: DateTime.now()
                                  .subtract(new Duration(days: 90)))
                          .where('UserID', isEqualTo: widget.currentUser.uid)
                          .orderBy('Timestamp', descending: true)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError)
                          return new Text('Error: ${snapshot.error}');
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return new Text('Loading...');
                          default:
                            return Container(
                              child: ListView(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                children: snapshot.data.documents.map(
                                  (DocumentSnapshot document) {
                                    return Column(
                                      children: <Widget>[
                                        new ListTile(
                                          title: new Text(
                                            '${document['Date']}  ${document['food']}',
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                ).toList(),
                              ),
                            );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
