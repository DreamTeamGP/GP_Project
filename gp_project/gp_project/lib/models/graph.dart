// // import 'package:cloud_firestore/cloud_firestore.dart';

// // class Graph {
// //   getRecord(String userId, String date) {
// //     return Firestore.instance
// //         .collection('patientsMeasurements')
// //         .where('UserId', isEqualTo: userId)
// //         .where('Date', isEqualTo: date)
// //         .getDocuments();
// //   }
// // }

import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

Graph dataFromJson(String str) {
  final jsonData = json.decode(str);
  return Graph.fromJson(jsonData);
}

String dataToJson(Graph data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Graph {
  String date;
  String time;
  String userId;
  String measruringTime;
  String measurement;

  Graph({
    this.date,
    this.time,
    this.userId,
    this.measruringTime,
    this.measurement,
  });
  Map<String, dynamic> toJson() => {
        "Date": date,
        "Time": time,
        "UserId": userId,
        "measruringTime": measruringTime,
        "measurement": measurement,
      };
  factory Graph.fromJson(Map<String, dynamic> json) => new Graph(
        date: json["Date"],
        time: json["Time"],
        userId: json["UserId"],
        measruringTime: json["measruringTime"],
        measurement: json["measurement"],
      );
  factory Graph.fromDocument(DocumentSnapshot doc) {
    return Graph.fromJson(doc.data);
  }
}

// class DoctorList {
//   List<Graph> doctorList;

//   DoctorList({this.doctorList});
// }
