import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gp_project/Pages/profiledrawer.dart';
import '../models/user.dart';
import '../Pages/profileEditWidget.dart';

class profileWidget extends StatefulWidget {
  final FirebaseUser currentUser;
  final User user;
  @override
  _profileWidgetState createState() => _profileWidgetState();
  profileWidget({this.currentUser, this.user});
}

class _profileWidgetState extends State<profileWidget> {
  String gender;
  @override
  void initState() {
    //widget.user.gender == 1 ? gender = 'female' : gender = 'male';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //user = this.userClass.getCurrentUser();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
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
            .document(widget.currentUser.uid)
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
                    // snapshot.data['gender'] == 1
                    //     ? Container(
                    //         margin: EdgeInsets.only(top: 20.0),
                    //         width: 100,
                    //         height: 100,
                    //         decoration: BoxDecoration(
                    //           //color: Colors.blue,
                    //           //image here
                    //           image: DecorationImage(
                    //             image: AssetImage('icons/Womanuser.png'),
                    //             fit: BoxFit.fill,
                    //           ),
                    //           shape: BoxShape.circle,
                    //           //borderRadius: BorderRadius.all(Radius.circular(75.0)),
                    //         ),
                    //       )
                    //     : Container(
                    //         margin: EdgeInsets.only(top: 20.0),
                    //         width: 100,
                    //         height: 100,
                    //         decoration: BoxDecoration(
                    //           //color: Colors.blue,
                    //           //image here
                    //           image: DecorationImage(
                    //             image: AssetImage('icons/user.jpg'),
                    //             fit: BoxFit.fill,
                    //           ),
                    //           shape: BoxShape.circle,
                    //           //borderRadius: BorderRadius.all(Radius.circular(75.0)),
                    //         ),
                    //       ),
                    CircleAvatar(
                      radius: 80.0,
                      backgroundImage: NetworkImage(
                        snapshot.data['photo'],
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
      floatingActionButton: Container(
          width: 85.0,
          height: 85.0,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => profileEditWidget(
                            currentUser: widget.currentUser,
                          )));
            },
            child: Icon(
              Icons.edit,
              color: Colors.white,
              size: 50.0,
            ),
          )),
    );
  }
}
