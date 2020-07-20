import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp_project/models/user.dart';

class ThreeMonthReport extends StatefulWidget {
  final FirebaseUser currentUser;
  final User user;
  @override
  _ThreeMonthReportState createState() => _ThreeMonthReportState();
  ThreeMonthReport({this.currentUser, this.user});
}

class _ThreeMonthReportState extends State<ThreeMonthReport> {
  @override
  Widget build(BuildContext context) {
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
