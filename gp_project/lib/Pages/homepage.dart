import 'package:flutter/material.dart';
import 'package:gp_project/Pages/profiledrawer.dart';

class HomePage extends StatefulWidget {

   

  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
 var mood=['mood'];
 var month=['month'];

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
       // floatingActionButton: FloatingActionButton(child: Icon(Icons.person),onPressed: (){},),
          drawer: ProfileDrawer(),
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
              onChanged: (String value) {},
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
              onChanged: (String value) {},
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
