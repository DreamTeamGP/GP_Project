import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/services.dart';
import 'package:gp_project/Pages/homepage.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gp_project/util/auth.dart';
import '../models/user.dart';
import 'login.dart';

class signUp1 extends StatefulWidget {
  final User user;
  signUp1({Key key, this.user}) : super(key: key);

  @override
  _signUp1State createState() => _signUp1State();
}

class _signUp1State extends State<signUp1> {
  ScrollController _scrollController = new ScrollController();
  String _email, _password, _name, _phone, _country, _city, _birthday;
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
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _birthdayController = new TextEditingController();
  TextEditingController _countryController = new TextEditingController();
  TextEditingController _cityController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _weightController = new TextEditingController();
  TextEditingController _heightController = new TextEditingController();
  TextEditingController _genderController = new TextEditingController();
  TextEditingController _diabetesController = new TextEditingController();
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

  Future _chooseDate(BuildContext context, String initialDateString) async {
    var now = new DateTime.now();
    var initialDate = convertToDate(initialDateString) ?? now;
    initialDate = (initialDate.year >= 1900 && initialDate.isBefore(now)
        ? initialDate
        : now);

    var result = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: new DateTime(1900),
        lastDate: new DateTime.now());

    if (result == null) return;

    setState(() {
      _birthdayController.text = new DateFormat.yMd().format(result);
    });
  }

  DateTime convertToDate(String input) {
    try {
      var d = new DateFormat.yMd().parseStrict(input);
      return d;
    } catch (e) {
      return null;
    }
  }

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
        leading: Icon(Icons.dehaze, size: 30.0, color: Colors.white),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          controller: _scrollController,
          //padding: EdgeInsets.all(5.0),
          // crossAxisAlignment:CrossAxisAlignment.end,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: 30.0, bottom: 5.0, right: 22.0, left: 22.0),
              child: TextFormField(
                controller: _nameController,
                autofocus: false,
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please type your name';
                  }
                },
                onSaved: (input) => _name = input,
                decoration: InputDecoration(
                  labelText: 'Name',
                  icon: Icon(Icons.perm_identity),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 22.0, bottom: 5.0, right: 22.0, left: 22.0),
              child: TextFormField(
                controller: _emailController,
                autofocus: false,
                validator: (input) {
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
                  top: 22.0, bottom: 5.0, right: 22.0, left: 22.0),
              child: TextFormField(
                controller: _passwordController,
                autofocus: false,
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
                  top: 22.0, bottom: 5.0, right: 22.0, left: 22.0),
              child: Row(
                children: <Widget>[
                  new Expanded(
                    child: TextFormField(
                      controller: _birthdayController,
                      autofocus: false,
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'Please enter your birthday';
                        }
                      },
                      onSaved: (input) => _birthday = input,
                      decoration: InputDecoration(
                        labelText: 'Birthday',
                        icon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                  new IconButton(
                    icon: new Icon(Icons.more_horiz),
                    tooltip: 'Choose date',
                    onPressed: (() {
                      _chooseDate(context, _birthdayController.text);
                    }),
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                    top: 22.0, bottom: 5.0, right: 22.0, left: 22.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: _countryController,
                        autofocus: false,
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'Please enter your country';
                          }
                        },
                        onSaved: (input) => _country = input,
                        decoration: InputDecoration(
                          labelText: 'Country',
                          icon: Icon(Icons.pin_drop),
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
                        controller: _cityController,
                        autofocus: false,
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'Please enter your city ';
                          }
                        },
                        onSaved: (input) => _city = input,
                        decoration: InputDecoration(
                          labelText: 'City',
                          //icon: Icon(Icons.calendar_today),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            Padding(
              padding: EdgeInsets.only(
                  top: 22.0, bottom: 5.0, right: 22.0, left: 22.0),
              child: TextFormField(
                controller: _phoneController,
                autofocus: false,
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please enter your phone';
                  }
                },
                onSaved: (input) => _phone = input,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  icon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 5.0, right: 40.0, left: 35.0),
              child: Text('Gender',
                  style: new TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 22.0,
                  )),
            ),
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
                      controller: _weightController,
                      autofocus: false,
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
                      controller: _heightController,
                      autofocus: false,
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
                    'High',
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
            onPressed: () {
              _emailSignUp(
                name: _nameController.text,
                email: _emailController.text,
                password: _passwordController.text,
                birthday: _birthdayController.text,
                country: _countryController.text,
                city: _cityController.text,
                phone: _phoneController.text,
                gender: _gender,
                weight: _weightController.text,
                height: _heightController.text,
                diabetes: _diabetesType,
                treat: _treatType,
                pressure: _pressure,
                celostorol: _celostorol,
                heart: _heart,
                handnumb: _handnumb,
                role: "patient",
                context: context,
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => login()),
              );
            },
            child: Text('Finish',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                )),
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
      String role,
      BuildContext context}) async {
    if (_formKey.currentState.validate()) {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        await _changeLoadingVisible();
        //need await so it has chance to go through error if found.
        await Auth.signUp(email, password).then((uId) {
          Auth.addUserSettingsDB(
            new User(
              uId: uId,
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
              handnumb: handnumb,
              role: role,
            ),
          );
        });
        //now automatically login user too
        //await StateWidget.of(context).logInUser(email, password);
        await Navigator.pushNamed(context, '/signin');
      } catch (e) {
        _changeLoadingVisible();
        print("Sign Up Error: $e");
//        String exception = Auth.getExceptionText(e);
        // Flushbar(
        //   title: "Sign Up Error",
        //   //     message: exception,
        //   duration: Duration(seconds: 5),
        // )..show(context);
      }
    } else {
      setState(() => _autoValidate = true);
    }
  }
/*   void signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => login()));
      } catch (e) {
        print(e.message);
      }
    }
  } */
}
