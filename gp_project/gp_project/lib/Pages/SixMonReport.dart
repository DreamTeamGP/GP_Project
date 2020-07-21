import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp_project/models/user.dart';

class sixMonthReport extends StatefulWidget {
  final FirebaseUser currentUser;
  final User user;
  @override
  _sixMonthReportState createState() => _sixMonthReportState();
    sixMonthReport({this.currentUser, this.user});

}

class _sixMonthReportState extends State<sixMonthReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          '6-Months Report',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Text("data"),
    );
  }
}