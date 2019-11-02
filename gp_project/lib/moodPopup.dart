import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MoodPopUp extends StatefulWidget {
  @override
  _MoodPopUp createState() => _MoodPopUp();
}

class _MoodPopUp extends State<MoodPopUp> {
  final _formKey = GlobalKey<FormState>();
  String moodDropdownValue = 'Dizziness';
  List<String> moods = [
    'Dizziness',
    'Sweating',
    'Lack of concentration',
    'Blackout',
    'Sense of low',
    'Thirstiness',
    'Too much urine'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: 230.0,
      height: 110.0,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DropdownButton<String>(
              value: moodDropdownValue,
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
              items: moods.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String newValue) {
                setState(() {
                  moodDropdownValue = newValue;
                });
              },
              isExpanded: false,
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
                      moodRecord(); //records new measurement into db
                      Navigator.pop(context); //closes popup
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  moodRecord() {
    Firestore.instance
        .collection('patientRecord')
        .document()
        .setData({'mood': moodDropdownValue});
  }
}
