import 'dart:async';
import '../models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/doctor.dart';

class UserClass {
  User userModel = new User();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;

  Future<void> getUserData() async {
    firebaseUser = await _firebaseAuth.currentUser();
    var userID = firebaseUser.uid;
    DocumentSnapshot result = await Firestore.instance
        .collection('users')
        .document(userID)
        .get()
        .then((snapshot) {
      setUserData(snapshot);
      print(userModel.name);
    });
    return result;
  }

  void setUserData(x) {
    print('in user class');
    userModel.name = x['name'];
    userModel.country = x['country'];
    userModel.city = x['city'];
    userModel.phone = x['phone'];
    userModel.birthday = x['birthday'];
    userModel.email = x['email'];
    userModel.gender = x['gender'];
  }

  User getCurrentUser() {
    this.getUserData();
    userModel.phone;
    return userModel;
  }

  //update profile
  Future<void> updateProfile(User user) async {
    print(user.email);
    firebaseUser = await _firebaseAuth.currentUser();
    var userID = firebaseUser.uid;
    Firestore.instance.collection('users').document(userID).updateData({
      'name': user.name,
      'phone': user.phone,
      'gender': user.gender,
      'country': user.country,
      'city': user.city,
      'height': user.height,
      'weight': user.weight,
      'birthday': user.birthday,
    });
  }

  Future<void> updateProfileDoctor(Doctor doctor) async {
    print(doctor.email);
    firebaseUser = await _firebaseAuth.currentUser();
    var userID = firebaseUser.uid;
    Firestore.instance.collection('users').document(userID).updateData({
      'name': doctor.name,
      'phone': doctor.phone,
      'clinicRegion': doctor.region,
      'address1': doctor.address1,
    });
  }
}
