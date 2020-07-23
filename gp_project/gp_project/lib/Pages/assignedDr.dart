import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:gp_project/Pages/Listdoctors.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'homepage.dart';

class assignedDr extends StatefulWidget {
  final FirebaseUser currentuser;
  final DocumentSnapshot doctor;
  assignedDr({this.doctor, this.currentuser});
  @override
  _assignedDrState createState() => _assignedDrState();
}

class _assignedDrState extends State<assignedDr> {
  double rating = 0;
  var patientName;
  initUser() async {
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

  Future _data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initUser();
    _data = getTheRate();
  }

  Future getTheRate() async {
    QuerySnapshot result = await Firestore.instance
        .collection("users")
        .where("id", isEqualTo: widget.currentuser.uid)
        .getDocuments();
    return result.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.doctor.data["name"],
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyan,
        leading: new IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 30.0,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage(
                          user: widget.currentuser,
                        )));
          },
        ),
      ),
      body: ListView(
        children: <Widget>[
          widget.doctor.data["gender"] == "1"
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        //color: Colors.blue,
                        //image here
                        image: DecorationImage(
                          image: AssetImage('icons/Womandoctor.png'),
                          fit: BoxFit.fill,
                        ),
                        shape: BoxShape.circle,
                        //borderRadius: BorderRadius.all(Radius.circular(75.0)),
                      ),
                    )
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        //color: Colors.blue,
                        //image here
                        image: DecorationImage(
                          image: AssetImage('icons/Doctor.png'),
                          fit: BoxFit.fill,
                        ),
                        shape: BoxShape.circle,
                        //borderRadius: BorderRadius.all(Radius.circular(75.0)),
                      ),
                    )
                  ],
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(15.0),
                child: new Text(
                  widget.doctor.data["name"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                  ),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            child: FutureBuilder(
                future: _data,
                builder: (_, snapshot) {
                  // String x = snapshot.data.data['rating'];
                  // print(x);

                  if (snapshot.hasData) {
                    List<dynamic> myList = new List<dynamic>();
                    for (int i = 0; i < snapshot.data.length; i++) {
                      Map<String, dynamic>.from(snapshot.data[i].data)
                          .forEach((key, value) {
                        myList.add(value);
                      });
                    }
                    //rating = myList[1];

                    var drId = myList[13];

                    return StarRating(
                        size: 30.0,
                        rating: rating,
                        color: Colors.yellow[600],
                        borderColor: Colors.black,
                        starCount: 5,
                        onRatingChanged: (rating2) => setState(
                              () {
                                rating = rating2;
                                Firestore.instance
                                    .collection('rate')
                                    .document(widget.currentuser.uid)
                                    .setData({
                                  'drId': drId,
                                  'rating': rating,
                                });
                              },
                            ));
                  } else {
                    return Text('Loading...');
                  }
                }),
          ),
          widget.doctor.data["phone"] != ""
              ? Container(
                  margin: EdgeInsets.only(left: 15.0, top: 7.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.phone,
                        color: Colors.grey,
                        size: 32.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15.0),
                        child: Text(
                          widget.doctor.data["phone"],
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(left: 15.0, top: 7.0),
                ),
          widget.doctor.data["clinicno."] != ""
              ? Container(
                  margin: EdgeInsets.only(left: 15.0, top: 7.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.home,
                        color: Colors.grey,
                        size: 32.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15.0),
                        child: Text(
                          widget.doctor.data["clinicno."],
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(left: 15.0, top: 7.0),
                ),
          widget.doctor.data["email"] != ""
              ? Container(
                  margin: EdgeInsets.only(left: 15.0, top: 7.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.mail,
                        color: Colors.grey,
                        size: 32.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15.0),
                        child: Text(
                          widget.doctor.data["email"],
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(left: 15.0, top: 7.0),
                ),
          widget.doctor.data["university"] != ""
              ? Container(
                  margin: EdgeInsets.only(left: 15.0, top: 7.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.account_balance,
                        color: Colors.grey,
                        size: 32.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15.0),
                        child: Text(
                          widget.doctor.data["university"],
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(left: 15.0, top: 7.0),
                ),
          widget.doctor.data["address1"] != ""
              ? Container(
                  margin: EdgeInsets.only(left: 15.0, top: 7.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Colors.grey,
                        size: 32.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15.0),
                        child: Text(
                          widget.doctor.data["address1"],
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(left: 15.0, top: 7.0),
                ),
          widget.doctor.data["address2"] != ""
              ? Container(
                  margin: EdgeInsets.only(left: 15.0, top: 7.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.add_location,
                        color: Colors.grey,
                        size: 32.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15.0),
                        child: Text(
                          widget.doctor.data["address2"],
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(left: 15.0, top: 7.0),
                ),
        ],
      ),
    );
  }
}
