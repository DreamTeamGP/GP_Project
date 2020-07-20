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
      _region,
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

  var loc = [
    'Cairo',
    'Helwan',
    'Elsayda zeinb',
    'Maadi',
    'El marg',
    'Dar elsalam',
    'Ein shams',
    'Masr eladema',
    'Madena masr',
    'El abasia',
    'Wst elbalad',
    'Masr elgdeda',
    'Garden city',
    '5th settlement',
    'Wst elbalad',
    'El mataria',
    'Shoubra',
    'Giza',
    'Elmohndseen',
    'Dokki',
    'Haram',
    'Faisal',
    'Elmonieb',
    'Elshikh zayed',
    '6 octobor',
    'Alexandria',
    'Roshdy',
    'Camp sheraz',
    'Abo keer',
    'Agamy',
    'Montazah',
    'Sedy beshr',
    'Myami',
    'Dakhalia',
    'Elmasoura',
    'Sherbeen',
    'El esmaielia',
    'El mania',
    'Port said',
    'Sohag',
    'Aswan',
    'Louxor',
  ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _clininoController = new TextEditingController();
  TextEditingController _universityController = new TextEditingController();
  TextEditingController _regionController = new TextEditingController();
  TextEditingController _address1Controller = new TextEditingController();
  TextEditingController _address2Controller = new TextEditingController();
  bool _autoValidate = false;
  bool _loadingVisible = false;
  @override
  void initState() {
    super.initState();
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

  String validateTele(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Telephone is Required";
    } else if (!value.startsWith('02')) {
      return "Telephone number must Start with 02";
    } else if (value.length != 11) {
      return "Telephone number must 11 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Telephone Number must be digits";
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
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          controller: _scrollController,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: 30.0, bottom: 5.0, right: 22.0, left: 22.0),
              child: TextFormField(
                controller: _nameController,
                autofocus: false,
                validator: validateName,
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
                validator: validateMobile,
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
                validator: validateTele,
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
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: TextFormField(
                      controller: _regionController,
                      autofocus: false,
                      onSaved: (input) => _region = input,
                      decoration: InputDecoration(
                        labelText: 'Clinic region',
                        icon: Icon(Icons.landscape),
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
                      _regionController.text = value;
                    },
                    itemBuilder: (BuildContext context) {
                      return loc.map<PopupMenuItem<String>>((String value) {
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
                region: _regionController.text,
                context: context,
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
      {String name,
      String email,
      String password,
      String phone,
      String clinicno,
      String university,
      String address1,
      String address2,
      String role,
      String region,
      BuildContext context}) async {
    if (_formKey.currentState.validate()) {
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
                region: region,
              ),
            );
          },
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => login()),
        );
        await Navigator.pushNamed(context, '/login');
      } catch (e) {
        _changeLoadingVisible();
        print("Sign Up Error: $e");
      }
    } else {
      setState(() => _autoValidate = true);
    }
  }
}
