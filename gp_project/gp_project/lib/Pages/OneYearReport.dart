import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp_project/models/user.dart';

class oneYearReport extends StatefulWidget {
  final FirebaseUser currentUser;
  final User user;
  @override
  _oneYearReportState createState() => _oneYearReportState();
    oneYearReport({this.currentUser, this.user});

}

class _oneYearReportState extends State<oneYearReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          'One Year Report',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Text("data"),
    );
  }
}