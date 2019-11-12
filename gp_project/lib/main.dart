import 'package:flutter/material.dart';
import 'Auth/login.dart';
import 'Pages/Listdoctors.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.cyan,

      ),
      home: login(),
      debugShowCheckedModeBanner: false,
      
    );
  }
}

