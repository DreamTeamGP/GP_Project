import 'package:cloud_firestore/cloud_firestore.dart';

class Measurement {
  getRecord(String userId, String date, String value) {
    return Firestore.instance
    .collection('patientsMeasurements')
    .where('UserId', isEqualTo: userId)
    .where('Date', isEqualTo: date)
    .where('measruringTime', arrayContains: value)
    .getDocuments();
  }
}