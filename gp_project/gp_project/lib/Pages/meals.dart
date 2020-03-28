import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp_project/Pages/profiledrawer.dart';
import 'package:gp_project/models/user.dart';
import 'homepage.dart';

class meals extends StatefulWidget {
  final FirebaseUser currentUser;
  final User user;
  meals({Key key, this.currentUser, this.user}) : super(key: key);
  @override
  _mealsState createState() => _mealsState();
}

class _mealsState extends State<meals> {
Future<QuerySnapshot> list =Firestore.instance.collection("FoddData").getDocuments();
  var items = [
    'Rice',
    'Fish',
    'Makarona',
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
  final _formKey = GlobalKey<FormState>();

  TextEditingController _foodController;
  TextEditingController _quantityController;
  List<String> food = List<String>(), qtn = List<String>();
  String _quantity, _food;
  Map<String, String> _formdata = {};
  var _myPets = List<Widget>();
  int _index = 1;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  void _add() {
    _foodController = new TextEditingController();
    _quantityController = new TextEditingController();
    int keyValue = _index;
    _myPets = List.from(_myPets)
      ..add(
        Column(
          key: Key("${keyValue}"),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 10.0),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: TextFormField(
                      style: TextStyle(
                        height: 1.0,
                      ),
                      controller: _foodController,
                      autofocus: false,
                      onChanged: (val) => _food = val,
                      decoration: InputDecoration(
                        labelText: 'Choose your food',
                        icon: Icon(Icons.fastfood),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      enableSuggestions: true,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  new PopupMenuButton<String>(
                    
                    icon: const Icon(Icons.arrow_drop_down),
                    onSelected: (String value) {
                      _foodController.text = value;
                    },
                    itemBuilder: (BuildContext context) {
                      return items.map<PopupMenuItem<String>>((String value) {
                        return new PopupMenuItem(
                            child: new Text(value), value: value);
                      }).toList();
                    },
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0.0, 00.0, 25.0, 0),
                      child: new TextFormField(
                        controller: _quantityController,
                        autofocus: false,
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'Please set the quantity';
                          }
                        },
                        onChanged: (val) {
                          _quantity = val;
                        },
                        decoration: InputDecoration(
                          labelText: 'Quantity',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    setState(() {
      _index++;
    });
  }

  @override
  void initState() {
    // TODO: implement
    super.initState();
    _add();
  }

  getDateForTimetamp(DateTime inputVal) {
    String processedDate = inputVal.year.toString() +
        '-' +
        inputVal.month.toString() +
        '-' +
        inputVal.day.toString();
    return processedDate;
  }

  

  void submitData() async {

    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day, now.hour, now.minute);

    final FirebaseUser user = await _auth.currentUser();
    Firestore _firestore = new Firestore();
    try {
      Firestore.instance.collection('meals').document().setData({
        "food": FieldValue.arrayUnion(food),
        'quantity': FieldValue.arrayUnion(qtn),
        'Date': DateTime.now(),
        'UserID' : user.uid,
        'Timestamp': getDateForTimetamp(date),
      });
      //Firestore.instance.collection('meals').document().setData(
      //  {'Food': _foodController.text, 'quantity': _quantityController.text});
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            user: widget.currentUser,
          ),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ProfileDrawer(currentUser: widget.currentUser),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          food.add(_foodController.text);
          qtn.add(_quantityController.text);
          //print(food);
          //print(qtn);
          submitData();
        },
        child: Text('Save'),
      ),
      appBar: AppBar(
        title: Text(
          'Add Your Meals',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        backgroundColor: Colors.cyan,
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.add),
            onPressed: () {
              food.add(_foodController.text);
              qtn.add(_quantityController.text);
              print(food);
              print(qtn);
              _add();
            },
            iconSize: 30,
            color: Colors.white,
          ),
        ],
      ),
      body: ListView(
        children: _myPets,
      ),
    );
  }
}
