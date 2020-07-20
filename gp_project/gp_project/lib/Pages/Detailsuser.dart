import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp_project/Pages/Listdoctors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gp_project/Pages/homepage.dart';

class detailsuser extends StatefulWidget {
  final FirebaseUser currentuser;
  final DocumentSnapshot patient;
  detailsuser({this.patient, this.currentuser});
  @override
  _detailsState createState() => _detailsState();
}

class _detailsState extends State<detailsuser> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.patient.data["name"],
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyan,
        leading: new IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
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
      body: Column(
        children: <Widget>[
          widget.patient.data["gender"] == 1
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
                          image: AssetImage('icons/Womanuser.png'),
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
                          image: AssetImage('icons/user.jpg'),
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
                  widget.patient.data["name"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                  ),
                ),
              ),
            ],
          ),
          widget.patient.data["phone"] != ""
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
                          widget.patient.data["phone"],
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
          widget.patient.data["city"] != ""
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
                          widget.patient.data["city"],
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
          widget.patient.data["email"] != null
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
                          widget.patient.data["email"],
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
          widget.patient.data["weight"] != ""
              ? Container(
                  margin: EdgeInsets.only(left: 15.0, top: 7.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.line_weight,
                        color: Colors.grey,
                        size: 32.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15.0),
                        child: Text(
                          widget.patient.data["weight"],
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15.0),
                        child: Text(
                          "Kg",
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
          widget.patient.data["height"] != ""
              ? Container(
                  margin: EdgeInsets.only(left: 15.0, top: 7.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.assessment,
                        color: Colors.grey,
                        size: 32.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15.0),
                        child: Text(
                          widget.patient.data["height"],
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15.0),
                        child: Text(
                          "cm",
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
          widget.patient.data["birthday"] != ""
              ? Container(
                  margin: EdgeInsets.only(left: 15.0, top: 7.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.calendar_today,
                        color: Colors.grey,
                        size: 32.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15.0),
                        child: Text(
                          widget.patient.data["birthday"],
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
          widget.patient.data["diabetesType"] == 0
              ? Container(
                  margin: EdgeInsets.only(left: 15.0, top: 7.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.merge_type,
                        color: Colors.grey,
                        size: 32.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15.0),
                        child: Text(
                          "Type 1",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : widget.patient.data["diabetesType"] == 1
                  ? Container(
                      margin: EdgeInsets.only(left: 15.0, top: 7.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.merge_type,
                            color: Colors.grey,
                            size: 32.0,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 15.0),
                            child: Text(
                              "Type 2",
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
          widget.patient.data["treatType"] == 0
              ? Container(
                  margin: EdgeInsets.only(left: 15.0, top: 7.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.accessibility,
                        color: Colors.grey,
                        size: 32.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15.0),
                        child: Text(
                          "Pills",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : widget.patient.data["treatType"] == 1
                  ? Container(
                      margin: EdgeInsets.only(left: 15.0, top: 7.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.accessibility,
                            color: Colors.grey,
                            size: 32.0,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 15.0),
                            child: Text(
                              "Insluin Injection",
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
