import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp_project/Auth/login.dart';
import 'package:gp_project/Pages/homepage.dart';
import 'package:gp_project/Pages/Calendar.dart';
import 'package:gp_project/Pages/contactUs.dart';
import 'package:gp_project/Pages/profileWidget.dart';
import 'package:gp_project/models/user.dart';
import 'package:gp_project/util/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileDrawer extends StatefulWidget {
  final FirebaseUser user;
  const ProfileDrawer({Key key, this.user}) : super(key: key);
  @override
  _ProfileDrawerState createState() => _ProfileDrawerState();
}

class _ProfileDrawerState extends State<ProfileDrawer> {
  static Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection("users")
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
    );
  }

  Drawer checkRole(DocumentSnapshot snapshot) {
    if (snapshot.data == null) {
      return Drawer(
        child: Text('no data set in the userId document in firestore'),
      );
    }
    if (snapshot.data['role'] == 'doctor') {
      return docPage(snapshot);
    } else {
      return userPage(snapshot);
    }
  }

  Drawer docPage(DocumentSnapshot snapshot) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
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
                        image: DecorationImage(
                            image: NetworkImage('${snapshot.data['photo']}'),
                            fit: BoxFit.fill),
                      ),
                    ),
                    Text('${snapshot.data['name']}',
                        style: TextStyle(fontSize: 22, color: Colors.white)),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                size: 25,
              ),
              title: Text(
                'Home',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                size: 25,
              ),
              title: Text(
                'Profile',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => profileWidget()));
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text(
                'Notification',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text(
                'Help',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                'Settings',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text(
                'Contact Us',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.accessibility_new),
              title: Text(
                'Log Out',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                signOut();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => login()));
              },
            ),
          ],
        ),
      ),
    );
    /*Center(
        child: Text('${snapshot.data['role']} ${snapshot.data['name']}'));*/
  }
  Drawer userPage(DocumentSnapshot snapshot) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
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
                        image: DecorationImage(
                            image: NetworkImage('${snapshot.data['photo']}'),
                            fit: BoxFit.fill),
                      ),
                    ),
                    Text('${snapshot.data['name']}',
                        style: TextStyle(fontSize: 22, color: Colors.white)),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                size: 25,
              ),
              title: Text(
                'Home',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                size: 25,
              ),
              title: Text(
                'Profile',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => profileWidget()));
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text(
                'Notification',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.border_color),
              title: Text(
                'My Report',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.perm_identity),
              title: Text(
                'My Doctor',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.map),
              title: Text(
                'My Maps',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text(
                'My calender',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text(
                'Help',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                'Settings',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text(
                'Contact Us',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.accessibility_new),
              title: Text(
                'Log Out',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                signOut();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => login()));
              },
            ),
          ],
        ),
      ),
    ); /*(child: Text(snapshot.data['name']));*/
  }
}

