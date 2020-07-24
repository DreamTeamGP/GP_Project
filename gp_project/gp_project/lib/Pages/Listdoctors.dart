import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:gp_project/Auth/line.dart';
import 'Detailsdoctor.dart';
import '../models/doctor.dart';
import 'homepage.dart';

class listdoc extends StatefulWidget {
  final FirebaseUser currentUser;

  const listdoc({Key key, this.currentUser}) : super(key: key);

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
    QuerySnapshot qn2 = await firestore.collection('rate').getDocuments();
    return qn.documents + qn2.documents;
  }

  navigateToDetail(DocumentSnapshot doctor) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              details(doctor: doctor, currentuser: widget.currentUser)),
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
            fontSize: 28.0,
          ),
        ),
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
                          user: widget.currentUser,
                        )));
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
            List<dynamic> myList = new List<dynamic>();
            for (int i = 0; i < snapshot.data.length; i++) {
              Map<String, dynamic>.from(snapshot.data[i].data)
                  .forEach((key, value) {
                myList.add(value);
              });
            }

            // myList.forEach((element) {
            //   print(element);
            // });

            String drIdOfRate = myList[myList.length - 2];
            double rateFromDb = myList[myList.length - 1];
            double sum = 0;
            double r = 0;
            for (int i = 0; i < myList.length; i++) {
              if (myList[i] == drIdOfRate) {
                r++;
              }
            }
            for (int j = 0; j < 1; j++) {
              sum = sum + rateFromDb;
            }
            double rateAvg = sum / (r - 1);
            print(rateAvg);
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
                          snapshot.data[index].data["photo"] != null
                              ? CircleAvatar(
                                  radius: 40.0,
                                  backgroundImage: NetworkImage(
                                    snapshot.data[index].data["photo"],
                                  ),
                                )
                              : Container(
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
                                ),
                          Container(
                            width: 20,
                          ),
                          Column(children: <Widget>[
                            GestureDetector(
                              onTap: () =>
                                  navigateToDetail(snapshot.data[index]),
                              child: Container(
                                margin: EdgeInsets.only(top: 15),
                                child: Text(
                                  '${snapshot.data[index].data["name"]}',
                                  //'snapshot.data[index].data["name"]',
                                  style: TextStyle(
                                    fontSize: 21,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            StarRating(
                              size: 25.0,
                              rating: 2.3,
                              color: Colors.yellow[600],
                              borderColor: Colors.black,
                              starCount: 5,
                            ),
                          ]),
                          // Column(
                          //   children: <Widget>[
                          //     StarRating(
                          //       size: 25.0,
                          //       rating: 2.3,
                          //       color: Colors.yellow[600],
                          //       borderColor: Colors.black,
                          //       starCount: 5,
                          //     ),
                          //   ],
                          // ),
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
