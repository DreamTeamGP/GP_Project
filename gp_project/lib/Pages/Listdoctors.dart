import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gp_project/Auth/line.dart';
import 'Detailsdoctor.dart';
import '../models/doctor.dart';

class listdoc extends StatefulWidget {
  @override
  _listdocState createState() => _listdocState();
}

class _listdocState extends State<listdoc> {
  Doctor doctor = new Doctor();
  ScrollController _scrollController = new ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future _data;

  Future getDoctors() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection("users")
        .where('role', isEqualTo: "doctor")
        .getDocuments();
    return qn.documents;
  }

  navigateToDetail(DocumentSnapshot doctor) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => details(doctor: doctor)),
    );
  }

  @override
  void initState() {
    super.initState();
    _data = getDoctors();
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
                            child: GestureDetector(
                              onTap: () =>
                                  navigateToDetail(snapshot.data[index]),
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