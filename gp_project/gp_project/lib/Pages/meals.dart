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
//List<String> it = Firestore.instance.collection("FoodData").getDocuments() as List<String>;
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
  List<String> carb = List<String>();
  List<String> suger = List<String>();
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
                  StreamBuilder<QuerySnapshot>(
                      stream:
                          Firestore.instance.collection('FoodData').snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Text("Please wait.... ");
                        } else {
                          return new PopupMenuButton<String>(
                            icon: const Icon(Icons.arrow_drop_down),
                            onSelected: (String value) {
                              _foodController.text = value;
                            },
                            itemBuilder: (BuildContext context) {
                              return snapshot.data.documents
                                  .map<PopupMenuItem<String>>(
                                      (DocumentSnapshot value) {
                                return new PopupMenuItem(
                                  child: new Text(
                                      value.data["Shrt_Desc"].toString()),
                                  value: value.data['Shrt_Desc'],
                                );
                              }).toList();
                            },
                          );
                        }
                      }),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0.0, 00.0, 25.0, 0),
                      child: new TextFormField(
                        controller: _quantityController,
                        autofocus: false,
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'Please set the quantity in gm';
                          }
                        },
                        onChanged: (val) {
                          _quantity = val;
                        },
                        decoration: InputDecoration(
                          labelText: 'Quantity in gm',
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

  getDateForTimeStamp(DateTime inputVal) {
    String processedDate = inputVal.year.toString() +
        '-' +
        inputVal.month.toString() +
        '-' +
        inputVal.day.toString();
    return processedDate;
  }

  @override
  void initState() {
    // TODO: implement
    super.initState();
    _add();
  }

  void submitData() async {
    final FirebaseUser user = await _auth.currentUser();
    Firestore _firestore = new Firestore();
    final date = DateTime.now();
      try {
/*       for (int i = 0; food.length != 0; i++) {
        var doc = food[i];
        QuerySnapshot query = await Firestore.instance
            .collection('FoodData')
            .where('Shrt_Desc', isEqualTo: food[i])
            .getDocuments();
        DocumentSnapshot snapshot,snapshot2;
        snapshot.data['Carbohydrt_(g)'];
        snapshot2.data['Sugar_Tot_(g)'];
        carb.add(snapshot.data['Carbohydrt_(g)']);
        suger.add(snapshot2.data['Sugar_Tot_(g)']);
      } */

        Firestore.instance.collection('meals').document().setData({
          "food": FieldValue.arrayUnion(food),
          'quantity': FieldValue.arrayUnion(qtn),
          'carb': FieldValue.arrayUnion(carb),
          'suger': FieldValue.arrayUnion(suger),
          'Date': getDateForTimeStamp(date),
          'Timestamp': date,
          'UserID': user.uid,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          food.add(_foodController.text);
          qtn.add(_quantityController.text);
          var query = Firestore.instance
              .collection('FoodData')
              .where('Shrt_Desc', isEqualTo: _foodController.text)
              .getDocuments()
              .then((snapshot) {
            Map<dynamic, dynamic> values =
                snapshot.documents[0].data['Carbohydrt_(g)'];
            values.forEach((key, values) {
              print(values["Carbohydrt_(g)"]);
            });
          });
//                   DocumentSnapshot documentSnapshot = query.then((DocumentSnapshot snapshot){
//   Map<dynamic, dynamic> values = snapshot.value;
//      values.forEach((key,values) {
//       print(values["name"]);
//     });
//  });
          // var carbe = query.data['Carbohydrt_(g)'];
          // var sugere = query.data['Sugar_Tot_(g)'];
          // carb.add(carbe);
          // suger.add(sugere);
          // //print(food);
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
