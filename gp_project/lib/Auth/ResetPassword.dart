import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp_project/Pages/homepage.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

//enum DataType {_email}

class _ResetPasswordState extends State<ResetPassword> {

  ScrollController _scrollController = new ScrollController();

  String _email;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Reset Password',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
              ),
            ),
            backgroundColor: Colors.cyan,
            //leading: Icon(Icons.dehaze, size: 30.0, color: Colors.white),
          ),
          
          body: Form(
            key: _formKey,
            child: ListView(
              controller: _scrollController,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only( top: 40.0, bottom: 0.0, right: 25.0, left: 20.0),
                  child: TextFormField(
                    validator: (input){
                      if (input.isEmpty) {
                        return 'Please type email';
                      }
                    },
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
                      top: 0.0, bottom: 0.0, right: 50.0, left: 60.0),
                  child: Column( mainAxisSize: MainAxisSize.min,
                   
                    children: <Widget>[
                      const SizedBox(
                        height: 30,
                        width: 80,
                      ),
                      ButtonTheme(
                        minWidth: 170,
                        child: RaisedButton(
                          padding: EdgeInsets.only( top: 5, bottom: 5, right: 20, left: 20),
                          onPressed: resetPassword,

                      child: Text( 'Submit',
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
              )
            ),
          ],
        ),
      ),
    );
          
  }
   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    
  Future<void> resetPassword() async {
    final FormState = _formKey.currentState;

      if (FormState.validate()){
        FormState.save();
      }
    try{
      await _firebaseAuth.sendPasswordResetEmail(email: _email);
      Navigator.push(context , MaterialPageRoute(builder: (context)=> HomePage()));
    }
    catch(e){
      print(e);
    }
}
}