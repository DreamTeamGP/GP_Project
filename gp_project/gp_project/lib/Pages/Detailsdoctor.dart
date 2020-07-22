import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp_project/Pages/Listdoctors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class details extends StatefulWidget {
  final FirebaseUser currentuser;
  final DocumentSnapshot doctor;
  details({this.doctor, this.currentuser});
  @override
  _detailsState createState() => _detailsState();
}
 
class _detailsState extends State<details> {
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
          widget.doctor.data["name"],
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
                    builder: (context) => listdoc(
                          currentUser: widget.currentuser,
                        )));
          },
        ),
      ),
      body: Column(
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

      floatingActionButton: Container(
        width: 95.0,
        height: 95.0,
        child: FloatingActionButton(
          onPressed: () {
            Firestore.instance
                .collection('addDoctorRequest')
                .document()
                .setData({
              'doctorID': widget.doctor.data["id"],
              'patientID': widget.currentuser.uid,
              'patientName': patientName,
              'approved': 0,
            });
            SnackBar(content: Text('Request has been Sent,Thank you'));
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => listdoc(
                          currentUser: widget.currentuser,
                        )));
          },
          child: Icon(
            Icons.person_add,
            color: Colors.white,
            size: 50.0,
          ),
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
