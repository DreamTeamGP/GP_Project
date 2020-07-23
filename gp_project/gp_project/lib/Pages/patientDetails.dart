import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp_project/Pages/Listdoctors.dart';
import 'package:gp_project/Pages/doctorNotification.dart';
import 'package:firebase_auth/firebase_auth.dart';

class patientDetails extends StatefulWidget {
  final FirebaseUser currentuser;
  //final DocumentSnapshot doctor;
  final String patientID;
  final documentID;
  patientDetails({this.patientID, this.currentuser, this.documentID});
  @override
  _patientDetailsState createState() => _patientDetailsState();
}

class _patientDetailsState extends State<patientDetails> {
  var patientName;
  initUser() async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser;
    firebaseUser = await firebaseAuth.currentUser();
    var userID = firebaseUser.uid;
    DocumentSnapshot result = await Firestore.instance
        .collection('users')
        .document(widget.patientID)
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
    //user = this.userClass.getCurrentUser();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Patient details',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
/*         leading: Icon(
          Icons.menu,
          color: Colors.white,
        ), */
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection("users")
            .document(widget.patientID)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    snapshot.data['gender'] == 1
                        ? Container(
                            margin: EdgeInsets.only(top: 20.0),
                            width: 100,
                            height: 100,
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
                        : Container(
                            margin: EdgeInsets.only(top: 20.0),
                            width: 100,
                            height: 100,
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
                          ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(15.0),
                      child: new Text(
                        //"${firebaseUser?.email }",
                        '${snapshot.data['name']}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25.0,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  // margin: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      
                      Container(
                        margin: EdgeInsets.all(10),
                        child: ButtonTheme(
                        minWidth: 120,
                        child: RaisedButton(
                          padding: EdgeInsets.only(
                              top: 5, bottom: 5, right: 20, left: 20),
                          onPressed: (){
                            Firestore.instance.collection("addDoctorRequest")
                            .document(widget.documentID).updateData({"approved": 1});
                            // connectDoctor();
                            Firestore.instance.collection('users').document(widget.patientID)
                            .updateData({"doctorId": widget.currentuser.uid});
                            print(widget.currentuser);
                            SnackBar(content: Text('Request has been accepted'));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => doctorNotification(
                                          currentUser: widget.currentuser,
                                        )));
                          },
                          child: Text(
                            'Accept',
                            style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal),
                          ),
                          color: Colors.green,
                          textColor: Colors.white,
                        ),
                    ),
                      ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: ButtonTheme(
                        minWidth: 120,
                        child: RaisedButton(
                          padding: EdgeInsets.only(
                              top: 5, bottom: 5, right: 20, left: 20),
                          onPressed: (){
                            Firestore.instance.collection("addDoctorRequest")
                            .document(widget.documentID).delete();
                            SnackBar(content: Text('Request has been deleted'));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => doctorNotification(
                                          currentUser: widget.currentuser,
                                        )));
                          },
                          child: Text(
                            'Reject',
                            style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal),
                          ),
                          color: Colors.red,
                          textColor: Colors.white,
                        ),
                      ),
                    ),
                    ],
                  ),
                ),
                Container(
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
                          '${snapshot.data['country']}',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                          '${snapshot.data['phone']}',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                          '${snapshot.data['email']}',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                          '${snapshot.data['birthday']}',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15.0, top: 7.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        color: Colors.grey,
                        size: 32.0,
                      ),
                      snapshot.data['gender'] == '1'
                          ? Container(
                              margin: EdgeInsets.only(left: 15.0),
                              child: Text(
                                'Female',
                                // '${gender}',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.only(left: 15.0),
                              child: Text(
                                'Male',
                                // '${gender}',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15.0, top: 7.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_city,
                        color: Colors.grey,
                        size: 32.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15.0),
                        child: Text(
                          '${snapshot.data['country']}',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 1.0),
                        child: Text(
                          ',',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5.0),
                        child: Text(
                          '${snapshot.data['city']}',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return LinearProgressIndicator();
        },
      ),

    );
  }
}
