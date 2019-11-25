import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gp_project/Auth/login.dart';
import 'package:gp_project/Pages/Listdoctors.dart';
import '../Pages/homepage.dart';
import 'dart:async';
import '../util/auth.dart';
import '../models/doctor.dart';

class signup2 extends StatefulWidget {
  @override
  _signup2State createState() => _signup2State();
}

class _signup2State extends State<signup2> {
  ScrollController _scrollController = new ScrollController();
  String _name,
      _email,
      _password,
      _phone,
      _clinicno,
      _university,
      _address1,
      _address2;
  var items = [
    'Cairo',
    'Helwan',
    'AinShams',
    'Alexandria',
    'El-azhar',
    'Fayoum',
    'Aswan',
    'Asuit',
    'El-Menya',
    'ElMansoura',
    'Benha',
    'Tanta',
    'Souhag',
    'Suez',
    'Port Said',
    'Kafr Elshiekh',
    'El-Monofya'
  ];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _clininoController = new TextEditingController();
  TextEditingController _universityController = new TextEditingController();
  TextEditingController _address1Controller = new TextEditingController();
  TextEditingController _address2Controller = new TextEditingController();
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
        leading: Icon(Icons.dehaze, size: 30.0, color: Colors.white),
      ),
      body: Form(
        child: ListView(
          controller: _scrollController,
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
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 22.0, bottom: 5.0, right: 22.0, left: 22.0),
              child: TextFormField(
                controller: _emailController,
                autofocus: false,
                keyboardType: TextInputType.emailAddress,
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
                keyboardType: TextInputType.text,
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
              child: TextFormField(
                controller: _phoneController,
                autofocus: false,
                keyboardType: TextInputType.phone,
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
                  top: 22.0, bottom: 5.0, right: 22.0, left: 22.0),
              child: TextFormField(
                controller: _clininoController,
                autofocus: false,
                keyboardType: TextInputType.phone,
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please enter your clinic phone no.';
                  }
                },
                onSaved: (input) => _clinicno = input,
                decoration: InputDecoration(
                  labelText: 'Clinic phone number',
                  icon: Icon(Icons.home),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 22.0, bottom: 5.0, right: 22.0, left: 22.0),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: TextFormField(
                      controller: _universityController,
                      autofocus: false,
                      onSaved: (input) => _university = input,
                      decoration: InputDecoration(
                        labelText: 'University',
                        icon: Icon(Icons.account_balance),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  new PopupMenuButton<String>(
                    icon: const Icon(Icons.arrow_drop_down),
                    onSelected: (String value) {
                      _universityController.text = value;
                    },
                    itemBuilder: (BuildContext context) {
                      return items.map<PopupMenuItem<String>>((String value) {
                        return new PopupMenuItem(
                            child: new Text(value), value: value);
                      }).toList();
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 22.0, bottom: 5.0, right: 22.0, left: 22.0),
              child: TextFormField(
                controller: _address1Controller,
                autofocus: false,
                keyboardType: TextInputType.text,
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please enter your clinic address';
                  }
                },
                onSaved: (input) => _address1 = input,
                decoration: InputDecoration(
                  labelText: 'Clinic address',
                  icon: Icon(Icons.location_on),
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
                controller: _address2Controller,
                autofocus: false,
                onSaved: (input) => _address2 = input,
                decoration: InputDecoration(
                  labelText: 'Another Clinic address (optional)',
                  icon: Icon(Icons.add_location),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
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
              _emailSignUp2(
                name: _nameController.text,
                email: _emailController.text,
                password: _passwordController.text,
                phone: _phoneController.text,
                clinicno: _clininoController.text,
                university: _universityController.text,
                address1: _address1Controller.text,
                address2: _address2Controller.text,
                role: "doctor",
                context: context,
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => login()),
              );
            },
            child: Text('Register',
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

  void _emailSignUp2(
      {
      String name,
      String email,
      String password,
      String phone,
      String clinicno,
      String university,
      String address1,
      String address2,
      String role,
      BuildContext context
      }
      ) async {
    //if (_formKey.currentState.validate()) {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        await _changeLoadingVisible();
        //need await so it has chance to go through error if found.
        await Auth.signUp2(email, password).then(
          (id) {
            Auth.addUserSettingsDB2(
              new Doctor(
                dId: id,
                name: name,
                email: email,
                password: password,
                phone: phone,
                clinicno: clinicno,
                university: university,
                address1: address1,
                address2: address2,
                role: role,
              ),
            );
          },
        );
        await Navigator.pushNamed(context, '/login');
      } catch (e) {
        _changeLoadingVisible();
        print("Sign Up Error: $e");
      }
    }
    // else {
     // setState(() => _autoValidate = true);
  }
