import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

contactUs contactFromJson(String str) {
  final jsonData = json.decode(str);
  return contactUs.fromJson(jsonData);
}

String userToJson(contactUs data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class contactUs{
  String id ;
  String message;

  contactUs({this.id , this.message});

   Map<String, dynamic> toJson() => { 
     "id": id,
     "message" : message,
   }; 
  
  factory contactUs.fromJson(Map<String, dynamic> json) => new contactUs(
    id: json["id"],
    message: json["message"]
  );

  factory contactUs.fromDocument(DocumentSnapshot doc) {
    return contactUs.fromJson(doc.data);
  }

}