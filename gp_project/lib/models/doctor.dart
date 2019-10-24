import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

Doctor doctorFromJson(String str) {
  final jsonData = json.decode(str);
  return Doctor.fromJson(jsonData);
}

String doctorToJson(Doctor data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Doctor {
  String dId;
  String name;
  String email;
  String password;
  String phone;
  String clinicno;
  String university;
  String address1;
  String address2;
  String role;

  Doctor({
    this.dId,
    this.name,
    this.email,
    this.password,
    this.phone,
    this.clinicno,
    this.university,
    this.address1,
    this.address2,
    this.role,
  });

  Map<String, dynamic> toJson() => {
        "id": dId,
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "clinicno.": clinicno,
        "university": university,
        "address1": address1,
        "address2": address2,
        "role": 'doctor',
      };
  factory Doctor.fromJson(Map<String, dynamic> json) => new Doctor(
        dId: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        clinicno: json["clinicno."],
        university: json["university"],
        address1: json["address1"],
        address2: json["address2"],
        role: json["doctor"],
      );
  factory Doctor.fromDocument(DocumentSnapshot doc) {
    return Doctor.fromJson(doc.data);
  }
}
