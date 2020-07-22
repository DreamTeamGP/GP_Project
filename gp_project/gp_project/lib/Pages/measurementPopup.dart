import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/user.dart';
import '../Services/measurement.dart';

class MeasurementPopUp extends StatefulWidget {
  final FirebaseUser currentUser;
  final User user;

  const MeasurementPopUp({Key key, this.currentUser, this.user})
      : super(key: key);

  @override
  _MeasurementPopUp createState() => _MeasurementPopUp();
}

class _MeasurementPopUp extends State<MeasurementPopUp> {
  final _formKey = GlobalKey<FormState>();
  final databaseReference = Firestore.instance;

  //final FirebaseAuth _auth = FirebaseAuth.instance;
  String _measure;
  String measruringTypedropdownValue = 'Fasting blood glucose';
  List<String> measurementType = [
    'Fasting blood glucose',
    'Post prandial blood glucose'
  ];

  TextEditingController _measurementController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(5.0),
      width: 230.0,
      height: 170.0,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DropdownButton<String>(
              value: measruringTypedropdownValue,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(
                color: Colors.black,
              ),
              underline: Container(
                height: 2,
                color: Colors.cyan,
              ),
              items:
                  measurementType.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String newValue) {
                setState(() {
                  measruringTypedropdownValue = newValue;
                });
              },
              isExpanded: false,
            ),
            Container(
              padding: EdgeInsets.all(5.0),
              child: TextFormField(
                controller: _measurementController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'please input a number';
                  }
                },
                onChanged: (val) {
                  _measure = val;
                },
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  hintText: 'Enter measurement in mg/dL',
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(2.0),
                child: RaisedButton(
                  child: Text(
                    'Record',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  color: Colors.cyan,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      print(_measurementController.text);
                      measurementRecord(); //records new measurement into db
                      Navigator.pop(context); //closes popup
                      _measurementController.clear(); //clears textfield
                    }
                    // SnackBar(content: Text("Successfully recorded"));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool flag = false; //data found or not
  var record; //array of the retrived record
  var docId; //document id of the retreived record

  //process the date
  getDate(DateTime inputVal) {
    String processedDate = inputVal.year.toString() +
        '-' +
        inputVal.month.toString() +
        '-' +
        inputVal.day.toString() +
        ' ' +
        inputVal.hour.toString() +
        ':' +
        inputVal.minute.toString();
    return processedDate;
  }

  getDateForTimeStamp(DateTime inputVal) {
    String processedDate = inputVal.year.toString() +
        inputVal.month.toString() +
        inputVal.day.toString();
    String processedDate = DateFormat("yyyy-MM-dd").format(inputVal);
    return processedDate;
  }

  @override
  void initState() {
    super.initState();
    DateTime now = new DateTime.now();
    DateTime date =
        new DateTime(now.year, now.month, now.day, now.hour, now.minute);
    Measurement()
        .getRecord(widget.currentUser.uid, getDateForTimeStamp(date),
            measruringTypedropdownValue)
        .then((QuerySnapshot docs) {
      if (docs.documents.isNotEmpty) {
        flag = true;
        docId = docs.documents[0].documentID;
        record = docs.documents[0].data;
      }
    });
  }

  void measurementRecord() async {
    DateTime now = new DateTime.now();
    DateTime date =
        new DateTime(now.year, now.month, now.day, now.hour, now.minute);

    //Map map = Map<int, String>();
    //map = {'uniqueid': UniqueKey(), 'value': measruringTypedropdownValue};

    List<String> timeStamp = [getDate(date)];
    List<String> measruringTime = [measruringTypedropdownValue];
    List<String> measurement = [_measurementController.text];
    //if doc found it will get updated
    if (flag &&
        record['UserId'] == widget.currentUser.uid &&
        record['Date'] == getDateForTimeStamp(date)) {
      if (measruringTypedropdownValue == "Fasting blood glucose") {
        if (int.parse(_measurementController.text) > 90 &&
            int.parse(_measurementController.text) < 140) {
          databaseReference
              .collection('patientsMeasurements')
              .document(docId)
              .updateData({
            'UserId': widget.currentUser.uid,
            'Date': getDateForTimeStamp(date),
            'Time': FieldValue.arrayUnion(timeStamp),
            'measruringTime': record['measruringTime'] + measruringTime,
            'measurement': FieldValue.arrayUnion(measurement),
          });
        } else {
          print("no measurement");
        }
      } else if (measruringTypedropdownValue == "Post prandial blood glucose") {
        if (int.parse(_measurementController.text) > 140 &&
            int.parse(_measurementController.text) < 180) {
          databaseReference
              .collection('patientsMeasurements')
              .document(docId)
              .updateData({
            'UserId': widget.currentUser.uid,
            'Date': getDateForTimeStamp(date),
            'Time': FieldValue.arrayUnion(timeStamp),
            'measruringTime': record['measruringTime'] + measruringTime,
            'measurement': FieldValue.arrayUnion(measurement),
          });
        } else {
          print("no measurement");
        }
      }
    }
    //else a new doc will get create
    else {
      if (measruringTypedropdownValue == "Fasting blood glucose") {
        if (int.parse(_measurementController.text) > 90 &&
            int.parse(_measurementController.text) < 140) {
          databaseReference
              .collection('patientsMeasurements')
              .document()
              .setData({
            'UserId': widget.currentUser.uid,
            'Date': getDateForTimeStamp(date),
            'Time': FieldValue.arrayUnion(timeStamp),
            'measruringTime': FieldValue.arrayUnion(measruringTime),
            'measurement': FieldValue.arrayUnion(measurement),
          });
        } else {
          print("no measurement");
        }
      } else if (measruringTypedropdownValue == "Post prandial blood glucose") {
        if (int.parse(_measurementController.text) > 140 &&
            int.parse(_measurementController.text) < 180) {
          databaseReference
              .collection('patientsMeasurements')
              .document()
              .setData({
            'UserId': widget.currentUser.uid,
            'Date': getDateForTimeStamp(date),
            'Time': FieldValue.arrayUnion(timeStamp),
            'measruringTime': FieldValue.arrayUnion(measruringTime),
            'measurement': FieldValue.arrayUnion(measurement),
          });
        } else {
          print("no measurement");
        }
      }
      print('da5al el else');
    }
    print(record['measruringTime'] + measruringTime);
    print(flag);
    print(getDate(date));
    print(timeStamp + measruringTime + measurement);
  }
}
