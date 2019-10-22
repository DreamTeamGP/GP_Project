import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class profileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          // Row(
          //   children: <Widget>[
          //     Image.asset('assests/pp.jpeg'),
          //   ],
          // ),
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
                "Esraa Atef",
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
                child: Text('Cairo, Egypt',
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
                child: Text('+20 01122880653',
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
                child: Text('esraamosllam@gmail.com',
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
                child: Text('5 May 1998',
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
                child: Text('female',
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