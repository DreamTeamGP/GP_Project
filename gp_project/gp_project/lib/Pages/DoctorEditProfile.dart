import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gp_project/Classes/User.dart';
import 'package:gp_project/Pages/profileWidget.dart';
import 'package:image_picker/image_picker.dart';
import '../models/user.dart';
import 'DoctorProfile.dart';
import '../models/doctor.dart';

class DoctorEditProfile extends StatefulWidget {
  final FirebaseUser currentUser;
  @override
  _DoctorEditProfileState createState() => _DoctorEditProfileState();
  DoctorEditProfile({this.currentUser});
}

class _DoctorEditProfileState extends State<DoctorEditProfile> {
  Future<File> imageFile;
  File _image;
  String _uploadedFileURL;

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile =
          ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
        setState(() {
          _image = image;
        });
      });
    });
  }

  var userID;
  ScrollController _scrollController = new ScrollController();
  Doctor _user = new Doctor();
  UserClass userClass = new UserClass();
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection("users")
              .document(widget.currentUser.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: ListView(
                  controller: _scrollController,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // snapshot.data['gender'] == 1
                        //     ? Container(
                        //         margin: EdgeInsets.only(top: 20.0),
                        //         width: 100,
                        //         height: 100,
                        //         decoration: BoxDecoration(
                        //           //color: Colors.blue,
                        //           //image here

                        //           image: DecorationImage(
                        //             image: AssetImage('icons/Womanuser.png'),
                        //             fit: BoxFit.fill,
                        //           ),
                        //           shape: BoxShape.circle,
                        //           //borderRadius: BorderRadius.all(Radius.circular(75.0)),
                        //         ),
                        //       )
                        //     : Container(
                        //         margin: EdgeInsets.only(top: 20.0),
                        //         width: 100,
                        //         height: 100,
                        //         decoration: BoxDecoration(
                        //           //color: Colors.blue,
                        //           //image here
                        //           image: DecorationImage(
                        //             image: AssetImage('icons/user.jpg'),
                        //             fit: BoxFit.fill,
                        //           ),
                        //           shape: BoxShape.circle,
                        //           //borderRadius: BorderRadius.all(Radius.circular(75.0)),
                        //         ),
                        //       ),

                        _image != null
                            ? Container(
                                child: Image.asset(
                                  _image.path,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.fill,
                                ),
                              )
                            : Container(
                                width: 100,
                                height: 100,
                              ),
                        _image == null
                            ? RaisedButton(
                                child: Text(
                                  "Change photo",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 23),
                                ),
                                color: Colors.blue,
                                onPressed: () {
                                  pickImageFromGallery(ImageSource.gallery);
                                },
                              )
                            : Container(),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          initialValue: '${snapshot.data['name']}',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                          onSaved: (input) => _user.name = input,
                          decoration: InputDecoration(
                              //hintText: currentUser.name
                              ),
                          validator: validateName),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          initialValue: '${snapshot.data['clinicRegion']}',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                          onSaved: (input) => _user.region = input,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: Colors.grey,
                              size: 32.0,
                            ),
                          ),
                          validator: validateCountry),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          initialValue: '${snapshot.data['phone']}',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                          onSaved: (input) => _user.phone = input,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.grey,
                              size: 32.0,
                            ),
                          ),
                          validator: validateMobile),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        initialValue: '${snapshot.data['address1']}',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                        onSaved: (input) => _user.address1 = input,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.location_on,
                            color: Colors.grey,
                            size: 32.0,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(0.10),
                      child: RaisedButton(
                        onPressed: _validateInputs2,
                        child: Text('Submit'),
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              );
            }
            return LinearProgressIndicator();
          }),
    );
  }

  String validateName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

  String validateCountry(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Country is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Country must be a-z and A-Z";
    }
    return null;
  }

  String validateCity(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Country is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Country must be a-z and A-Z";
    }
    return null;
  }

  String validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Mobile is Required";
    } else if (value.length != 11) {
      return "Mobile number must 11 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
  }

  String validateWeight(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Weight is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Weight Number must be digits";
    }
    return null;
  }

  String validateHeight(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Height is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Height Number must be digits";
    }
    return null;
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
      this.userClass.updateProfileDoctor(_user);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => profileWidget(
                    currentUser: widget.currentUser,
                  )));
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  Future ImageUpload() async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('${(_image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
      });
    });
    StorageTaskSnapshot snapshot =
        await storage.ref().child("${_image.path}").putFile(_image).onComplete;
    FirebaseUser firebaseUser;
    //var userID = firebaseUser.uid;

    final String downloadUrl = await snapshot.ref.getDownloadURL();
    //await Firestore.instance.collection("users").add({"photo": downloadUrl});
    await Firestore.instance
        .collection("users")
        .document(widget.currentUser.uid)
        .updateData({'photo': downloadUrl});

    return downloadUrl;
  }

  var storage = FirebaseStorage.instance;
  Future<void> _validateInputs2() async {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
      ImageUpload();

      this.userClass.updateProfileDoctor(_user);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DoctorProfile(
                    currentUser: widget.currentUser,
                  )));
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
