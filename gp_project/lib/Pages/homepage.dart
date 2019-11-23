import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp_project/Classes/User.dart';
import 'package:gp_project/Pages/profiledrawer.dart';
import 'package:gp_project/models/user.dart';

class HomePage extends StatefulWidget {

   

  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
  var mood=['mood'];
  var month=['month'];
  UserClass userClass = new UserClass();
  User user = new User();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  User currentUser = new User();

  initUser() async {
    //firebaseUser = await _firebaseAuth.currentUser();
    //userID = firebaseUser.uid;
    currentUser = this.userClass.getCurrentUser();
    setState(() {
    });
  }
  @override
  void initState() {
    super.initState();
    initUser(); 
  }
=======
  var mood = ['mood'];
  var month = ['month'];
>>>>>>> parent of 63db3ff... Merge branch 'master' into Asmaa
=======
  var mood = ['mood'];
  var month = ['month'];
>>>>>>> parent of 63db3ff... Merge branch 'master' into Asmaa
=======
  var mood = ['mood'];
  var month = ['month'];
>>>>>>> parent of 63db3ff... Merge branch 'master' into Asmaa

 final List<String> _dropdownValues = [
    "One",
    "Two",
    "Three",
    "Four",
    "Five"
  ]; //The list of values we want on the dropdown

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  debugShowCheckedModeBanner: false,
      home: Scaffold(
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
       // floatingActionButton: FloatingActionButton(child: Icon(Icons.person),onPressed: (){},),
          drawer: ProfileDrawer(currentUser: currentUser,),
        appBar: AppBar(title: Text('Home'), backgroundColor: Colors.cyan,),
        body: Container(
          margin: EdgeInsets.only(left: 10,right: 10),
          padding: EdgeInsets.only(top:20,bottom: 20),
          child: ListView(
            // scrollDirection: Axis.horizontal,
            children: <Widget>[
           RaisedButton(child:Row(children: <Widget>[Icon(Icons.list,size:35,),
           Text('  New Measurment',style: TextStyle(fontSize: 25,color: Colors.white),)],),
           onPressed:(){
              //Navigator.push(context, MaterialPageRoute(builder: (context)=> Measurement()));

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      title: Text('Measurement'),
                      titleTextStyle: TextStyle (
                        backgroundColor: Colors.cyan,
                        fontSize: 25.0, 
                      ), 
                      content: Container(
                        padding: EdgeInsets.all(5.0),
                        width: 230.0,
                        height: 110.0,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(5.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: new InputDecoration(
                                    hintText: 'Enter measurement in mg/dL',
=======
=======
>>>>>>> parent of 63db3ff... Merge branch 'master' into Asmaa
=======
>>>>>>> parent of 63db3ff... Merge branch 'master' into Asmaa
        // floatingActionButton: FloatingActionButton(child: Icon(Icons.person),onPressed: (){},),
        drawer: ProfileDrawer(user: widget.user),
        appBar: AppBar(
          title: Text(
            'Home',
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
        body: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection('users')
              .document(widget.user.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return checkRole(snapshot.data);
            }
            return LinearProgressIndicator();
          },
        ),
      ),
    );
  }

  FutureBuilder checkRole(DocumentSnapshot snapshot) {
    if (snapshot.data == null) {
      return FutureBuilder(
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child:Text("Loading ..."),
            );
          }else{
            return new Text('no data set in the userId document in firestore');
          }
        },
      );
    }
    if (snapshot.data['role'] == 'doctor') {
      return docPage(snapshot);
    } else {
      return userPage(snapshot);
    }
  }

  FutureBuilder docPage(DocumentSnapshot snapshot) {
    return FutureBuilder(
        future: _data,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text("Loading ..."),
            );
          } else {
            return new Column(
              children: <Widget>[
                new Container(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 20.0, bottom: 0.0, right: 10.0, left: 10.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 30.0),
                          width: 130.0,
                          height: 21.0,
                          child: Text(
                            "Patient name",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              //fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          height: 20.0,
                          width: 70,
                        ),
                        Flexible(
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.only(top: 30.0),
                              width: 65.0,
                              height: 21.0,
                              child: Text(
                                "Profile",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  //fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 20.0,
                          width: 50,
                        ),
                        Flexible(
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.only(top: 30.0, left: 10),
                              width: 100.0,
                              height: 47.0,
                              child: Text(
                                "Print report",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                new Expanded(
                  child: new ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                top: 0.0, bottom: 0.0, right: 10.0, left: 10.0),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 10.0),
                                  width: 130.0,
                                  height: 40.0,
                                  child: Text(
                                    snapshot.data[index].data["name"],
                                    style: TextStyle(
                                      fontSize: 21,
                                      //fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
>>>>>>> parent of 63db3ff... Merge branch 'master' into Asmaa
                                  ),
                                ),
                              ),
                              
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(2.0),
                                  child: RaisedButton(
                                    child: Text(
                                      'Record',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    color: Colors.cyan,
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();
                                      }
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ));
                });
          
            
                          
                
           },color: Colors.cyanAccent[200],shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),),
            RaisedButton(child:Row(children: <Widget>[Icon(Icons.fastfood,size: 35),
            Text('  Meal Intake',style:TextStyle(fontSize: 25,color: Colors.white),)],),
            onPressed:(){},color: Colors.red,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),),
            RaisedButton(child:Row(children: <Widget>[Icon(Icons.tag_faces,size:35),
            Text('  Mood',style:TextStyle(fontSize: 25,color: Colors.white),)],)
            ,onPressed:(){
             //Navigator.push(context, MaterialPageRoute(builder: (context)=> DropdownButtonAletDialog()));
  
              showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Dropdown Button'),
            content: DropdownButton(
              items: _dropdownValues
                  .map((value) => DropdownMenuItem(
                        child: Text(value),
                        value: value,
                      ))
                  .toList(),
              onChanged: (String value) {},
              isExpanded: false,
              hint: Text('Select Number'),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });

            },color:Colors.yellow,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),),
            RaisedButton(child:Row(children: <Widget>[Icon(Icons.person,size:35),
            Text('  Profile',style:TextStyle(fontSize: 25,color: Colors.white),)],)
            ,onPressed:(){},color:Colors.green,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),),             
         Padding(padding: EdgeInsets.only(top: 10,bottom:0),child: 
         Text('Statistics Bar Chart',style:TextStyle(fontWeight:FontWeight.bold,fontSize: 28),)),
          Row(children: <Widget>[
            Expanded(child: DropdownButton<String>(
              items: mood.map((String value){
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              value: 'mood',
             // onChanged: (){},
            )),
            Expanded(child: DropdownButton<String>(
              items: month.map((String value){
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              value: 'month',
             // onChanged: (){},
            )),
          ],),
          //Column(children: <Widget>[chartdisplay],),
          
          ],),
          
        ),
    ),
    
    );
     
  }
}
