import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp_project/Auth/login.dart';
import 'package:gp_project/Pages/Calendar.dart';
import 'package:gp_project/Pages/contactUs.dart';
import 'package:gp_project/Pages/profileWidget.dart';
import 'package:gp_project/util/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileDrawer extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return 
       Drawer(
      child:SingleChildScrollView(child:  Column(children: <Widget>[
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          color: Theme.of(context).primaryColor,
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue[900],
                    shape: BoxShape.circle,
                    image: DecorationImage(image:NetworkImage('') ,
                    fit: BoxFit.fill),
                  ),
                  
                ),
                Text('Ahmed Mustafa',style: TextStyle(fontSize: 22,color: Colors.white)),
              ],
            ),
          ),
        ),
       Container( color: Colors.red,child: Text('Home',textAlign: TextAlign.left,style: TextStyle(fontSize: 22,color: Colors.cyanAccent,fontWeight:FontWeight.bold,),)),
        ListTile(leading: Icon(Icons.person,size: 25,), title: Text('Profile',style: TextStyle(fontSize: 22),),onTap: (){
           Navigator.push(context, MaterialPageRoute(builder: (context)=> profileWidget()));
        
        },),
        ListTile(leading: Icon(Icons.notifications), title: Text('Notification',style: TextStyle(fontSize: 22),),onTap: (){},),
        ListTile(leading: Icon(Icons.border_color), title: Text('My Report',style: TextStyle(fontSize: 22),),onTap: (){},),
        ListTile(leading: Icon(Icons.perm_identity), title: Text('My Doctor',style: TextStyle(fontSize: 22),),onTap: (){},),
        ListTile(leading: Icon(Icons.map), title: Text('My Maps',style: TextStyle(fontSize: 22),),onTap: (){},),
        ListTile(leading: Icon(Icons.calendar_today), title: Text('My calender',style: TextStyle(fontSize: 22),),onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> calenderPage()));
        },),
        ListTile(leading: Icon(Icons.help), title: Text('Help',style: TextStyle(fontSize: 22),),onTap: (){},),
        ListTile(leading: Icon(Icons.settings), title: Text('Settings',style: TextStyle(fontSize: 22),),onTap: (){},),
        ListTile(leading: Icon(Icons.contacts), title: Text('Contact Us',style: TextStyle(fontSize: 22),),onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> contactUs()));
        },),
        ListTile(leading: Icon(Icons.accessibility_new), title: Text('Log Out',style: TextStyle(fontSize: 22),),onTap:() async{
          FirebaseAuth.instance.signOut();
          Navigator.of(context).pushNamed('/login');
        },
         ),
        
      ],),),
    );





  }
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<void> signOut() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      FirebaseAuth.instance.signOut();
     // Navigator.popUntil(, ModalRoute.withName("/"));
    }
}