import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gp_project/Auth/line.dart';
import 'patientDetails.dart';
import '../models/doctor.dart';
import 'homepage.dart';

class doctorNotification extends StatefulWidget {
  final FirebaseUser currentUser;

  const doctorNotification({Key key, this.currentUser}) : super(key: key);

  @override
  _doctorNotificationState createState() => _doctorNotificationState();
}

class _doctorNotificationState extends State<doctorNotification> {
  Doctor doctor = new Doctor();
  ScrollController _scrollController = new ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future _data;

  Future getNotifications() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection("addDoctorRequest")
        .where('doctorID', isEqualTo: widget.currentUser.uid,)
<<<<<<< Updated upstream
        .where('approved', isEqualTo: "0",)
=======
        .where('approved', isEqualTo: 0,)
>>>>>>> Stashed changes
        .getDocuments();
    return qn.documents;
  }

  navigateToDetail(String patientID, var documentID) {

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => patientDetails(patientID: patientID, currentuser:widget.currentUser, documentID: documentID)),
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
            fontSize: 25.0,
          ),
        ),
        backgroundColor: Colors.cyan,
        leading: new IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 30.0,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage(user: widget.currentUser,)));
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
                            child: Icon(Icons.notifications, color: Colors.blueAccent,),
                          ),
                          Container(
                            width: 20,
                          ),
                          Flexible(
                            child: GestureDetector(
                              onTap: () =>
                                  navigateToDetail(snapshot.data[index].data['patientID'], snapshot.data[index].documentID),
                              child: Container(
                                margin: EdgeInsets.only(top: 15),
                                child: Text(
                                  '${snapshot.data[index].data["patientName"]}',
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