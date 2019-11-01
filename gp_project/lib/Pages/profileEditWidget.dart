import 'package:flutter/material.dart';
import 'package:gp_project/Classes/User.dart';
import '../models/user.dart';
class profileEditWidget extends StatefulWidget {
  final User currentUser;
  @override
  _profileEditWidgetState createState() => _profileEditWidgetState();
  profileEditWidget({this.currentUser});
}

class _profileEditWidgetState extends State<profileEditWidget> {
  var userID;
  ScrollController _scrollController = new ScrollController();
  User _user = new User();
  UserClass userClass = new UserClass();
  final _formKey = GlobalKey<FormState>();

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
        leading: Icon(Icons.menu, color: Colors.white,),
      ),
      body: Form(
      key: _formKey,
      child: ListView(
        controller: _scrollController,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20.0),
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  color: Colors.red,
                  //image here
                  borderRadius: BorderRadius.all(Radius.circular(75.0)),
                ),
                
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextFormField(
              initialValue: widget.currentUser.name,
              
              style: TextStyle(
                fontSize: 18.0,
                
              ),
              
              onSaved: (input) => _user.name = input,
              decoration: InputDecoration(  
                //hintText: currentUser.name         
              ),
              
              validator: (value) {
                if (value.isEmpty) {
                  
                  _user.name = widget.currentUser.name;
                }
                return null;
              },
            ), 
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextFormField(
              initialValue: widget.currentUser.country,
              
              style: TextStyle(
                fontSize: 18.0,
              ),
              onSaved: (input) => _user.country = input,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.location_on, color: Colors.grey, size: 32.0,),
              ),  
              validator: (value) {
                if (value.isEmpty) {
                  _user.country = _user.country;
                }
                return null;
              },
            ), 
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextFormField(
              initialValue: widget.currentUser.phone,
              style: TextStyle(
                fontSize: 18.0,
              ),
              onSaved: (input) => _user.phone = input,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone, color: Colors.grey, size: 32.0,),
              ),
              
              validator: (value) {
                if (value.isEmpty) {
                  _user.phone = widget.currentUser.phone;
                }
                return null;
              },
            ), 
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextFormField(
              initialValue: widget.currentUser.email,
              style: TextStyle(
                fontSize: 18.0,
              ),
              onSaved: (input) => _user.email = input,
              decoration: InputDecoration(
                //contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                prefixIcon: Icon(Icons.mail, color: Colors.grey, size: 32.0,),                
              ),
              validator: (value) {
                if (value.isEmpty) {
                  _user.email = widget.currentUser.email;
                }
                return null;
              },
            ), 
          ),

          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextFormField(
              initialValue: widget.currentUser.birthday,
              style: TextStyle(
                fontSize: 18.0,
              ),
              onSaved: (input) => _user.birthday = input,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.calendar_today, color: Colors.grey, size: 32.0,),
                hintText: "05/05/1998",
              ),
              
              validator: (value) {
                if (value.isEmpty) {
                  _user.birthday = widget.currentUser.birthday;
                }
                return null;
              },
            ), 
          ),
          Padding(
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 5.0, right: 40.0, left: 25.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Radio(
                      value: 0,
                      groupValue: _user.gender,
                      onChanged: (value){
                        setState(() {
                        _user.gender = value;
                        });
                      },
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
                      groupValue: _user.gender,
                      onChanged: (value){
                        setState(() {
                        _user.gender = value;
                        });
                      },
                    ),
                    new Text(
                      'Female',
                      style: new TextStyle(fontSize: 21),
                    ),
                  ]),
            ),
          Container(

            padding: const EdgeInsets.all(0.10),
            
            child: RaisedButton(
              onPressed: (){
                if(_formKey.currentState.validate()){
                  _formKey.currentState.save();
                  
                }
                print('aaaaaaaaaaaaaaaaaa');
                  print(widget.currentUser.password);
                //_user.email = currentUser.email;
               this.userClass.updateProfile(_user);
              },
              child: Text('Submit'),
              color: Colors.blue,
              
            ),
          ),
        ],
      ),
    ),
    );
  }
}