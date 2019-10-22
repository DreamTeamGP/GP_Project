import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gp_project/Auth/login.dart';
import '../models/user.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/services.dart';
import 'package:gp_project/util/auth.dart';
import 'signUp1.dart';

class signUp2 extends StatefulWidget {
  final User user;
  signUp2({Key key, this.user}) : super(key: key);
  @override
  _signUp2State createState() => _signUp2State();
}

class _signUp2State extends State<signUp2> {
  ScrollController _scrollController = new ScrollController();
  int _gender = -1,
      correctScore = 0,
      _diabetesType = -1,
      _treatType = -1,
      _pressure = -1,
      _celostorol = -1,
      _heart = -1,
      _handnumb = -1;
  String _weight, _height;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void _handleRadioValueChange1(int value) {
    setState(() {
      _gender = value;

      switch (_gender) {
        case 0:
          correctScore++;
          break;
        case 1:
          correctScore++;
          break;
      }
    });
  }

  void _handleRadioValueChange2(int value) {
    setState(() {
      _diabetesType = value;

      switch (_diabetesType) {
        case 0:
          correctScore++;
          break;
        case 1:
          correctScore++;
          break;
        case 2:
          correctScore++;
          break;
      }
    });
  }

  void _handleRadioValueChange3(int value) {
    setState(() {
      _treatType = value;

      switch (_treatType) {
        case 0:
          correctScore++;
          break;
        case 1:
          correctScore++;
          break;
      }
    });
  }

  void _handleRadioValueChange4(int value) {
    setState(() {
      _pressure = value;

      switch (_pressure) {
        case 0:
          correctScore++;
          break;
        case 1:
          correctScore++;
          break;
        case 2:
          correctScore++;
          break;
      }
    });
  }

  void _handleRadioValueChange5(int value) {
    setState(() {
      _celostorol = value;

      switch (_celostorol) {
        case 0:
          correctScore++;
          break;
        case 1:
          correctScore++;
          break;
        case 2:
          correctScore++;
          break;
      }
    });
  }

  void _handleRadioValueChange6(int value) {
    setState(() {
      _heart = value;

      switch (_heart) {
        case 0:
          correctScore++;
          break;
        case 1:
          correctScore++;
          break;
      }
    });
  }

  void _handleRadioValueChange7(int value) {
    setState(() {
      _handnumb = value;

      switch (_handnumb) {
        case 0:
          correctScore++;
          break;
        case 1:
          correctScore++;
          break;
      }
    });
  }
  TextEditingController _genderController = new TextEditingController();
  TextEditingController _diabetesController = new TextEditingController();
  TextEditingController _weightController = new TextEditingController();
  TextEditingController _heightController = new TextEditingController();
  TextEditingController _pressureController = new TextEditingController();
  TextEditingController _treatController = new TextEditingController();
  TextEditingController _heartController = new TextEditingController();
  TextEditingController _handnumbController = new TextEditingController();    
  TextEditingController _celostorolController = new TextEditingController();


  bool _autoValidate = false;
  bool _loadingVisible = false;
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign up',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
          ),
        ),
        backgroundColor: Colors.cyan,
        leading: Icon(Icons.arrow_back_ios, size: 30.0, color: Colors.white),
      ),
      body: new Form(
        key: _formKey,
        child: ListView(
          controller: _scrollController,
          //padding: EdgeInsets.all(15),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 5.0, right: 40.0, left: 25.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Radio(
                      value: 0,
                      groupValue: _gender,
                      onChanged: _handleRadioValueChange1,
                    ),
                    new Text(
                      'Male',
                      style: new TextStyle(fontSize: 21),
                    ),
                    new Padding(
                      padding: new EdgeInsets.all(13),
                    ),
                    new Radio(
                      value: 1,
                      groupValue: _gender,
                      onChanged: _handleRadioValueChange1,
                    ),
                    new Text(
                      'Female',
                      style: new TextStyle(fontSize: 21),
                    ),
                  ]),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 10.0, bottom: 5.0, right: 40.0, left: 35.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'Please enter your Weight';
                        }
                      },
                      onSaved: (input) => _weight = input,
                      decoration: InputDecoration(
                        labelText: 'Weight',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 30,
                  ),
                  Expanded(
                    child: TextFormField(
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'Please enter your Height ';
                        }
                      },
                      onSaved: (input) => _height = input,
                      decoration: InputDecoration(
                        labelText: 'Height',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 5.0, right: 40.0, left: 35.0),
              child: Text('Diabetes Type',
                  style: new TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 22.0,
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 10.0, bottom: 5.0, right: 10.0, left: 23.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Radio(
                      value: 0,
                      groupValue: _diabetesType,
                      onChanged: _handleRadioValueChange2,
                    ),
                    new Text(
                      'Type 1',
                      style: new TextStyle(fontSize: 21),
                    ),
                    new Padding(
                      padding: new EdgeInsets.all(5),
                    ),
                    new Radio(
                      value: 1,
                      groupValue: _diabetesType,
                      onChanged: _handleRadioValueChange2,
                    ),
                    new Text(
                      'Type 2',
                      style: new TextStyle(fontSize: 21),
                    ),
                    new Padding(
                      padding: new EdgeInsets.all(5),
                    ),
                    new Radio(
                      value: 2,
                      groupValue: _diabetesType,
                      onChanged: _handleRadioValueChange2,
                    ),
                    new Text(
                      'Other',
                      style: new TextStyle(fontSize: 21),
                    ),
                  ]),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 5.0, right: 40.0, left: 35.0),
              child: Text('Treatment Type',
                  style: new TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 22.0,
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 10.0, bottom: 5.0, right: 10.0, left: 23.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Radio(
                      value: 0,
                      groupValue: _treatType,
                      onChanged: _handleRadioValueChange3,
                    ),
                    new Text(
                      'Pills',
                      style: new TextStyle(fontSize: 21),
                    ),
                    new Padding(
                      padding: new EdgeInsets.all(17),
                    ),
                    new Radio(
                      value: 1,
                      groupValue: _treatType,
                      onChanged: _handleRadioValueChange3,
                    ),
                    new Text(
                      'Insluin Injection',
                      style: new TextStyle(fontSize: 21),
                    ),
                  ]),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 5.0, right: 40.0, left: 35.0),
              child: Text(
                'Blood pressure',
                style: new TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 22.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 10.0, bottom: 5.0, right: 10.0, left: 23.0),
              child: Wrap(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Radio(
                    value: 0,
                    groupValue: _pressure,
                    onChanged: _handleRadioValueChange4,
                  ),
                  new Text(
                    'Hypotensive',
                    style: new TextStyle(fontSize: 21, height: 1.5),
                  ),
                  new Padding(
                    padding: new EdgeInsets.all(5),
                  ),
                  new Radio(
                    value: 1,
                    groupValue: _pressure,
                    onChanged: _handleRadioValueChange4,
                  ),
                  new Text(
                    'Hypertensive',
                    style: new TextStyle(fontSize: 21, height: 1.5),
                  ),
                  new Padding(
                    padding: new EdgeInsets.all(5),
                  ),
                  new Radio(
                    value: 2,
                    groupValue: _pressure,
                    onChanged: _handleRadioValueChange4,
                  ),
                  new Text(
                    'Normal',
                    style: new TextStyle(fontSize: 21, height: 1.5),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 5.0, right: 40.0, left: 35.0),
              child: Text(
                'Cholesterol',
                style: new TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 22.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 10.0, bottom: 5.0, right: 10.0, left: 23.0),
              child: Wrap(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Radio(
                    value: 0,
                    groupValue: _celostorol,
                    onChanged: _handleRadioValueChange5,
                  ),
                  new Text(
                    'Normal',
                    style: new TextStyle(fontSize: 21, height: 1.5),
                  ),
                  new Padding(
                    padding: new EdgeInsets.all(5),
                  ),
                  new Radio(
                    value: 1,
                    groupValue: _celostorol,
                    onChanged: _handleRadioValueChange5,
                  ),
                  new Text(
                    'Low',
                    style: new TextStyle(fontSize: 21, height: 1.5),
                  ),
                  new Padding(
                    padding: new EdgeInsets.all(5),
                  ),
                  new Radio(
                    value: 2,
                    groupValue: _celostorol,
                    onChanged: _handleRadioValueChange5,
                  ),
                  new Text(
                    'Normal',
                    style: new TextStyle(fontSize: 21, height: 1.5),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 5.0, right: 40.0, left: 35.0),
              child: Text('Heart Condtion',
                  style: new TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 22.0,
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 10.0, bottom: 5.0, right: 10.0, left: 23.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Radio(
                      value: 0,
                      groupValue: _heart,
                      onChanged: _handleRadioValueChange6,
                    ),
                    new Text(
                      'Normal',
                      style: new TextStyle(fontSize: 21),
                    ),
                    new Padding(
                      padding: new EdgeInsets.all(17),
                    ),
                    new Radio(
                      value: 1,
                      groupValue: _heart,
                      onChanged: _handleRadioValueChange6,
                    ),
                    new Text(
                      'Abnormal',
                      style: new TextStyle(fontSize: 21),
                    ),
                  ]),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 5.0, right: 60.0, left: 35.0),
              child: Text('Hand numbness',
                  style: new TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 22.0,
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 10.0, bottom: 5.0, right: 30.0, left: 23.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Radio(
                      value: 0,
                      groupValue: _handnumb,
                      onChanged: _handleRadioValueChange7,
                    ),
                    new Text(
                      'Yes',
                      style: new TextStyle(fontSize: 21),
                    ),
                    new Padding(
                      padding: new EdgeInsets.fromLTRB(0, 0, 75, 0),
                    ),
                    new Radio(
                      value: 1,
                      groupValue: _handnumb,
                      onChanged: _handleRadioValueChange7,
                    ),
                    new Text(
                      'No',
                      style: new TextStyle(fontSize: 21),
                    ),
                  ]),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 10.0, bottom: 5.0, right: 40.0, left: 35.0),
              child: Row(children: <Widget>[
                Expanded(
                  child: TextField(
                    maxLines: 6,
                    decoration: InputDecoration(
                      labelText: 'Further Information',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
      persistentFooterButtons: <Widget>[
        Padding(
          padding:
              EdgeInsets.only(top: 22.0, bottom: 5.0, right: 22.0, left: 22.0),
          child: RaisedButton(
            color: Colors.cyan,
            textColor: Colors.white,
            onPressed: (){
              _emailSignUp(
                gender: _gender,
                weight: _weight,
                height: _height,
                context: context,
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => login()),
              );
            },
            child: Text(
              'Finish',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal),
            ),
          ),
        ),
      ],
    );
  }
    Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  void _emailSignUp(
      {String name,
      String email,
      String password,
      String birthday,
      String country,
      String city,
      String phone,
      int gender,
      String weight,
      String height,
      int diabetes,
      int treat,
      int pressure,
      int celostorol,
      int heart,
      int handnumb,
      BuildContext context}) async {
    if (_formKey.currentState.validate()) {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        await _changeLoadingVisible();
        //need await so it has chance to go through error if found.
        await Auth.signUp(email, password).then((name) {
          Auth.addUserSettingsDB(new User(
            name: name,
            email: email,
            password: password,
            birthday: birthday,
            country: country,
            city: city,
            phone: phone,
            gender: gender,
            weight: weight,
            height: height,
            diabetesType: diabetes,
            treatType: treat,
            pressure: pressure,
            celostorol: celostorol,
            heart: heart,
            handnumb: handnumb

          ));
        });
        //now automatically login user too
        //await StateWidget.of(context).logInUser(email, password);
        await Navigator.pushNamed(context, '/signin');
      } catch (e) {
        _changeLoadingVisible();
        print("Sign Up Error: $e");
//        String exception = Auth.getExceptionText(e);
        Flushbar(
          title: "Sign Up Error",
          //     message: exception,
          duration: Duration(seconds: 5),
        )..show(context);
      }
    } else {
      setState(() => _autoValidate = true);
    }
  }
}
