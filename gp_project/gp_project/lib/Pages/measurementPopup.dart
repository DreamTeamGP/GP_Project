import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MeasurementPopUp extends StatefulWidget {
  @override
  _MeasurementPopUp createState() => _MeasurementPopUp();
}

class _MeasurementPopUp extends State<MeasurementPopUp> {
  final _formKey = GlobalKey<FormState>();
  

  String measruringTimedropdownValue = 'Fasting blood glucose';
  List<String> measurementType = [
    'Fasting blood glucose',
    'Post prandial blood glucose'
  ];

  final measurementController = TextEditingController();
  
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
              value: measruringTimedropdownValue,
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
                  measruringTimedropdownValue = newValue;
                });
              },
              isExpanded: false,
            ),
            Container(
              padding: EdgeInsets.all(5.0),
              child: TextFormField(
                controller: measurementController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'please input a number';
                  }
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
                      measurementRecord(); //records new measurement into db
                      Navigator.pop(context); //closes popup
                      measurementController.clear(); //clears textfield
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

  measurementRecord() {
    Firestore.instance
        .collection('patientRecord')
        .document()
        .setData({'measurement': measurementController.text,
                  'measruringTime': measruringTimedropdownValue});
  }
}
