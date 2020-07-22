import 'package:flutter/material.dart';
import 'package:gp_project/Auth/signup2.dart';
import '../Auth/signUp1.dart';

class choose extends StatefulWidget {
  @override
  _chooseState createState() => _chooseState();
}

class _chooseState extends State<choose> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign up as',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
          ),
        ),
        backgroundColor: Colors.cyan,
      ),
      body: SafeArea(
        //right: false,
        //left: false,
        child: Wrap(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: 230.0, bottom: 0.0, right: 30.0, left: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                    width: 80,
                  ),
                  ButtonTheme(
                    minWidth: 150,
                    child: RaisedButton(
                      padding: EdgeInsets.only(
                          top: 5, bottom: 5, right: 20, left: 20),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => signUp1()));
                      },
                      child: Text(
                        'as Patient',
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
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 230.0, bottom: 0.0, right: 30.0, left: 12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                    width: 80,
                  ),
                  ButtonTheme(
                    minWidth: 150,
                    child: RaisedButton(
                      padding: EdgeInsets.only(
                          top: 5, bottom: 5, right: 20, left: 20),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => signup2()));
                      },
                      child: Text(
                        'as Doctor',
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
