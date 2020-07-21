import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp_project/models/user.dart';

class sixMonthReport extends StatefulWidget {
  final FirebaseUser currentUser;
  //final User user;
  final DocumentSnapshot patient;
  @override
  _sixMonthReportState createState() => _sixMonthReportState();
  sixMonthReport({this.currentUser, this.patient});
}

class _sixMonthReportState extends State<sixMonthReport> {
  Future _mood, _meal, _measure;
  Future getMoods() async {
    final currenttime = DateTime.now();
    final _start = DateTime(currenttime.year);
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection("moods")
        .where('Timestamp',
            isGreaterThanOrEqualTo:
                DateTime.now().subtract(new Duration(days: 180)))
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
                DateTime.now().subtract(new Duration(days: 180)))
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
            isGreaterThanOrEqualTo: date.subtract(new Duration(days: 180)))
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
    String processedDate = inputVal.year.toString() +
        '-' +
        inputVal.month.toString() +
        '-' +
        inputVal.day.toString();
    return processedDate;
  }

//Future datee = getMoods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '6-Months Report',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
              child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 11.0, right: 10.0),
              child: Text(
                "This Report include the measurements, meals and moods of this patient according to 6-Months ago",
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
                          // .where('Date',
                          //     isGreaterThanOrEqualTo: DateTime.now()
                          //         .subtract(new Duration(days: 180)))
                          .where('UserId', isEqualTo: widget.patient.data["id"])
                          .orderBy('Date', descending: true)
                          .snapshots(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                            '${document['Date']}    ${document['measurement']}',
                                            style: TextStyle(
                                              fontSize: 19,
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
                          .collection("moods")
                          .where('Timestamp',
                              isGreaterThanOrEqualTo: DateTime.now()
                                  .subtract(new Duration(days: 180)))
                          .where('UserId', isEqualTo: widget.patient.data["id"])
                          .orderBy('Timestamp', descending: true)
                          .snapshots(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                              fontSize: 19,
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
                                  .subtract(new Duration(days: 180)))
                          .where('UserID', isEqualTo: widget.patient.data["id"])
                          .orderBy('Timestamp', descending: true)
                          .snapshots(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                              fontSize: 19,
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
