import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp_project/models/meal.dart';
import 'package:gp_project/models/user.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class calenderPage extends StatefulWidget {
  final FirebaseUser user;

  const calenderPage({Key key, this.user}) : super(key: key);
  @override
  _calenderPageState createState() => _calenderPageState();
}

class _calenderPageState extends State<calenderPage> {
  User user = new User();
  Meal meal = new Meal();

  CalendarController _controller;
  final _formKey = GlobalKey<FormState>();
  ScrollController _scrollController = ScrollController();

  Future _data;

  getMeasurement() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection("patientsMeasurements")
        .where("UserId", isEqualTo: widget.user.uid)
        .getDocuments();
    return qn.documents;
  }

  getMood() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection("moods")
        .where("Timestamp", isEqualTo: onSelected)
        .where("UserId", isEqualTo: widget.user.uid)
        .getDocuments();

    return qn.documents;
  }

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Calendar'),
        backgroundColor: Colors.cyan,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              initialCalendarFormat: CalendarFormat.month,
              //dayHitTestBehavior: HitTestBehavior.deferToChild,

              calendarStyle: CalendarStyle(
                  todayColor: Colors.orange,
                  selectedColor: Colors.cyan,
                  todayStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.white)),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                formatButtonTextStyle: TextStyle(color: Colors.white),
                formatButtonShowsNext: false,
              ),
              startingDayOfWeek: StartingDayOfWeek.saturday,
              onDaySelected: onSelected,
              builders: CalendarBuilders(
                selectedDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.cyan,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
                todayDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              calendarController: _controller,
            )
          ],
        ),
      ),
    );
  }

  void onSelected(DateTime day, List events) {
    _show(context, day);
    // print(day);
  }

  Future _show(BuildContext context, DateTime day) async {
    getDateForTimetamp(DateTime inputVal) {
      String processedDate = inputVal.year.toString() +
          '-' +
          inputVal.month.toString() +
          '-' +
          inputVal.day.toString();
      return processedDate;
    }

    getMeasurementDate(DateTime inputVal) {
      String processedDate = DateFormat("yyyy-MM-dd").format(inputVal);
      return processedDate;
    }

//   getDateForMoo(DateTime date){
//      date = timestamp.toDate();
//  return DateFormat("yyyy-MM-dd").format(date);
//   }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Container(
              color: Colors.cyan,
              child: Text('On This Day'),
            ),
            titleTextStyle: TextStyle(
              //backgroundColor: Colors.cyan,
              color: Colors.white,
              fontSize: 25.0,
              fontWeight: FontWeight.w600,
            ),
            content: Container(
                padding: EdgeInsets.all(5.0),
                width: 280.0,
                //   height: 200.0,
                child: Column(children: <Widget>[
                  Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection("moods")
                        .where("Date", isEqualTo: getDateForTimetamp(day))
                        .where("UserId", isEqualTo: widget.user.uid)
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
                                      Text(
                                        'Mood:',
                                        style: TextStyle(
                                          fontSize: 23,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Flexible(
                                          child: Column(children: <Widget>[
                                        new ListTile(
                                          title: new Text(
                                            '${document['mood']}',
                                            style: TextStyle(
                                              fontSize: 19,
                                              color: Colors.cyan.shade700,
                                            ),
                                          ),
                                        )
                                      ]))
                                    ]))
                              ]);
                            }).toList(),
                          );
                      }
                    },
                  )),
                  Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection("meals")
                        .where("Date", isEqualTo: getDateForTimetamp(day))
                        .where("UserID", isEqualTo: widget.user.uid)
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
                                      Text(
                                        'Meals:',
                                        style: TextStyle(
                                          fontSize: 23,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // Container(
                                      //   width: 20,
                                      // ),
                                      //Row(
                                      //  children: <Widget>[
                                      Flexible(
                                          child: Column(children: <Widget>[
                                        new ListTile(
                                          title: new Text(
                                            '${document['food']}',
                                            style: TextStyle(
                                              fontSize: 19,
                                              color: Colors.cyan.shade700,
                                            ),
                                          ),
                                        )
                                      ]))
                                    ]))
                              ]);
                            }).toList(),
                          );
                      }
                    },
                  )),
                  Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection("patientsMeasurements")
                        .where("Date", isEqualTo: getMeasurementDate(day))
                        .where("UserId", isEqualTo: widget.user.uid)
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
                                      Text(
                                        'Measurement:',
                                        style: TextStyle(
                                          fontSize: 23,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // Container(
                                      //   width: 20,
                                      // ),
                                      //Row(
                                      //  children: <Widget>[
                                      Flexible(
                                          child: Column(children: <Widget>[
                                        new ListTile(
                                          title: new Text(
                                            '${document['measurement']}',
                                            style: TextStyle(
                                              fontSize: 19,
                                              color: Colors.cyan.shade700,
                                            ),
                                          ),
                                        )
                                      ]))
                                    ]))
                              ]);
                            }).toList(),
                          );
                      }
                    },
                  ))
                ])),
            actions: [
              new Center(
                child: FlatButton(
                  child: const Text(
                    "OK",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          );
        });
  }
}
