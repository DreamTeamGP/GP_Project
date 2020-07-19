import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gp_project/models/graph.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:flutter/rendering.dart';
import 'package:gp_project/pages/HomePage.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BarChartApplication extends StatefulWidget {
  const BarChartApplication({Key key, this.user}) : super(key: key);
  final FirebaseUser user;

  @override
  _BarChartApplication createState() => _BarChartApplication();
}

class ClicksPerYear {
  final String year;
  final double value;
  final charts.Color color;

  ClicksPerYear(this.year, this.value, Color color)
      : this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class _BarChartApplication extends State<BarChartApplication> {
  Graph graph = new Graph();

  Future _data;

  Future getMeasurements() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection("patientsMeasurements")
        .where('UserId', isEqualTo: widget.user.uid)
        .getDocuments();
    return qn.documents;
  }

  @override
  void initState() {
    super.initState();
    _data = getMeasurements();
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
              color: Colors.blue,
            ),
            Text(label)
          ],
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Graph',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
          ),
        ),
        backgroundColor: Colors.cyan,
        leading: new IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 30.0,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage(
                          user: widget.user,
                        )));
          },
        ),
      ),
      body: FutureBuilder(
        future: _data,
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
                if (arrayedValues[i].elementAt(j) == 'Fasting blood glucose') {
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
            return avgModified;
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
            return avgModified;
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
            ClicksPerYear('Fasting blood glucose', fastingValue(), Colors.cyan),
            ClicksPerYear('Post prandial blood glucose', postprandialValue(),
                Colors.cyan),
          ];

          var series = [
            charts.Series(
              domainFn: (ClicksPerYear clickData, _) => clickData.year,
              measureFn: (ClicksPerYear clickData, _) => clickData.value,
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
            padding: EdgeInsets.all(32.0),
            child: SizedBox(
              height: 200.0,
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
    );
  }
}
