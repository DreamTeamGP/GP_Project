import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

User userFromJson(String str) {
  final jsonData = json.decode(str);
  return User.fromJson(jsonData);
}

String userToJson(User data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class User {
  String uId;
  String name;
  String email;
  String password;
  String birthday;
  String country;
  String city;
  String phone;
  int gender;
  String weight;
  String height;
  int diabetesType;
  int treatType;
  int pressure;
  int celostorol;
  int heart;
  int handnumb;
  String role;
  File photo;
  String doctorId;

  User(
      {this.uId,
      this.name,
      this.email,
      this.password,
      this.birthday,
      this.country,
      this.city,
      this.phone,
      this.gender,
      this.weight,
      this.height,
      this.diabetesType,
      this.treatType,
      this.pressure,
      this.celostorol,
      this.heart,
      this.handnumb,
      this.role,
      this.photo,
      this.doctorId});

  Map<String, dynamic> toJson() => {
        "id": uId,
        "name": name,
        "email": email,
        "password": password,
        "birthday": birthday,
        "country": country,
        "city": city,
        "phone": phone,
        "gender": gender,
        "weight": weight,
        "height": height,
        "diabetesType": diabetesType,
        "treatType": treatType,
        "pressure": pressure,
        "celostorol": celostorol,
        "heart": heart,
        "handnumb": handnumb,
        "photo": photo,
        "doctorId": doctorId,
        "role": 'patient',
      };
  factory User.fromJson(Map<String, dynamic> json) => new User(
        uId: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        birthday: json["birthday"],
        country: json["country"],
        city: json["city"],
        phone: json["phone"],
        gender: json["gender"],
        weight: json["weight"],
        height: json["height"],
        diabetesType: json["diabetesType"],
        treatType: json["treatType"],
        pressure: json["pressure"],
        celostorol: json["celostorol"],
        heart: json["heart"],
        handnumb: json["handnumb"],
        photo: json["photo"],
        doctorId: json["doctorId"],
        role: json["patient"],
      );
  factory User.fromDocument(DocumentSnapshot doc) {
    return User.fromJson(doc.data);
  }
  
}
