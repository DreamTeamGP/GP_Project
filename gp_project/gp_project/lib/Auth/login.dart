import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gp_project/Auth/ResetPassword.dart';
import 'package:gp_project/Auth/line.dart';
import 'package:gp_project/Auth/signUp1.dart';

import 'package:gp_project/Classes/User.dart';
import 'package:gp_project/Home.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:gp_project/Pages/homepage.dart';
import 'package:gp_project/models/user.dart';
import 'choosesignup.dart';
import 'package:http/http.dart' as http;

final _userclass = UserClass();

class login extends StatefulWidget {
  //  final FirebaseUser currentUser;
  // const login({Key key, this.currentUser}) : super(key: key);
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  ScrollController _scrollController = new ScrollController();

  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  FacebookLogin fbLogin = new FacebookLogin();

  // get https => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
          ),
        ),
        backgroundColor: Colors.cyan,
        leading: Icon(Icons.first_page, size: 30.0, color: Colors.white),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          controller: _scrollController,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: 40.0, bottom: 0.0, right: 50.0, left: 22.0),
              child: TextFormField(
                validator: validateEmail,
                onSaved: (input) => _email = input,
                decoration: InputDecoration(
                  labelText: 'Email',
                  icon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 25.0, bottom: 5.0, right: 50.0, left: 22.0),
              child: TextFormField(
                validator: (input) {
                  if (input.length < 6) {
                    return 'Your password need to be at least 6 characters';
                  }
                },
                onSaved: (input) => _password = input,
                decoration: InputDecoration(
                  labelText: 'Password',
                  icon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                obscureText: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 0.0, bottom: 0.0, right: 50.0, left: 35.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                    width: 80,
                  ),
                  ButtonTheme(
                    minWidth: 170,
                    child: RaisedButton(
                      padding: EdgeInsets.only(
                          top: 5, bottom: 5, right: 20, left: 20),
                      onPressed: signIn,
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal),
                      ),
                      color: Colors.cyan,
                      textColor: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 0, bottom: 0),
                  ),
                  FlatButton(
                    textColor: Colors.grey,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResetPassword()));
                    },
                    child: Text('Forgot pasword?',
                        style: TextStyle(fontSize: 15.0)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(),
              child: Column(
                children: <Widget>[
                  CustomPaint(painter: Drawhorizontalline(false)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 150, top: 20),
              child: Row(
                children: <Widget>[
                  SignInButton(
                    Buttons.Facebook,
                    onPressed: loginWithFacebook,
                    //() {
                    //   fbLogin.isLoggedIn.
                    //   then((result){
                    //     switch(result.status){
                    //       case FacebookLoginStatus.loggedIn:
                    //       FirebaseAuth.instance.signInWithFacebook(
                    //         FacebookAccessToken : result.accessToken.token
                    //       ).then((signedInUser){
                    //         print('Sign in as ${signedInUser.displayName}');
                    //         Navigator.push(context, MaterialPageRoute(builder: (context)=> Home()));
                    //       }).catchError((e){
                    //         print(e);
                    //       });
                    //     }
                    //   }).catchError((e)
                    //   {print(e);}
                    //   )
                    //   ;
                    //},
                    mini: true,
                  ),
                  SignInButton(
                    Buttons.Google,
                    onPressed: signInWithGoogle,
                    mini: true,
                  )
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 40),
                child: Column(children: <Widget>[
                  Row(
                    children: <Widget>[
                      CustomPaint(painter: Drawhorizontallinee(false)),
                      Padding(
                        padding: EdgeInsets.only(left: 130),
                        // textColor: Colors.grey,
                        // onPressed: () {
                        //   Navigator.push(context,
                        //       MaterialPageRoute(builder: (context) => choose()));
                        // },
                        child: Text(
                          'Dont have Account?',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      CustomPaint(painter: Drawhorizontallineee(false)),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                    width: 80,
                  ),
                  ButtonTheme(
                    padding: EdgeInsets.only(
                        top: 15, bottom: 5, right: 20, left: 20),
                    minWidth: 170,
                    child: RaisedButton(
                      padding: EdgeInsets.only(
                          top: 5, bottom: 5, right: 20, left: 20),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => choose()));
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal),
                      ),
                      color: Colors.cyan,
                      textColor: Colors.white,
                    ),
                  ),
                ])),
          ],
        ),
      ),
    );
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

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text("Your Email or Password are incorrect"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> signIn() async {
    final FormState = _formKey.currentState;

    if (FormState.validate()) {
      FormState.save();
      try {
        AuthResult user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        if (user.user != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(user: user.user)));
        }
      } catch (e) {
        _showDialog();
        print(e.message);
      }
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  bool isLoggedIn = false;

  void onLoginStatusChanged(bool isLoggedIn) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
    });
  }

  Future<void> loginWithFacebook() async {
    User _use = User();
    //FirebaseUser user = await _firebaseAuth.currentUser();
    try {
      var facebookLogin = new FacebookLogin();
      var result = await facebookLogin.logIn(['email']);
      var accessToken = result.accessToken;

      if (result.status == FacebookLoginStatus.loggedIn) {
        final AuthCredential credential = FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token,
        );
        AuthResult user =
            (await FirebaseAuth.instance.signInWithCredential(credential));

        print('signed in ' + user.user.displayName);

        // Firestore.instance.collection("users").document().setData({
        //   "name": user.user.displayName,
        //   "email": user.user.email,
        //   "id": user.user.uid
        // }

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomePage(user: user.user)));
        return user;
      }
      if (FacebookLoginStatus.loggedIn != null) {
        print("LoggedIn! ");

        // var graphResponse = await http.get(
        //     'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${accessToken.token}');
        // var profile = jsonDecode(graphResponse.body);
        // print(profile.toString());

        // onLoginStatusChanged(true);
      }
    } catch (e) {
      print(e.message);
    }
    //Navigator.push(context, MaterialPageRoute(builder: (context)=> Home()));
  }

  Firestore firestore = Firestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  user: user,
                )));
    return 'signInWithGoogle succeeded: $user';
  }

  Future sendPasswordResetEmail(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }
}

class UserDetails {
  final String providerDetails;
  final String username;
  final String photoURL;
  final String userEmail;
  final List<ProviderDetails> providerData;
  UserDetails(this.providerDetails, this.username, this.photoURL,
      this.userEmail, this.providerData);
}

class ProviderDetails {
  ProviderDetails(this.providerDetails);
  final String providerDetails;
}
