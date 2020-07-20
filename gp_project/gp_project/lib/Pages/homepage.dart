import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gp_project/Classes/User.dart';
import 'package:gp_project/Auth/line.dart';
import 'package:gp_project/Pages/Detailsuser.dart';
import 'package:gp_project/Pages/MeasurementGraph.dart';
import 'package:gp_project/Pages/OneYearReport.dart';
import 'package:gp_project/Pages/SixMonReport.dart';
import 'package:gp_project/Pages/ThreeMonReport.dart';
import 'package:gp_project/Pages/profileWidget.dart';
import 'package:gp_project/Pages/profiledrawer.dart';
import 'package:gp_project/Pages/measurementPopup.dart';
import 'package:gp_project/Pages/moodPopup.dart';
import 'package:gp_project/models/user.dart';
import 'package:simple_animations/simple_animations.dart';
import 'Detailsdoctor.dart';
import 'meals.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.user}) : super(key: key);
  final FirebaseUser user;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var mood = ['mood'];
  var month = ['month'];

  UserClass userClass = new UserClass();
  User user = new User();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  User currentUser = new User();

  initUser() async {
    //firebaseUser = await _firebaseAuth.currentUser();
    //userID = firebaseUser.uid;
    currentUser = this.userClass.getCurrentUser();
    setState(() {});
  }

  // ignore: deprecated_member_use
  ControlledAnimation bar(final double height, final String label) {
    final int _baseDurationMs = 1000;
    final double _maxElementHeight = 100;
    // ignore: deprecated_member_use
    return ControlledAnimation(
      duration: Duration(milliseconds: (height * _baseDurationMs).round()),
      tween: Tween(begin: 0.0, end: height),
      builder: (context, animatedHeight) {
        return Expanded(
            child: Column(
          children: <Widget>[
            Container(
              width: 60,
              height: animatedHeight * _maxElementHeight,
              color: Colors.cyan,
            ),
            Text(label)
          ],
        ));
      },
    );
  }

  User patient = new User();
  ScrollController _scrollController = new ScrollController();
  final _formKey = GlobalKey<FormState>();
  Future _data;
  Future _data2;
  Future getMeasurements() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection("patientsMeasurements")
        .where('UserId', isEqualTo: widget.user.uid)
        .getDocuments();
    return qn.documents;
  }

  Future getPatients() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection("users")
        .where('role', isEqualTo: "patient")
        .where('doctorId', isEqualTo: widget.user.uid)
        .getDocuments();
    return qn.documents;
  }

  navigateToDetail(DocumentSnapshot patient) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              detailsuser(patient: patient, currentuser: widget.user)),
    );
  }
  navigateToThreemon(DocumentSnapshot patient) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              ThreeMonthReport(patient: patient, currentUser: widget.user)),
    );
  }  
  navigateToSixmon(DocumentSnapshot patient) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              sixMonthReport(patient: patient, currentUser: widget.user)),
    );
  }  
  navigateToOneyear(DocumentSnapshot patient) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              oneYearReport(patient: patient, currentUser: widget.user)),
    );
  }

  @override
  void initState() {
    super.initState();
    initUser();
    _data = getPatients();
    _data2 = getMeasurements();
  }

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

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose Report'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  width: 500,
                  child: RaisedButton(
                    child: Text(
                      "3-Months Report",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ThreeMonthReport(
                            currentUser: widget.user,
                          ),
                        ),
                      );
                      // Navigator.of(context).pop();
                    },
                    color: Colors.cyan,
                  ),
                ),
                Container(
                  width: 500,
                  child: RaisedButton(
                    child: Text(
                      "6-Months Report",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => sixMonthReport(
                            currentUser: widget.user,
                          ),
                        ),
                      );
                      // Navigator.of(context).pop();
                    },
                    color: Colors.cyan,
                  ),
                ),
                Container(
                  width: 500,
                  child: RaisedButton(
                    child: Text(
                      "One Year Report",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => oneYearReport(
                            currentUser: widget.user,
                          ),
                        ),
                      );
                      // Navigator.of(context).pop();
                    },
                    color: Colors.cyan,
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
            return new Text(
                'There is no data for this user,check and try again');
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
          } else if (!snapshot.hasData) {
            return Center(
              child: Text(
                "No patients yet",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
                                    //onTap: () =>
                                    //  navigateToDetail(snapshot.data[index]),
                                    child: Container(
                                      height: 80.0,
                                      margin: EdgeInsets.only(top: 0),
                                      child: IconButton(
                                        //onPressed: navigateToDetail(snapshot.data[index]),
                                        icon: new Icon(
                                          Icons.person,
                                          color: Colors.green,
                                        ),
                                        iconSize: 50,
                                        onPressed: () {
                                          navigateToDetail(
                                              snapshot.data[index]);
                                        },
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
                                    // onTap: () =>
                                    //   showDialog(context: context),
                                    child: Container(
                                      height: 80.0,
                                      margin: EdgeInsets.only(top: 10),
                                      child: IconButton(
                                        icon: new Icon(
                                          Icons.print,
                                          color: Colors.blue,
                                        ),
                                        iconSize: 50,
                                        onPressed: () {
                                          showDialog<void>(
                                            context: context,
                                            barrierDismissible:
                                                false, // user must tap button!
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Choose Report'),
                                                content: SingleChildScrollView(
                                                  child: Column(
                                                    children: <Widget>[
                                                      Container(
                                                        width: 500,
                                                        child: RaisedButton(
                                                          child: Text(
                                                            "3-Months Report",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                                navigateToThreemon(snapshot.data[index]);
                                                             },
                                                          color: Colors.cyan,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 500,
                                                        child: RaisedButton(
                                                          child: Text(
                                                            "6-Months Report",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            navigateToSixmon(snapshot.data[index]);
                                                          },
                                                          color: Colors.cyan,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 500,
                                                        child: RaisedButton(
                                                          child: Text(
                                                            "One Year Report",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            navigateToOneyear(snapshot.data[index]);
                                                          },
                                                          color: Colors.cyan,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                          //_showMyDialog();
                                        },
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
                      color: Colors.white,
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
                          title: Container(
                            color: Colors.cyan,
                            child: Text(
                              'Measurement',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          titleTextStyle: TextStyle(
                            //backgroundColor: Colors.cyan,
                            fontSize: 25.0,
                          ),
                          content: MeasurementPopUp(currentUser: widget.user),
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
                    Icon(
                      Icons.fastfood,
                      size: 35,
                      color: Colors.white,
                    ),
                    Text(
                      '  Meal Intake',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    )
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => meals(
                        currentUser: widget.user,
                      ),
                    ),
                  );
                },
                color: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              RaisedButton(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.tag_faces,
                      size: 35,
                      color: Colors.white,
                    ),
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
                            title: Container(
                              color: Colors.cyan,
                              child: Text(
                                'Mood',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            titleTextStyle: TextStyle(
                              //backgroundColor: Colors.cyan,
                              fontSize: 25.0,
                            ),
                            content: MoodPopUp(currentUser: widget.user));
                      });
                },
                color: Colors.yellow,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              RaisedButton(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      size: 35,
                      color: Colors.white,
                    ),
                    Text(
                      '  Profile',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    )
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => profileWidget(
                        currentUser: widget.user,
                      ),
                    ),
                  );
                },
                color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 0),
                  child: Text(
                    'Measurments Bar Chart',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  )),
              //Column(children: <Widget>[chartdisplay],),

              FutureBuilder(
                future: _data2,
                builder: (context, snapshot) {
                  Map<String, dynamic> myMap = new Map<String, dynamic>();
                  List<dynamic> myList = new List<dynamic>();
                  for (int i = 0; i < snapshot.data.length; i++) {
                    myMap = Map<String, dynamic>.from(snapshot.data[i].data);
                    print(myMap);
                  }

                  print('break');

                  //بتجيب القيم بتاعت الماب ممبر بالاندكس بتاعه كانهم ليستت قيم
                  for (int i = 0; i < snapshot.data.length; i++) {
                    Map<String, dynamic>.from(snapshot.data[i].data)
                        .forEach((key, value) {
                      myList.add(value);
                    });
                  }

                  double fastingValue() {
                    List<dynamic> arrayedValues = new List<dynamic>();
                    for (int i = 0; i < myList.length; i++) {
                      if (myList[i] != myList[i].toString()) {
                        arrayedValues.add(myList[i]);
                      }
                    }
                    List<dynamic> rawValues = new List<dynamic>();
                    List<dynamic> fasting = new List<dynamic>();
                    for (int i = 0; i < arrayedValues.length; i++) {
                      for (int j = 0; j < arrayedValues[i].length; j++) {
                        rawValues.add(arrayedValues[i].elementAt(j));
                        if (arrayedValues[i].elementAt(j) ==
                            'Fasting blood glucose') {
                          fasting.add(arrayedValues[i + 1].elementAt(j));
                        }
                      }
                    }
                    int sum = 0;
                    fasting.forEach((element) {
                      sum = sum + int.parse(element);
                    });
                    double avg = sum / fasting.length;
                    double avgModified = avg / 200;
                    return avg;
                  }

                  print(fastingValue());

                  double postprandialValue() {
                    List<dynamic> arrayedValues = new List<dynamic>();
                    for (int i = 0; i < myList.length; i++) {
                      if (myList[i] != myList[i].toString()) {
                        arrayedValues.add(myList[i]);
                      }
                    }
                    List<dynamic> rawValues = new List<dynamic>();
                    List<dynamic> postPrandial = new List<dynamic>();
                    for (int i = 0; i < arrayedValues.length; i++) {
                      for (int j = 0; j < arrayedValues[i].length; j++) {
                        rawValues.add(arrayedValues[i].elementAt(j));
                        if (arrayedValues[i].elementAt(j) ==
                            'Post prandial blood glucose') {
                          postPrandial.add(arrayedValues[i + 1].elementAt(j));
                        }
                      }
                    }
                    int sum = 0;
                    postPrandial.forEach((element) {
                      sum = sum + int.parse(element);
                    });
                    double avg = sum / postPrandial.length;
                    double avgModified = avg / 200;
                    return avg;
                  }

                  print(postprandialValue());

                  // myList.forEach((element) {
                  //   if (element != element.toString()) {
                  //     i++;
                  //   }
                  // });

                  //بترجع الليستات اللي في اول خمسة ممبر في الليست وبأكسس اللي جواهم ب سطر البرنت
                  // for (int i = 3; i < 5; i++) {
                  //   if (myList[i] != myList[i].toString()) {
                  //     y++;
                  //     print(myList[i].elementAt(1));
                  //   }
                  // }

                  print('break2');
                  var data = [
                    ClicksPerYear(
                        'Fasting blood glucose', fastingValue(), Colors.cyan),
                    ClicksPerYear('Post prandial blood glucose',
                        postprandialValue(), Colors.cyan),
                  ];

                  var series = [
                    charts.Series(
                      domainFn: (ClicksPerYear clickData, _) => clickData.year,
                      measureFn: (ClicksPerYear clickData, _) =>
                          clickData.value,
                      colorFn: (ClicksPerYear clickData, _) => clickData.color,
                      id: 'Clicks',
                      data: data,
                    ),
                  ];

                  var chart = charts.BarChart(
                    series,
                    animate: true,
                    animationDuration: Duration(milliseconds: 1000),
                  );

                  var chartWidget = Padding(
                    padding: EdgeInsets.only(top: 30, right: 15, left: 15),
                    child: SizedBox(
                      height: 280.0,
                      child: chart,
                    ),
                  );

                  if (snapshot.hasData) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          chartWidget,
                        ],
                      ),
                    );
                  } else {
                    return Text('Loading...');
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
