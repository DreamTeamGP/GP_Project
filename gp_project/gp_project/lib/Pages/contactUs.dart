import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp_project/Pages/homepage.dart';
import 'package:gp_project/Pages/profileWidget.dart';
import 'profiledrawer.dart';

//import 'package:gp_project/util/CRUD.dart';

class contactUs extends StatefulWidget {
  final FirebaseUser user;
  const contactUs({Key key, this.user}) : super(key: key);

  @override
  _contactUsState createState() => _contactUsState();
}

class _contactUsState extends State<contactUs> {
  ScrollController _scrollController = new ScrollController();
  final _messageController = new TextEditingController();

  //crudMedthods crudObj = new crudMedthods();

  //String _email;
  String _message;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact Us',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
          ),
        ),
        backgroundColor: Colors.cyan,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          controller: _scrollController,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: 30.0, bottom: 5.0, right: 30.0, left: 25.0),
              child: Row(children: <Widget>[
                Expanded(
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your meassage first';
                      }
                    },
                    controller: _messageController,
                    onSaved: (input) => _message = input,
                    maxLines: 20,
                    decoration: InputDecoration(
                      //labelText: 'Enter Inquery',
                      hintText: 'Please leave your message here',

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            Padding(
                padding: EdgeInsets.only(
                    top: 0.0, bottom: 0.0, right: 50.0, left: 60.0),
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
                        onPressed: sendMessage,
                        child: Text(
                          'Send',
                          style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal),
                        ),
                        color: Colors.cyan,
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

  void sendMessage() async {
    final FirebaseUser user = await _auth.currentUser();
    Firestore _firestore = new Firestore();
    if (_formKey.currentState.validate()) {
      try {
        Firestore.instance
            .collection('contactUs')
            .document()
            .setData({'Message': _messageController.text, 'Email': user.email});
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(
                      user: widget.user,
                    )));
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Message Sent')));
      } catch (e) {
        print(e);
      }
    }
  }
}
