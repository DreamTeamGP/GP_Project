import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:gp_project/Pages/Detailsdoctor.dart';
import 'package:gp_project/Pages/homepage.dart';

// class searchDoctor extends StatefulWidget {
//   final FirebaseUser currentUser;

//   const searchDoctor({Key key, this.currentUser}) : super(key: key);
//   @override
//   _searchDoctorState createState() => _searchDoctorState();
// }

// class _searchDoctorState extends State<searchDoctor> {
//   List item =[

//   ];
//   @override
//   void initState() {
//     super.initState();

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: DefaultTabController(
//             length: 2,
//             child: Scaffold(
//                 appBar: AppBar(
//                   centerTitle: true,
//                   title: Text(
//                     "Find Doctors",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 30.0,
//                     ),
//                   ),
//                   leading: new IconButton(
//                     icon: Icon(
//                       Icons.arrow_back_ios,
//                       size: 30.0,
//                       color: Colors.white,
//                     ),
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => HomePage(
//                                     user: widget.currentUser,
//                                   )));
//                     },
//                   ),
//                   backgroundColor: Colors.cyan,
//                   bottom: TabBar(tabs: <Widget>[
//                     Text(
//                       "By Name",
//                       style: TextStyle(
//                           fontSize: 20.0, color: Colors.pink.shade100),
//                     ),
//                     Text(
//                       "By Location",
//                       style: TextStyle(
//                           fontSize: 20.0, color: Colors.pink.shade100),
//                     ),
//                   ]),
//                 ),
//                 body: TabBarView(
//                     children: <Widget>[searchByName(), dropDown()]))));
//   }
// }

class searchByName extends StatefulWidget {
  final FirebaseUser currentUser;

  const searchByName({Key key, this.currentUser}) : super(key: key);

  @override
  _searchByNameState createState() => _searchByNameState();
}

class _searchByNameState extends State<searchByName> {
  String name = "";
  String _currentlySelected;
  Future data;
  File _image;

  navigateToDetail(DocumentSnapshot doctor) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              details(doctor: doctor, currentuser: widget.currentUser)),
    );
  }

  Future getDoctors() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection("users")
        .where('role', isEqualTo: "doctor")
        .where('address1', isEqualTo: _currentlySelected)
        .getDocuments();
    //return qn.documents;
    print(qn);
  }

  final List<String> _dropdownValues = [
    'Cairo',
    'Helwan',
    'Elsayda zeinb',
    'Maadi',
    'El marg',
    'Dar elsalam',
    'Ein shams',
    'Masr eladema',
    'Madena masr',
    'El abasia',
    'Wst elbalad',
    'Masr elgdeda',
    'Garden city',
    '5th settlement',
    'Wst elbalad',
    'El mataria',
    'Shoubra',
    'Giza',
    'Elmohndseen',
    'Dokki',
    'Haram',
    'Faisal',
    'Elmonieb',
    'Elshikh zayed',
    '6 octobor',
    'Alexandria',
    'Roshdy',
    'Camp sheraz',
    'Abo keer',
    'Agamy',
    'Montazah',
    'Sedy beshr',
    'Myami',
    'Dakhalia',
    'Elmasoura',
    'Sherbeen',
    'El esmaielia',
    'El mania',
    'Port said',
    'Sohag',
    'Aswan',
    'Louxor',
  ];

  Future _data;

  getData() {
    Firestore.instance
        .collection('users')
        .where('address1', isEqualTo: _currentlySelected)
        .snapshots();

    //return qn ;
  }

  Future getRates() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("rate").getDocuments();
    return qn.documents;
  }

  Widget dropdownWidget() {
    return DropdownButton<String>(
      hint: Text("choose location"),

      items: _dropdownValues
          .map((value) => DropdownMenuItem(
                child: Text(
                  value,
                  style: TextStyle(fontSize: 20),
                ),
                value: value,
              ))
          .toList(),
      onChanged: (String value) {
        _currentlySelected = value;
        setState(() {
          value;
        });
      },

      isExpanded: false,
      //make default value of dropdown the first value of our list
      value: _currentlySelected,
    );
  }

  @override
  void initState() {
    // _dropdownMenuItems = buildDropdownMenuItems(_loc);
    //  _selectedCompany = _dropdownMenuItems[0].value;
    super.initState();
    _data = getRates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // centerTitle: true,
          title: Text(
            'Find Doctor',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
            ),
          ),
          backgroundColor: Colors.cyan,
          actions: <Widget>[
            //Add the dropdown widget to the `Action` part of our appBar. it can also be among the `leading` part
            dropdownWidget()
          ],
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
                      builder: (context) =>
                          HomePage(user: widget.currentUser)));
            },
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: 15.0, bottom: 10.0, right: 10.0, left: 10.0),
                child: TextField(
                  onChanged: (val) => initiateSearch(val),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      contentPadding: EdgeInsets.only(left: 25.0),
                      hintText: 'Search by name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0))),
                ),
              ),
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                stream: (name != "" && name != null)
                    ? Firestore.instance
                        .collection('users')
                        .where("SearchIndex", arrayContains: name)
                        .snapshots()
                    : //getDoctors(),
                    Firestore.instance
                                    .collection("users")
                                    .where('role', isEqualTo: "doctor")
                                    // .where('address1' , isEqualTo: _currentlySelected)
                                    .snapshots() !=
                                null &&
                            _currentlySelected != "" &&
                            _currentlySelected != null
                        ? Firestore.instance
                            .collection('users')
                            .where("clinicRegion",
                                isEqualTo: _currentlySelected)
                            .snapshots()
                        : Firestore.instance
                            .collection("users")
                            .where('role', isEqualTo: "doctor")
                            .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return new Text('Loading...');
                    default:
                      return ListView(
                        children: snapshot.data.documents
                            .map((DocumentSnapshot document) {
                          return Column(children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(
                                    top: 0.0,
                                    bottom: 10.0,
                                    right: 10.0,
                                    left: 10.0),
                                child: Row(children: <Widget>[
                                  document['photo'] != null
                                      ? CircleAvatar(
                                          radius: 50.0,
                                          backgroundImage: NetworkImage(
                                            document['photo'],
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
                                              image:
                                                  AssetImage('icons/user.jpg'),
                                              fit: BoxFit.fill,
                                            ),
                                            shape: BoxShape.circle,
                                            //borderRadius: BorderRadius.all(Radius.circular(75.0)),
                                          ),
                                        ),
                                  Container(
                                    width: 20,
                                  ),
                                  //Row(
                                  //  children: <Widget>[
                                  Flexible(
                                      child: Column(children: <Widget>[
                                    new ListTile(
                                      onTap: () => navigateToDetail(document),
                                      title: new Text(
                                        '${document['name']}',
                                        style: TextStyle(
                                          fontSize: 21,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ])),
                                  SingleChildScrollView(
                                      child: FutureBuilder(
                                          future: _data,
                                          builder: (_, snapshot) {
                                            if (snapshot.hasData) {
                                              List<dynamic> idList =
                                                  new List<dynamic>();
                                              List<dynamic> rateList =
                                                  new List<dynamic>();
                                              for (int i = 0;
                                                  i < snapshot.data.length;
                                                  i++) {
                                                idList.add(snapshot
                                                    .data[i].data['drId']);
                                                rateList.add(snapshot
                                                    .data[i].data['rating']);
                                              }
                                              String drId = document['id'];
                                              double rateFromDb;
                                              List<double> ratesforAVG =
                                                  new List<double>();
                                              double ratingVal() {
                                                for (int i = 0;
                                                    i < idList.length;
                                                    i++) {
                                                  if (idList[i] == drId) {
                                                    ratesforAVG
                                                        .add(rateList[i]);
                                                  }
                                                }

                                                double sum = 0;
                                                ratesforAVG.forEach((element) {
                                                  sum += element;
                                                });

                                                double avg = 0;

                                                if (sum != 0) {
                                                  avg =
                                                      sum / ratesforAVG.length;
                                                }

                                                print(avg);
                                                if (avg != null) {
                                                  return avg;
                                                }

                                                return 0;
                                              }

                                              return StarRating(
                                                size: 20.0,
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
                                ]))
                          ]);
                        }).toList(),
                      );
                  }
                },
              ) //;
                  // })//;
                  //}),
                  )
            ],
          ),
        ));
  }

  void initiateSearch(String val) {
    setState(() {
      name = val.toLowerCase().trim();
    });
  }
}
