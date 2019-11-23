import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../models/user.dart';
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
import '../Pages/profileEditWidget.dart';

=======
>>>>>>> parent of 63db3ff... Merge branch 'master' into Asmaa
=======
>>>>>>> parent of 63db3ff... Merge branch 'master' into Asmaa
=======
>>>>>>> parent of 63db3ff... Merge branch 'master' into Asmaa
class profileWidget extends StatefulWidget {
  final User currentUser;
  @override
  _profileWidgetState createState() => _profileWidgetState();
  profileWidget({this.currentUser});
}

class _profileWidgetState extends State<profileWidget> {
  String gender;
  @override
  void initState() {
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    widget.currentUser.gender==1? gender = 'female': gender = 'male';
=======
    widget?.currentUser?.gender==1? gender = 'female': gender = 'male';
>>>>>>> parent of 63db3ff... Merge branch 'master' into Asmaa
=======
    widget?.currentUser?.gender==1? gender = 'female': gender = 'male';
>>>>>>> parent of 63db3ff... Merge branch 'master' into Asmaa
=======
    widget?.currentUser?.gender==1? gender = 'female': gender = 'male';
>>>>>>> parent of 63db3ff... Merge branch 'master' into Asmaa
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
  //user = this.userClass.getCurrentUser();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
          ),
          ),
        leading: Icon(Icons.menu, color: Colors.white,),
      ),
      body: Column(
        
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(15.0),
                child: new Text(
                //"${firebaseUser?.email }",
                "${widget.currentUser.name}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  
                ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 15.0, top: 7.0),
            child: Row(
            children: <Widget>[
              Icon(Icons.location_on, color: Colors.grey, size: 32.0,),
              Container(
                margin: EdgeInsets.only(left: 15.0),
<<<<<<< HEAD
                child: Text('${widget.currentUser.country}',
=======
                child: Text('${widget?.currentUser?.country}',
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> parent of 63db3ff... Merge branch 'master' into Asmaa
=======
>>>>>>> parent of 63db3ff... Merge branch 'master' into Asmaa
=======
>>>>>>> parent of 63db3ff... Merge branch 'master' into Asmaa
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                ),
            ],
          ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15.0, top: 7.0),
            child: Row(
            children: <Widget>[
              Icon(Icons.phone, color: Colors.grey, size: 32.0,),
              Container(
                margin: EdgeInsets.only(left: 15.0),
                child: Text('${widget.currentUser.phone}',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                ),
            ],
          ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15.0, top: 7.0),
            child: Row(
            children: <Widget>[
              Icon(Icons.mail, color: Colors.grey, size: 32.0,),
              Container(
                margin: EdgeInsets.only(left: 15.0),
                child: Text('${widget.currentUser.email}',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                ),
            ],
          ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15.0, top: 7.0),
            child: Row(
            children: <Widget>[
              Icon(Icons.calendar_today, color: Colors.grey, size: 32.0,),
              Container(
                margin: EdgeInsets.only(left: 15.0),
                child: Text('${widget.currentUser.birthday}',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                ),
            ],
          ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15.0, top: 7.0),
            child: Row(
            children: <Widget>[
              Icon(Icons.person, color: Colors.grey, size: 32.0,),
              Container(
                margin: EdgeInsets.only(left: 15.0),
                child: Text('${gender}',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                ),
            ],
          ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15.0, top: 7.0),
            child: Row(
            children: <Widget>[
              Icon(Icons.description, color: Colors.grey, size: 32.0,),
              Container(
                margin: EdgeInsets.only(left: 15.0),
                child: Text('Lorem ipsum dolor sit amet.',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                ),
                
            ],
          ),
          ),
        ],

      ),
      
      floatingActionButton: Container(
        width: 85.0,
        height: 85.0,
        child: FloatingActionButton(
          onPressed: (){},   
          child: Icon(Icons.edit, color: Colors.white, size: 50.0,),
        )
           
      ),
    );
  }
}