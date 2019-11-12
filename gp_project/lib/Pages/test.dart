import 'package:flutter/material.dart';
import 'package:gp_project/Pages/profileEditWidget.dart';
import '../models/user.dart';
class test extends StatefulWidget {
  @override
  _testState createState() => _testState();
}

class _testState extends State<test> {
  final formKey = GlobalKey<FormState>();
  User user = new User(name: 'roro', email: 'roro@g.com');
  String _email, _password;
   TextEditingController _quoteController;
  TextEditingController _authorController;
  EditQuoteFormState() {
    _quoteController = TextEditingController(text:' _quote.quote');
    _authorController = TextEditingController(text: '_quote.author');
  }
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: Text('form'),
        
      ),
      body: Card(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _quoteController,
                decoration: InputDecoration(
                  labelText: 'email',
                ) ,
                validator: (input)=>input.length<8? 'error': null,
                onSaved: (input) => _email = input,
              ),
              TextFormField(
                controller: _authorController,
                decoration: InputDecoration(
                  labelText: 'pass',
                ) ,
                validator: (input)=>input.length<8? 'error': null,
                onSaved: (input) => _password = input,
              ),
              Container(
                child: RaisedButton(
                  child: Text('print'),
                  onPressed: (){           
            //Navigator.push(context, MaterialPageRoute(builder: (context)=> profileEditWidget(u1: user,)));
          },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  void submit(){
    if(formKey.currentState.validate()){
      formKey.currentState.save();
      print(_email);
      print(_password);
    }
  }
}