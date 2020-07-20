import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp_project/models/user.dart';

class ThreeMonthReport extends StatefulWidget {
  final FirebaseUser currentUser;
  final DocumentSnapshot patient;
  //final User user;
  @override
  _ThreeMonthReportState createState() => _ThreeMonthReportState();
  ThreeMonthReport({this.patient, this.currentUser});
}

class _ThreeMonthReportState extends State<ThreeMonthReport> {
  Future _mood, _meal, _measure;
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
    print("Moods");
    print(qn.documents);
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
    print("Meals");
    print(qn.documents);
    return qn.documents;
  }

  Future getMeasures() async {
    final currenttime = DateTime.now();
    final _start = DateTime(currenttime.year);
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection("patientsMeasurements")
        .where('Date',
            isGreaterThanOrEqualTo:
                DateTime.now().subtract(new Duration(days: 90)))
        .orderBy('Date', descending: true)
        .getDocuments();
    print("Measures");
    print(qn.documents);
    return qn.documents;
  }

  @override
  void initState() {
    super.initState();
    _mood = getMoods();
    _meal = getMeals();
    _measure = getMeasures();
  }

//Future datee = getMoods();
  @override
  Widget build(BuildContext context) {
    var data = getMoods();
    var meals = getMeals();
    var meas = getMeasures();
    print(data);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '3-Months Report',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 11.0, right: 10.0),
            child: Text(
              "This Report include the measurements, meals and moods of this patient according to 3-Months ago",
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
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              "Moods",
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
        ],
      ),
    );
  }
}
