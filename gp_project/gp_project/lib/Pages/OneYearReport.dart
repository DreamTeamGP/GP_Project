import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp_project/models/user.dart';

class oneYearReport extends StatefulWidget {
  final FirebaseUser currentUser;
  //final User user;
  final DocumentSnapshot patient;
  @override
  _oneYearReportState createState() => _oneYearReportState();
  oneYearReport({this.currentUser, this.patient});
}

class _oneYearReportState extends State<oneYearReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'One Year Report',
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
              "This Report include the measurements, meals and moods of this patient according to One year ago",
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
