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
  Future _data2;
  double rating = 0;

  Future getDoctors() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection("users")
        .where('role', isEqualTo: "doctor")
        .getDocuments();
    return qn.documents;
  }

  Future getRates() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("rate").getDocuments();
    return qn.documents;
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
    _data2 = getRates();
  }

  List<String> iDs = new List<String>();
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

            for (int i = 0; i < myList.length; i++) {
              for (int j = 0; j < snapshot.data.length; j++) {
                if (myList[i] == snapshot.data[j].data['id']) {
                  iDs.add(myList[i]);
                }
              }
            }
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                String currentId = snapshot.data[index].data["id"];

                // if (snapshot.data[index].data["doctorId"] = null)
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
                            SingleChildScrollView(
                                child: FutureBuilder(
                                    future: _data2,
                                    builder: (_, snapshot) {
                                      if (snapshot.hasData) {
                                        List<dynamic> idList =
                                            new List<dynamic>();
                                        List<dynamic> rateList =
                                            new List<dynamic>();
                                        for (int i = 0;
                                            i < snapshot.data.length;
                                            i++) {
                                          idList.add(
                                              snapshot.data[i].data['drId']);
                                          rateList.add(
                                              snapshot.data[i].data['rating']);
                                        }

                                        List<double> ratesforAVG =
                                            new List<double>();
                                        //double rateFromDb;
                                        double ratingVal() {
                                          for (int i = 0; i < iDs.length; i++) {
                                            for (int j = 0;
                                                j < idList.length;
                                                j++) {
                                              if (idList[j] == iDs[i] &&
                                                  iDs[i] == currentId) {
                                                ratesforAVG.add(rateList[j]);
                                              }
                                            }
                                          }

                                          double sum = 0;
                                          ratesforAVG.forEach((element) {
                                            sum += element;
                                          });

                                          double avg = 0;

                                          if (sum != 0) {
                                            avg = sum / ratesforAVG.length;
                                          }

                                          print(avg);
                                          if (avg != null) {
                                            return avg;
                                          }

                                          return 0;
                                        }

                                        return StarRating(
                                          size: 30.0,
                                          rating: ratingVal(),
                                          color: Colors.yellow[600],
                                          borderColor: Colors.black,
                                          starCount: 5,
                                        );
                                      } else {
                                        return Text(
                                          'Loading...',
                                          textAlign: TextAlign.center,
                                        );
                                      }
                                    })),
                          ]),
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
