import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp_project/Classes/User.dart';
import 'package:gp_project/Auth/line.dart';
import 'package:gp_project/Pages/profiledrawer.dart';
import 'package:gp_project/Pages/measurementPopup.dart';
import 'package:gp_project/Pages/moodPopup.dart';
import 'package:gp_project/models/user.dart';
import 'Detailsdoctor.dart';
import '../Classes/LocalNotification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.user}) : super(key: key);
  final FirebaseUser user;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LocalNotifications localNotifications = new LocalNotifications();
  var mood = ['mood'];
  var month = ['month'];
  
  final List<String> _dropdownValues = [
    "One",
    "Two",
    "Three",
    "Four",
    "Five"
  ]; //The list of values we want on the dropdown
  UserClass userClass = new UserClass();
  User user = new User();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  User currentUser = new User();
  void measurementAlert(String patientName, String patientDoctor){
    
    Firestore.instance
                .collection('patientAlert')
                .document()
                .setData(
                  {
                    'doctorID':patientDoctor,
                    'patientID':widget.user.uid,
                    'patientName':patientName,
                    'state':"the measurments are upnormal for three days please take care",
                  });
  }
  initUser() async {
    DocumentSnapshot measurementAlertResult = await Firestore.instance
    .collection('patientsMeasurements')
        .where('UserId', isEqualTo: widget.user.uid)
        // .where('UserId', isGreaterThan: widget.user.uid)
        .getDocuments().then((snapshot){
          print(snapshot.documents);
    });

    DocumentSnapshot result = await Firestore.instance.collection('users').document(widget.user.uid
     )
    .get().then((snapshot){
      if(snapshot.data['role']=="patient"){
        measurementAlert(snapshot.data['name'], snapshot.data['doctorId']);
      }
      
    });
    
    setState(() {});
  }

  User patient = new User();
  ScrollController _scrollController = new ScrollController();
  final _formKey = GlobalKey<FormState>();
  Future _data;
  Future getPatients() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection("users")
        .where('role', isEqualTo: "patient")
        .where('doctorId', isEqualTo: widget.user.uid)
        .getDocuments();
    return qn.documents;
  }

  navigateToDetail(DocumentSnapshot doctor) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => details(doctor: doctor)),
    );
  }

  // @override
  // void initState() {
  //   localNotifications.dailyMeasurementReminder();
  //   print('local from home');
  //   super.initState();
  //   initUser();
  //   _data = getPatients();
    
  // }
//
final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();
  
  StreamSubscription iosSubscription;
  _saveDeviceToken() async {
    // Get the current user
    String uid = widget.user.uid;
    String fcmToken = await _fcm.getToken();
    // Save it to Firestore
    if (fcmToken != null) {
      var tokens = _db
          .collection('users')
          .document(uid)
          .collection('tokens')
          .document(fcmToken);

      await tokens.setData({
        'token': fcmToken,
        'createdAt': FieldValue.serverTimestamp(), // optional
        'platform': Platform.operatingSystem // optional
      });
    }
  }
  @override
    void initState() {
      super.initState();
      localNotifications.dailyMeasurementReminder();
      initUser();
      _data = getPatients();
      if (Platform.isIOS) {
        iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
          print(data);
          _saveDeviceToken();   
        });

        _fcm.requestNotificationPermissions(IosNotificationSettings());
      } else {
        _saveDeviceToken();
      }
      _fcm.configure(
          onMessage: (Map<String, dynamic> message) async {
            print("onMessage: $message");
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                        content: ListTile(
                        title: Text(message['notification']['title']),
                        subtitle: Text(message['notification']['body']),
                        ),
                        actions: <Widget>[
                        FlatButton(
                            child: Text('Ok'),
                            onPressed: () => Navigator.of(context).pop(),
                        ),
                    ],
                ),
            );
        },
        onLaunch: (Map<String, dynamic> message) async {
            print("onLaunch: $message");
            // TODO optional
        },
        onResume: (Map<String, dynamic> message) async {
            print("onResume: $message");
            // TODO optional
        },
      );
    }
  @override
  void dispose() {
    if (iosSubscription != null) iosSubscription.cancel();
    super.dispose();
  }
//
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // floatingActionButton: FloatingActionButton(child: Icon(Icons.person),onPressed: (){},),
        drawer: ProfileDrawer(currentUser: widget.user),
        appBar: AppBar(
          title: Text(
            'Home',
            style: TextStyle(fontSize: 30),
          ),
          backgroundColor: Colors.cyan,
          actions: <Widget>[
            IconButton(
              icon: new Icon(Icons.announcement),
              onPressed: () {},
              iconSize: 30,
            ),
            IconButton(
              icon: new Icon(Icons.notifications_none),
              onPressed: () {},
              iconSize: 30,
            )
          ],
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection('users')
              .document(widget.user.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return checkRole(snapshot.data);
            }
            return LinearProgressIndicator();
          },
        ),
      ),
    );
  }

  FutureBuilder checkRole(DocumentSnapshot snapshot) {
    if (snapshot.data == null) {
      return FutureBuilder(
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text("Loading ..."),
            );
          } else {
            return new Text('no data set in the userId document in firestore');
          }
        },
      );
    }
    if (snapshot.data['role'] == 'doctor') {
      return docPage(snapshot);
    } else {
      return userPage(snapshot);
    }
  }

  FutureBuilder docPage(DocumentSnapshot snapshot) {
    return FutureBuilder(
        future: _data,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text("Loading ..."),
            );
          } else {
            return new Column(
              children: <Widget>[
                new Container(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 20.0, bottom: 0.0, right: 10.0, left: 10.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 30.0),
                          width: 130.0,
                          height: 21.0,
                          child: Text(
                            "Patient name",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              //fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          height: 20.0,
                          width: 70,
                        ),
                        Flexible(
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.only(top: 30.0),
                              width: 65.0,
                              height: 21.0,
                              child: Text(
                                "Profile",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  //fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 20.0,
                          width: 50,
                        ),
                        Flexible(
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.only(top: 30.0, left: 10),
                              width: 100.0,
                              height: 47.0,
                              child: Text(
                                "Print report",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                new Expanded(
                  child: new ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                top: 0.0, bottom: 0.0, right: 10.0, left: 10.0),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 10.0),
                                  width: 130.0,
                                  height: 40.0,
                                  child: Text(
                                    snapshot.data[index].data["name"],
                                    style: TextStyle(
                                      fontSize: 21,
                                      //fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 20.0,
                                  width: 70,
                                ),
                                Flexible(
                                  child: GestureDetector(
                                    onTap: () =>
                                        navigateToDetail(snapshot.data[index]),
                                    child: Container(
                                      height: 80.0,
                                      margin: EdgeInsets.only(top: 0),
                                      child: IconButton(
                                        icon: new Icon(
                                          Icons.person,
                                          color: Colors.green,
                                        ),
                                        onPressed: () {},
                                        iconSize: 50,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 20.0,
                                  width: 50,
                                ),
                                Flexible(
                                  child: GestureDetector(
                                    onTap: () =>
                                        navigateToDetail(snapshot.data[index]),
                                    child: Container(
                                      height: 80.0,
                                      margin: EdgeInsets.only(top: 10),
                                      child: IconButton(
                                        icon: new Icon(
                                          Icons.print,
                                          color: Colors.blue,
                                        ),
                                        onPressed: () {},
                                        iconSize: 50,
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
                                CustomPaint(
                                    painter: Drawhorizontalline4(false)),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          }
        });
  }

  FutureBuilder userPage(DocumentSnapshot snapshot) {
    return FutureBuilder(
      builder: (_, snapshot) {
        return new Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: new ListView(
            // scrollDirection: Axis.horizontal,
            children: <Widget>[
              RaisedButton(
                child: new Row(
                  children: <Widget>[
                    Icon(
                      Icons.list,
                      size: 35,
                    ),
                    Text(
                      '  New Measurment',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    )
                  ],
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Measurement'),
                          titleTextStyle: TextStyle(
                            backgroundColor: Colors.cyan,
                            fontSize: 25.0,
                          ),
                          content: MeasurementPopUp(),
                        );
                      });
                },
                color: Colors.cyanAccent[200],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              RaisedButton(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.fastfood, size: 35),
                    Text(
                      '  Meal Intake',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    )
                  ],
                ),
                onPressed: () {},
                color: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              RaisedButton(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.tag_faces, size: 35),
                    Text(
                      '  Mood',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    )
                  ],
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: Text('Measurement'),
                            titleTextStyle: TextStyle(
                              backgroundColor: Colors.cyan,
                              fontSize: 25.0,
                            ),
                            content: MoodPopUp());
                      });
                },
                color: Colors.yellow,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              RaisedButton(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.person, size: 35),
                    Text(
                      '  Profile',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    )
                  ],
                ),
                onPressed: () {},
                color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 0),
                  child: Text(
                    'Statistics Bar Chart',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  )),
             Row(
                children: <Widget>[
                  Expanded(
                      child: DropdownButton<String>(
                    items: mood.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    value: 'mood',
                    // onChanged: (){},
                  )),
                  Expanded(
                      child: DropdownButton<String>(
                    items: month.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                   //onChanged: (){},
                  )),
                ],
              ),
              //Column(children: <Widget>[chartdisplay],),
            ],
          ),
        );
      },
    );
  }
}
