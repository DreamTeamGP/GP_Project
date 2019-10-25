import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gp_project/Auth/line.dart';
import '../models/doctor.dart';

class listdoc extends StatefulWidget {
  @override
  _listdocState createState() => _listdocState();
}

class _listdocState extends State<listdoc> {
  Doctor doctor = new Doctor();
  ScrollController _scrollController = new ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future getDoctors() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection("users")
        .where('role', isEqualTo: "doctor")
        .getDocuments();
    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Doctors',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
          ),
        ),
        backgroundColor: Colors.cyan,
        leading: Icon(Icons.arrow_back_ios, size: 30.0, color: Colors.white),
      ),
      body: FutureBuilder(
        future: getDoctors(),
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
                          top: 0.0, bottom: 10.0, right: 100.0, left: 15.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 20.0),
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              //image here
                              image: snapshot.data[index].data["photo"],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(75.0)),
                            ),
                          ),
                          Container(
                            width: 20,
                          ),
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.only(top: 15),
                              child: Text(
                                snapshot.data[index].data["name"],
                                style: TextStyle(
                                  fontSize: 21,
                                  color: Colors.black,
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
