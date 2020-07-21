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
        title:  Text(
          '3-Months Report',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Text("data"),
    );
  }
}