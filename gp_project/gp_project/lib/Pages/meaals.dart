import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:gp_project/Auth/provider.dart';
import 'package:gp_project/Pages/homepage.dart';
import 'package:gp_project/Pages/profiledrawer.dart';
import 'package:gp_project/models/user.dart';
//import 'package:provider/provider.dart';
//GlobalKey<_DynamicWidgetState> globalKey = GlobalKey();

class meeals extends StatefulWidget {
  final FirebaseUser currentUser;
  final User user;
  meeals({Key key, this.currentUser, this.user}) : super(key: key);
  @override
  _meealsState createState() => _meealsState();
}

class _meealsState extends State<meeals> {
  List listDynamic = [];
  List<String> data = [];
  Icon floatingIcon = new Icon(Icons.add);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ScrollController _scrollController = new ScrollController();
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

  String _food, _quantity;
  TextEditingController foodController = new TextEditingController();
  TextEditingController quantityController = new TextEditingController();
  addDynamic() {
    if (data.length != 0) {
      floatingIcon = new Icon(Icons.add);

      data = [];
      listDynamic = [];
      //print('aaaa');
    }
    setState(() {});

    listDynamic.add(
      new Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: TextFormField(
                style: TextStyle(
                  height: 1.0,
                ),
                controller: foodController,
                autofocus: false,
                onSaved: (input) => _food = input,
                decoration: InputDecoration(
                  labelText: 'Choose your food',
                  icon: Icon(Icons.fastfood),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            new PopupMenuButton<String>(
              icon: const Icon(Icons.arrow_drop_down),
              onSelected: (String value) {
                foodController.text = value;
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
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 25.0, 0),
                child: new TextFormField(
                  controller: quantityController,
                  autofocus: false,
                  validator: (input) {
                    if (input.isEmpty) {
                      return 'Please set the quantity';
                    }
                  },
                  onSaved: (input) => _quantity = input,
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
    );
  }

  dynamicWidget dynamics = new dynamicWidget();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  void submitData() async {
    final FirebaseUser user = await _auth.currentUser();
    Firestore _firestore = new Firestore();
    try {
      //Firestore.instance.collection('meals').document().updateData({"Food": FieldValue.arrayUnion(_foodController.text),"quantity": FieldValue.arrayUnion(_quantityController.text)});
      Firestore.instance.collection('meals').document().setData(
          {'Food': foodController.text, 'quantity': quantityController.text});
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
    Widget dynamicTextField = new Flexible(
      flex: 2,
      child: new ListView.builder(
        itemCount: listDynamic.length,
        itemBuilder: (_, index) => listDynamic[index],
      ),
    );

    Widget text = new Container(
      margin: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 25.0),
      child: new Text(
        'Please select your meals and Add the quantity',
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),
      ),
    );
    Widget submitButton = new Container(
      child: new RaisedButton(
        onPressed: submitData,
        child: new Padding(
          padding: new EdgeInsets.all(16.0),
          child: new Text('Add meals'),
        ),
      ),
    );

    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: ProfileDrawer(currentUser: widget.currentUser),
        appBar: AppBar(
          title: Text(
            'Add Your Meals',
            style: TextStyle(fontSize: 30),
          ),
          backgroundColor: Colors.cyan,
          actions: <Widget>[
            IconButton(
              icon: new Icon(Icons.announcement),
              onPressed: () {},
              iconSize: 30,
            ),
            IconButton(
              icon: new Icon(Icons.notifications_none),
              onPressed: () {},
              iconSize: 30,
            )
          ],
        ),
        body: new Container(
          margin: new EdgeInsets.all(10.0),
          child: new Column(
            children: <Widget>[
              text,
              dynamicTextField,
              data.length == 0
                  ? submitButton
                  : new HomePage(user: widget.currentUser),
            ],
          ),
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: addDynamic,
          child: floatingIcon,
        ),
      ),
    );
  }
}

class dynamicWidget extends StatelessWidget {
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

  String _food, _quantity;
  TextEditingController foodController = new TextEditingController();
  TextEditingController quantityController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: TextFormField(
              style: TextStyle(
                height: 1.0,
              ),
              controller: foodController,
              autofocus: false,
              onSaved: (input) => _food = input,
              decoration: InputDecoration(
                labelText: 'Choose your food',
                icon: Icon(Icons.fastfood),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              keyboardType: TextInputType.text,
            ),
          ),
          new PopupMenuButton<String>(
            icon: const Icon(Icons.arrow_drop_down),
            onSelected: (String value) {
              foodController.text = value;
            },
            itemBuilder: (BuildContext context) {
              return items.map<PopupMenuItem<String>>((String value) {
                return new PopupMenuItem(child: new Text(value), value: value);
              }).toList();
            },
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(0.0, 0.0, 25.0, 0),
              child: new TextFormField(
                controller: quantityController,
                autofocus: false,
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please set the quantity';
                  }
                },
                onSaved: (input) => _quantity = input,
                decoration: InputDecoration(
                  labelText: 'Quantity',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
